#include <Arduino.h>
#include "definitions.h"

uint8_t oled_buffer[OLED_SCREEN_WIDTH + 1];
uint8_t oled_buffer_index = 0;

volatile uint16_t adc_values[4];
volatile uint8_t adc_count = 0;
volatile uint8_t pwm = 0;
volatile double adc;
volatile double target_adc = ADC_STBY;
volatile double target_adc_prev = ADC_STBY;
volatile double pid_val;
volatile state_t state = STATE_STANDBY;
volatile state_t last_state = STATE_OFF;
volatile uint8_t adc_set_changed = 0;
uint16_t adc_set[3] = {ADC_SET1, ADC_SET2, ADC_SET3};
uint8_t buttons[3] = {SW_T1, SW_T2, SW_T3};
uint8_t click_count[3] = {0, 0, 0};
uint8_t stb_count = 0;
uint8_t selected_set = 0;
uint8_t clear_screen = 0;
double kp = 0.4;
double ki = 0.008;
double kd = 0.0;

#ifdef USE_SSD1306
Adafruit_SSD1306 oled(OLED_SCREEN_WIDTH, OLED_SCREEN_HEIGHT, &Wire, OLED_RESET);
#endif

#ifdef USE_TFT_RESET
TFT_ILI9163C tft = TFT_ILI9163C(TFT_CS,  TFT_DC, STBY_NO);
#else
TFT_ILI9163C tft = TFT_ILI9163C(TFT_CS,  TFT_DC);
#endif

PID pid((double*)&adc, (double*)&pid_val, (double*)&target_adc, kp, ki, kd, DIRECT);

uint16_t getTemperature(double adc) {
    return round(adc < 230 ? (adc * 0.3886 + 61) : (adc * 0.3374 + 73));
}

uint16_t EEPROMreadInt(uint8_t index) {
    uint8_t h_byte, l_byte;

    l_byte = EEPROM.read(index);
    h_byte = EEPROM.read(index + 1);
    return l_byte + ((h_byte << 8) & 0xFF00);
}

void EEPROMwriteInt(uint16_t value, uint8_t index) {
    uint8_t h_byte, l_byte;

    l_byte = value & 0xFF;
    h_byte = (value >> 8) & 0xFF;
    EEPROM.write(index, l_byte);
    EEPROM.write(index + 1, h_byte);
}

uint16_t readADC(void) {
    uint16_t temp[8], tmp;
    uint8_t size = 8;

	analogRead(ADC_PIN);

    for (int i = 0; i < size; i++) {
        temp[i] = analogRead(ADC_PIN);
        delayMicroseconds(2);
    }

    // sort
    for(int i = 0; i < (size - 1); i++) {
        for(int j = 0; j < (size - (i + 1)); j++) {
                if(temp[j] > temp[j + 1]) {
                    tmp = temp[j];
                    temp[j] = temp[j + 1];
                    temp[j + 1] = tmp;
                }
        }
    }

    // median
    return (temp[size / 2 - 1] + temp[size / 2]) / 2;
}

// timer interrupt
ISR(TIMER2_OVF_vect) {
    noInterrupts();

    delayMicroseconds(1600);
    digitalWrite(HEARTBEAT_PIN, HIGH);

    adc_values[adc_count] = readADC();
    adc_count++;
    if (adc_count == 4) {
        adc_count = 0;
        uint16_t tmp = 0;
        for (uint8_t i = 0; i < 4; i++) {tmp += adc_values[i];}
        adc = double(tmp / 4.0);
        /*if (target_adc > 0) {
            double err = abs(target_adc - adc);
            if (err < 20) {
                kp = 0.2;
                ki = 0.1;
                kd = 0.0;
                pid.SetTunings(kp, ki, kd);
            } else {
                if (err < 60) {
                    kp = 0.01;
                    ki = 0.0;
                    kd = 0.0;
                    pid.SetTunings(kp, ki, kd);
                } else {
                    kp = 0.2;
                    ki = 0.0;
                    kd = 0.0;
                    pid.SetTunings(kp, ki, kd);
                }
            }
        }*/

        pid.Compute();
        pwm = pid_val;
        analogWrite(HEATER_PWM_PIN, pwm);
    }

    // read buttons
    if (digitalRead(SW_STBY) == LOW) stb_count++; else stb_count = 0;

    for (uint8_t i = 0; i < 3; i++) {
        if (digitalRead(buttons[i]) == LOW) {
            if (click_count[i] >= LONG_PRESS) {
                if (state == STATE_ON) {
                    if (adc_set[i] != target_adc) adc_set_changed = 1;
                    adc_set[i] = target_adc;
                    selected_set = i + 1;
                }
            } else click_count[i]++;
        } else {
            if (click_count[i] >= SHORT_PRESS) {
                selected_set = i + 1;
                target_adc = adc_set[i];
                state = STATE_ON;
            }
            click_count[i] = 0;
        }
    }

    if (stb_count == SHORT_PRESS) {
        selected_set = 0;
        switch (state) {
            case STATE_OFF:
                state = STATE_STANDBY;
                target_adc = ADC_STBY;
                last_state = STATE_OFF;
                break;

            case STATE_ON:
                state = STATE_STANDBY;
                target_adc = ADC_STBY;
                last_state = STATE_ON;
                break;

            case STATE_STANDBY:
                if (last_state == STATE_OFF) {
                    state = STATE_ON;
                    target_adc = adc_set[0];
                } else {
                    state = STATE_OFF;
                    target_adc = 0;
                }
                last_state = STATE_STANDBY;
                break;

            default:
                break;
        }
        stb_count = 0;
    }

    digitalWrite(HEARTBEAT_PIN, LOW);
    interrupts();
}

void isr_rotaryy_encoder(void) {
    static unsigned long lastInterruptTime = 0;
    unsigned long interruptTime = millis();

    noInterrupts();
    if (state == STATE_ON) {
        if (abs(interruptTime - lastInterruptTime) > 8) {
            selected_set = 0;
            if (digitalRead(RE_CLK) != digitalRead(RE_DT)) {
                if (target_adc < ADC_MAX) target_adc += TEMP_STEP;
            } else {
                if (target_adc > ADC_MIN) target_adc -= TEMP_STEP;
            }
        }
    }
    lastInterruptTime = interruptTime;
    interrupts();
}

void serial_output(void) {
#ifdef USE_SERIAL
    char *pstr, buffer[64], kp_c[8], ki_c[8], kd_c[8], adc_c[8], target_adc_c[8], pid_val_c[8];
    dtostrf(kp, 4, 3, kp_c);
    dtostrf(ki, 4, 3, ki_c);
    dtostrf(kd, 4, 3, kd_c);
    dtostrf(adc, 4, 3, adc_c);
    dtostrf(target_adc, 4, 3, target_adc_c);
    dtostrf(pid_val, 4, 3, pid_val_c);
    sprintf(buffer, "%s;%s;%s;%d;%d;%s\n", kp_c, ki_c, kd_c, int(adc), int(target_adc), pid_val_c);
    pstr = buffer;
    while (*pstr != 0) {
        // wait till the data has been transmitted
        while (!( UCSR0A & (1<<UDRE0)));
        UDR0 = *pstr++;
    }
#endif
}

void display_oled(void) {
#ifdef USE_SSD1306
    	oled.clearDisplay();
    	oled.setTextSize(1);
		oled.setTextColor(WHITE);
		oled.setCursor(0,0);
		oled.print("PWM: ");
		oled.println(pwm);
		oled.setCursor(0,10);
		oled.print("ADC: ");
		oled.println(adc);
		oled.setCursor(0,20);
		oled.print("TGT: ");
		oled.println(target_adc);
		// graph
		/*for (int i = 0; i < OLED_SCREEN_WIDTH - OLED_SCREEN_OFFSET; i++) {
			uint8_t pixelColor = SSD1306_WHITE;
			if (oled_buffer[i] > 0) {
				oled.drawPixel(i + OLED_SCREEN_OFFSET, OLED_SCREEN_HEIGHT - 1 - oled_buffer[i], SSD1306_WHITE);
			}
		}
		// ca. 60 sec
		if (oled_buffer_index == OLED_SCREEN_DIVIDER) {
			// shift buffer for one pixel right
			for (int i = OLED_SCREEN_WIDTH; i > 0; i--) {
				oled_buffer[i] = oled_buffer[i - 1];
			}
			int value = (cur_t - TEMP_MIN) / 8;
			if (value < 0) value = 0;
			if (value >= OLED_SCREEN_HEIGHT) value = OLED_SCREEN_HEIGHT - 1;
			oled_buffer[0] = value;
			oled_buffer_index = 0;
		} else oled_buffer_index++;*/
		oled.display();
#endif
}

void display_tft(void) {
    uint16_t text_color;
    uint8_t height = 64;
    uint8_t width = 10;
    uint8_t origin_x = 149;
    uint8_t	origin_y = 24;

    if (state == STATE_ERROR) {
        if (clear_screen == 1) {tft.fillScreen(TFT_BLACK); clear_screen = 0;}
        tft.setTextSize(3);
        tft.setTextColor(TFT_RED, TFT_BLACK);
        tft.setCursor(10,26);
        tft.print(F("ERROR"));
        tft.setTextSize(2);
        tft.setCursor(10,60);
        if (adc == 1023) tft.print(F("No tip"));
        else tft.print(F("Not heating"));
        return;
    }

    uint16_t temperature = getTemperature(adc);

    if (state == STATE_STANDBY) {text_color = TFT_YELLOW;}
    else {
        if (state == STATE_OFF) {text_color = TFT_RED;}
        else if (state == STATE_ON) {text_color = TFT_GREEN;}
    }
    tft.drawCircle(20, 63, 8, text_color);
    tft.drawCircle(20, 63, 7, text_color);
    tft.fillRect(19, 55, 3, 3, TFT_BLACK);
    tft.drawFastVLine(20, 53, 10, text_color);

    tft.setTextSize(2);
    tft.setCursor(15,112);
    if (selected_set == 1) tft.setTextColor(TFT_GREEN, TFT_BLACK); else tft.setTextColor(TFT_WHITE, TFT_BLACK);
    tft.print(round(getTemperature(adc_set[0])));
    tft.write(' ');
    if (selected_set == 2) tft.setTextColor(TFT_GREEN, TFT_BLACK); else tft.setTextColor(TFT_WHITE, TFT_BLACK);
    tft.print(round(getTemperature(adc_set[1])));
    tft.write(' ');
    if (selected_set == 3) tft.setTextColor(TFT_GREEN, TFT_BLACK); else tft.setTextColor(TFT_WHITE, TFT_BLACK);
    tft.print(round(getTemperature(adc_set[2])));

    tft.setCursor(40,26);
    tft.setTextSize(3);
    if (state == STATE_STANDBY) {
        tft.setTextColor(text_color, TFT_BLACK);
        tft.print(F("STBY "));
        tft.fillRect(origin_x - 1, origin_y - 1, width + 2, height + 2, TFT_BLACK);
    } else if (state == STATE_OFF) {
        tft.setTextColor(text_color, TFT_BLACK);
        tft.print(F("OFF  "));
        tft.fillRect(origin_x - 1, origin_y - 1, width + 2, height + 2, TFT_BLACK);
    } else {
        tft.setTextColor(TFT_GREEN, TFT_BLACK);
        tft.print(getTemperature(target_adc));
        tft.write(247);
        tft.write('C');

        uint8_t y = (target_adc - ADC_MIN) * height / (ADC_MAX - ADC_MIN);
        uint8_t x = y * width / height;
        if (target_adc != target_adc_prev) {
            target_adc_prev = target_adc;
            tft.fillRect(origin_x - 1, origin_y - 1, width + 2, height + 2, TFT_BLACK);
        }
        tft.fillTriangle(origin_x + width - x, origin_y + height - y, origin_x + width, origin_y + height - y, origin_x + width, origin_y + height, TFT_GREEN);
    }

    tft.setCursor(40,56);
    if (adc == 0) {
        tft.setTextColor(TFT_CYAN, TFT_BLACK);
        tft.print(F("COLD  "));
    } else {
        tft.setTextColor(TFT_WHITE, TFT_BLACK);
        if (temperature < 100) tft.write(' ');
        if (temperature < 10) tft.write(' ');
        tft.print(temperature);
        tft.write(247);
        tft.write('C');
    }

    uint8_t x = pwm * 160 / PID_MAX;
    uint8_t xb = 0;
    if (x > 0) xb = x + 1;
    for (int y = 0; y < 4; y++) {
        tft.drawFastHLine(0, y, x, TFT_GREEN);
        tft.drawFastHLine(xb, y, 160 - xb, TFT_BLACK);
    }
}

void setup(void) {
    // Phase Corrected PWM Mode 1
    // TCCR2A: 33 = 00100001
    // COM2A1: 0
    // COM2A0: 0
    // COM2B1: 1
    // COM2B0: 0
    // -
    // -
    // WGM21 : 0
    // WGM20 : 1

    // TCCR2B: 5 = 00000101
    // FOC2A : 0
    // FOC2B : 0
    // -
    // -
    // WGM22 : 0
    // CS22  : 1
    // CS21  : 0
    // CS20  : 1

    // TIMSK2: 0
    // OCR2A : 0
    // OCR2B : 64 = 01000000

    pinMode(HEARTBEAT_PIN, OUTPUT);
    pinMode(HEATER_PWM_PIN, OUTPUT);
    digitalWrite(HEATER_PWM_PIN, LOW);
    pinMode(ADC_PIN, INPUT);
    pinMode(SW_T1,INPUT_PULLUP);
    pinMode(SW_T2,INPUT_PULLUP);
    pinMode(SW_T3,INPUT_PULLUP);
    pinMode(SW_STBY,INPUT_PULLUP);
    pinMode(RE_CLK,INPUT_PULLUP);
    pinMode(RE_DT,INPUT_PULLUP);
    pinMode(STBY_NO, INPUT_PULLUP);
    pinMode(TFT_CS, OUTPUT);
    digitalWrite(TFT_CS, HIGH);

    pid.SetMode(AUTOMATIC);
    pid.SetOutputLimits(0, PID_MAX);
    pid.SetSampleTime(8);

    attachInterrupt(digitalPinToInterrupt(RE_CLK), isr_rotaryy_encoder, FALLING);

#ifdef USE_EXTERNAL_AREF
    analogReference(EXTERNAL);
#endif

    // Frequenz fuer PWM
    // For Arduino using ATmega8, 168 or 328* (m8, m168, m328, m238p)
    // Phase-corrected PWM by default
    // B00000xxx - 3 last bits (least significant bit or LSB) decide the divisor of the timer
    // Frequency = 16Mhz / (256 * divisor)
    // Example: divisor = 1, frequency = 16Mhz / (256) = 62.5Khz,
    //----- PWM frequency for D3 & D11 -----
    //PWM Prescaler = 1024 31Hz
    //TCCR2B = (TCCR2B & 0b11111000) | 7;
    //PWM Prescaler = 256 122Hz
    //TCCR2B = (TCCR2B & 0b11111000) | 6;
    //PWM Prescaler = 128 245Hz
    TCCR2B = (TCCR2B & 0b11111000) | 5;
    //PWM Prescaler = 64  490Hz
    //TCCR2B = (TCCR2B & 0b11111000) | 4;
    //PWM Prescaler = 32  980Hz
    //TCCR2B = (TCCR2B & 0b11111000) | 3;
    //PWM Prescaler = 8  3.9kHz
    //TCCR2B = (TCCR2B & 0b11111000) | 2;
    //PWM Prescaler = 1    31kHz - no Noise
    //TCCR2B = (TCCR2B & 0b11111000) | 1;
    TIMSK2 = (1<<TOIE2); // interrupt when TCNT2 is overflowed

    // serial port
#ifdef USE_SERIAL
    // baud rate
    // UBRRn = Fosc / 16 * baudrate - 1
    // 16000000 / 16 * 115200 - 1
    // 16000000 / 1843200 - 1 = 7.68
    // write to lower byte
    UBRR0L = (uint8_t)(8 & 0xFF);
    // write to higher byte
    UBRR0H = (uint8_t)(8 >> 8);
    // enable the transmitter and receiver
    UCSR0B |= (1 << RXEN0) | (1 << TXEN0);
#endif

    // console
#ifdef USE_SSD1306
    oled.begin(SSD1306_SWITCHCAPVCC, OLED_ADDR);
    oled.display();
    oled.clearDisplay();
    for (int i = 0; i < OLED_SCREEN_WIDTH; i++) {oled_buffer[i] = -1;}
#endif

    // tft
    tft.begin();
    tft.colorSpace(RGB_DISP);
    tft.setRotation(3);
    tft.fillScreen(TFT_BLACK);

    uint16_t check;
    uint8_t addr = 0x00;
    EEPROM.get(addr, check);
    if (check == EEPROM_CHECK) {
        addr += sizeof(check);
        EEPROM.get(addr, adc_set);
    } else {
        // first run, save default values
        EEPROM.put(addr, EEPROM_CHECK);
        addr += sizeof(check);
        EEPROM.put(addr, adc_set);
    }
}

/* *************** MAIN *************** */
int main(void) {
    uint32_t sendNext;

    init();
    setup();

    sendNext = millis();
    while (true) {
        display_oled();
        display_tft();
        if (sendNext <= millis()) {sendNext += 100; serial_output();}

        if (adc_set_changed == 1) {
            uint16_t check = EEPROM_CHECK;
            uint8_t addr = 0x00;
            addr += sizeof(check);
            EEPROM.put(addr, adc_set);
            adc_set_changed = 0;
        }

        if ((state == STATE_ON || state == STATE_STANDBY) && (adc == 1023 || adc < 100)) {
            target_adc = 0;
            state = STATE_ERROR;
            clear_screen = 1;
        }

        delay(50);
    }
}
