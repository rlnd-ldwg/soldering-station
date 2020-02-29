#include <SPI.h>
#include <Wire.h>
#include <TFT_ILI9163C.h>
#include <PID_v1.h>
#include <EEPROM.h>
#include <TimerOne.h>
#include <Adafruit_NeoPixel.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include "definitions.h"

#define USE_SSD1306
#define USE_NEOPIXEL
//#define USE_SERIAL
//#define USE_LIPO
#define USE_EXTERNAL_AREF

/*
 * If your display stays white, uncomment this.
 * Cut reset trace (on THT on upper layer/0R), connect STBY_NO (A1) with reset of TFT (at 4050).
 * See also readme in mechanical folder for reference.
 */
#define USE_TFT_RESET

/*
 * If red is blue and blue is red change this
 * If not sure, leave commented, you will be shown a setup screen
 */
#define HARDWARE_DEFINED_TFT 	1
#define HARDWARE_REVISION 		3

/*
 * Only used for testing, do not use.
 */
//#define INSTALL

volatile boolean off = true, stby = true, stby_layoff = false, clear_display = true, store_invalid = true, menu = false;
volatile uint8_t pwm, threshold_counter;
volatile int16_t cur_t, last_measured;
volatile error_type error = NO_ERROR;
error_type error_old;
int16_t stored[3] = {300, 350, 450}, set_t = TEMP_MIN, set_t_old, cur_t_old, target_t;
double pid_val, cur_td, set_td;
uint8_t store_to = 255;
p_source power_source, power_source_old = NO_INIT;
boolean blink;
uint16_t cnt_measure_voltage, cnt_compute, cnt_sw_poll, cnt_but_press, cnt_off_press, cnt_but_store;
float v_c1, v_c2, v_c3, v_in, v;
uint8_t array_index, array_count;
uint32_t sendNext;
uint32_t last_temperature_drop;
uint32_t last_on_state;
boolean wasOff = true, old_stby = false;
boolean autopower = true, bootheat = false, fahrenheit = false;
uint8_t revision = 1;
boolean menu_dismissed = false;
boolean autopower_repeat_under = false;
boolean force_redraw = false;
boolean power_down = false;
uint16_t charge = 0;
float adc_offset = ADC_TO_TEMP_OFFSET;
float adc_gain = ADC_TO_TEMP_GAIN;
uint16_t adc;

#define RGB_DISP 0x0
#define BGR_DISP 0x2

#ifdef USE_TFT_RESET
TFT_ILI9163C tft = TFT_ILI9163C(TFT_CS,  TFT_DC, STBY_NO);
#else
TFT_ILI9163C tft = TFT_ILI9163C(TFT_CS,  TFT_DC);
#endif
#define	TFT_BLACK   0x0000
#define	TFT_BLUE    0x001F
#define	TFT_RED     0xF800
#define	TFT_GREEN   0x07E0
#define TFT_CYAN    0x07FF
#define TFT_MAGENTA 0xF81F
#define TFT_YELLOW  0xFFE0
#define TFT_WHITE   0xFFFF
#define TFT_GRAY    0x94B2

#define RE_NONE  0
#define RE_LEFT1 1
#define RE_LEFT2 2
#define RE_LEFT3 3
#define RE_RIGHT1  4
#define RE_RIGHT2  5
#define RE_RIGHT3  6

#define STBY_LIGTHNESS_MAX 	96
#define STBY_LIGTHNESS_MIN 	32
#define STBY_LIGTHNESS_STEP 1
#define NEO_BRIGHTNESS 		32
#define NUM_LED 			12

PID heaterPID(&cur_td, &pid_val, &set_td, kp, ki, kd, DIRECT);

#ifdef USE_NEOPIXEL
	Adafruit_NeoPixel neo_ring = Adafruit_NeoPixel(NUM_LED, NEOPIXEL, NEO_GRB + NEO_KHZ800);
#endif

#define OLED_SCREEN_WIDTH	128
#define OLED_SCREEN_HEIGHT	32
#define OLED_SCREEN_OFFSET 	32
#define OLED_SCREEN_DIVIDER	1
#define OLED_RESET 			4
#define OLED_ADDR 			0x3C

#ifdef USE_SSD1306
Adafruit_SSD1306 oled(OLED_SCREEN_WIDTH, OLED_SCREEN_HEIGHT, &Wire, OLED_RESET);
#endif
uint8_t oled_buffer[OLED_SCREEN_WIDTH + 1];
uint8_t oled_buffer_index = 0;

int re_state = RE_NONE;
int re_dt = -1;
int re_clk = -1;
uint32_t re_millis = 0;
int neo_lightness = STBY_LIGTHNESS_MAX;
bool neo_lightness_direction = true;

/* *************** FUNCTIONS *************** */
void setError(error_type e);

void updateEEPROM(void) {
	EEPROM.update(1, stby);
	for (uint8_t i = 0; i < 3; i++) {
		EEPROM.update(2+i*2, stored[i] >> 8);
		EEPROM.update(3+i*2, stored[i] & 0xFF);
	}
	EEPROM.update(8, set_t >> 8);
	EEPROM.update(9, set_t & 0xFF);
	EEPROM.update(EEPROM_OPTIONS, (fahrenheit << 2) | (bootheat << 1) | autopower);
}

void setDisplayMode(boolean bgr) {
	tft.colorSpace(bgr);
	tft.setRotation(3);
}

void updateRevision(void) {
#if (HARDWARE_REVISION > 2)
	EEPROM.update(EEPROM_REVISION, HARDWARE_REVISION);
	revision = 3;
#else
	if (EEPROM.read(EEPROM_VERSION) < 26 || EEPROM.read(EEPROM_REVISION) > 100) {
		EEPROM.update(EEPROM_REVISION, 2);
		revision = 2;
	} else {
		revision = EEPROM.read(EEPROM_REVISION);
	}
#endif
}

void optionMenu(void) {
#ifndef USE_NEOPIXEL
	digitalWrite(HEAT_LED, LOW);
#endif
	tft.fillScreen(TFT_BLACK);
	tft.setTextSize(2);
	tft.setCursor(0,0);
	tft.setTextColor(TFT_WHITE);
	tft.println("Options\n");
	tft.setTextColor(TFT_WHITE);
	tft.setCursor(10,112);
	tft.print("ON  OFF EXIT");
	uint8_t options = 3;
	uint8_t opt = 0;
	boolean redraw = true;
	int dt = -1;
	int clk = -1;
	while (true) {
		if (redraw) {
			tft.setCursor(0,36);
			#ifdef SHUTOFF_ACTIVE
				tft.setTextColor(autopower?TFT_GREEN:TFT_RED);
			#else
				tft.setTextColor(TFT_GRAY);
			#endif
			tft.println(" Autoshutdown");
			#ifdef BOOTHEAT_ACTIVE
				tft.setTextColor(bootheat?TFT_GREEN:TFT_RED);
			#else
				tft.setTextColor(TFT_GRAY);
			#endif
			tft.println(" Heat on boot");
			tft.setTextColor(fahrenheit?TFT_GREEN:TFT_RED);
			tft.println(" Fahrenheit");

			tft.setCursor(0, (opt+2)*18);
			tft.setTextColor(TFT_WHITE);
			tft.print(">");
			redraw = false;
		}

		dt = 0;
		clk = 0;
		for (int i = 0; i < 100; i++) {
			dt += digitalRead(RE_DT);
			clk += digitalRead(RE_CLK);
		}
		if (dt > 75) dt = 1; else dt = 0;
		if (clk > 75) clk = 1; else clk = 0;
		if (dt != re_dt || clk != re_clk) {
			re_dt = dt;
			re_clk = clk;

			if (clk == LOW && dt == HIGH) {
				 if (re_state == RE_NONE) {re_state = RE_RIGHT1;}
				 else if (re_state == RE_LEFT2) {
					// UP
					re_state = RE_LEFT3;
					tft.setCursor(0, (opt+2)*18);
					tft.setTextColor(TFT_BLACK);
					tft.print(">");
					opt = (opt+options-1)%options;
					redraw = true;
				 }
			}

			if (clk == LOW && dt == LOW) {
				if (re_state == RE_RIGHT1) {re_state = RE_RIGHT2;}
				else if (re_state == RE_LEFT1) {re_state = RE_LEFT2;}
			}

			if (clk == HIGH && dt == LOW) {
				if (re_state == RE_RIGHT2) {
					//DOWN
					re_state = RE_RIGHT3;
					tft.setCursor(0, (opt+2)*18);
					tft.setTextColor(TFT_BLACK);
					tft.print(">");
					opt = (opt+1)%options;
					redraw = true;
				}
				else if (re_state == RE_NONE) {re_state = RE_LEFT1;}
			}

			if (clk == HIGH && dt == HIGH) {
				if (re_state == RE_RIGHT3) {re_state = RE_NONE;}
				else if (re_state == RE_LEFT3) {re_state = RE_NONE;}
			}
		}

		if (!digitalRead(SW_T1)) {
			switch (opt) {
				case 0: autopower = 1; break;
				case 1: bootheat = 1; break;
				case 2: fahrenheit = 1; break;
			}
			redraw = true;
		}
		if (!digitalRead(SW_T2)) {
			switch (opt) {
				case 0: autopower = 0; break;
				case 1: bootheat = 0; break;
				case 2: fahrenheit = 0; break;
			}
			redraw = true;
		}
		if (!digitalRead(SW_T3)) break;
	}
	EEPROM.update(EEPROM_OPTIONS, (fahrenheit << 2) | (bootheat << 1) | autopower);
	updateRevision();
	EEPROM.update(EEPROM_VERSION, EE_VERSION);
	if (EEPROM.read(EEPROM_VERSION) < 30) {
		EEPROM.put(EEPROM_ADCTTG, ADC_TO_TEMP_GAIN);
		EEPROM.put(EEPROM_ADCOFF, ADC_TO_TEMP_OFFSET);
	}
	menu_dismissed = true;
}

void measureVoltage(void) {
	analogRead(BAT_C1); //Switch analog MUX before measuring
	v_c1 = v_c1*.9+(analogRead(BAT_C1)*5/1024.0)*.1; //no divisor
	analogRead(BAT_C2);
	v_c2 = v_c2*.9+(analogRead(BAT_C2)*5/512.0)*.1; //divisor 1:1 -> /2
	analogRead(BAT_C3);
	v_c3 = v_c3*.9+(analogRead(BAT_C3)*(5.0*3.0)/1024.0)*.1; //maximum measurable is ~15V
	v = v_c3;
#ifdef VIN
	analogRead(VIN);
	v_in = v_in*.9+(analogRead(VIN)*25/1024.0)*.1; //maximum measurable is ~24.5V
	v = v_in; //backwards compatibility
#endif
}

uint16_t median(uint8_t analogIn) {
	uint16_t adcValue[3];
	for (uint8_t i = 0; i < 3; i++) {
		adcValue[i] = analogRead(analogIn); // read the input 3 times
	}
	uint16_t tmp;
	if (adcValue[0] > adcValue[1]) {
		tmp = adcValue[0];
		adcValue[0] = adcValue[1];
		adcValue[1] = tmp;
	}
	if (adcValue[1] > adcValue[2]) {
		tmp = adcValue[1];
		adcValue[1] = adcValue[2];
		adcValue[2] = tmp;
	}
	if (adcValue[0] > adcValue[1]) {
		tmp = adcValue[0];
		adcValue[0] = adcValue[1];
		adcValue[1] = tmp;
	}
	return adcValue[1];
}

int getTemperature(void) {
	analogRead(TEMP_SENSE);//Switch ADC MUX
	adc = median(TEMP_SENSE);

	if (adc >= 900) { //Illegal value, tip not plugged in - would be around 560deg
		analogWrite(HEATER_PWM, 0);
		if (!off)
			setError(NO_TIP);
		return 999;
	} else {
		analogWrite(HEATER_PWM, pwm); //switch heater back to last value
	}
	//return round(adc < 210 ? (((float)adc) * 0.540805) : (((float)adc) * 0.4163 + 30));
	return round(((float) adc) * adc_gain + adc_offset);
}

void setStandby(boolean state) {
	if (stby_layoff) return;
	if (state == stby) return;
	stby = state;
	last_measured = cur_t;
	last_temperature_drop = millis();
	last_on_state = millis()/1000;
	EEPROM.update(1, stby);
}

void setOff(boolean state) {
	if (state == off) return;
	if (!state)
		analogWrite(HEATER_PWM, 0);
	else
		setStandby(false);
	if (power_source == POWER_USB && !state) {
		state = true; //don't switch on, if powered via USB
		setError(USB_ONLY);
	}
	last_on_state = millis()/1000;
	off = state;
	wasOff = true;
	last_measured = cur_t;
}

void rotary_encoder() {

	int dt = digitalRead(RE_DT);
	int clk = digitalRead(RE_CLK);
	uint32_t now = millis();

	if (dt != re_dt || clk != re_clk) {
		re_dt = dt;
		re_clk = clk;

		if (clk == LOW && dt == HIGH) {
			 if (re_state == RE_NONE) {re_state = RE_RIGHT1;}
			 else if (re_state == RE_LEFT2) {
				// temp +
				re_state = RE_LEFT3;
				setStandby(false);
				if (now - re_millis < 100) set_t += 10;
				else set_t += 5;
				if(set_t > TEMP_MAX) set_t = TEMP_MAX;
				re_millis = now;
				updateEEPROM();
			 }
		}

		if (clk == LOW && dt == LOW) {
		 	if (re_state == RE_RIGHT1) {re_state = RE_RIGHT2;}
		 	else if (re_state == RE_LEFT1) {re_state = RE_LEFT2;}
		}

	   	if (clk == HIGH && dt == LOW) {
		 	if (re_state == RE_RIGHT2) {
				// temp -
			 	re_state = RE_RIGHT3;
			 	setStandby(false);
				if (now - re_millis < 100) set_t -= 10;
				else set_t -= 5;
				if (set_t < TEMP_MIN) set_t = TEMP_MIN;
				re_millis = now;
			 	updateEEPROM();
		 	}
		 	else if (re_state == RE_NONE) {re_state = RE_LEFT1;}
	   	}

	   	if (clk == HIGH && dt == HIGH) {
		 	if (re_state == RE_RIGHT3) {re_state = RE_NONE;}
			else if (re_state == RE_LEFT3) {re_state = RE_NONE;}
	   	}
	}
}

void setStandbyLayoff(boolean state) {
	if (state == stby_layoff) return;
	stby_layoff = state;
	stby = false;
	last_measured = cur_t;
	last_on_state = millis()/1000;
}

void compute(void) {
#ifndef USE_TFT_RESET
	setStandbyLayoff(!digitalRead(STBY_NO)); //do not measure while heater is active, potential is not neccessary == GND
#endif
	cur_t = getTemperature();
	if (off) {
		target_t = 0;
		if (cur_t < adc_offset + TEMP_RISE) {
			threshold_counter = TEMP_UNDER_THRESHOLD; //reset counter
		}
	} else {
		if (stby_layoff || stby) {
			target_t = TEMP_STBY;
		} else {
			target_t = set_t;
		}
		if (cur_t-last_measured <= -30 && last_measured != 999) {
			setError(EXCESSIVE_FALL); //decrease of more than 30 degree is uncommon, short of ring and gnd is possible.
		}
		if (cur_t < adc_offset + TEMP_RISE) {
			if (threshold_counter == 0) {
				setError(NOT_HEATING); //temperature is not reached in desired time, short of sensor and gnd too?
			} else {
				threshold_counter--;
			}
		} else {
			threshold_counter = THRES_MAX_DECEED; //reset counter to a smaller value to allow small oscillation of temperature
		}
	}

	set_td = target_t;
	cur_td = cur_t;
	last_measured = cur_t;

	heaterPID.Compute();
	if (error != NO_ERROR || off)
		pwm = 0;
	else
		pwm = min(255,pid_val*255);
	analogWrite(HEATER_PWM, pwm);
}

void timer_sw_poll(void) {
	if (power_down) return;
	if (!digitalRead(SW_STBY)) {
		if (cnt_off_press == 100) {
			setOff(!off);
		}
		if (cnt_off_press == 200 && power_source == POWER_LIPO) {
			setOff(true);
			power_down = true;
			return;
		}
		cnt_off_press = min(201, cnt_off_press+1);
	} else {
		if (cnt_off_press > 0 && cnt_off_press <= 100) {
			setStandby(!stby);
		}
		cnt_off_press = 0;
	}
#ifndef USE_SERIAL
	boolean t1 = !digitalRead(SW_T1);
	boolean t2 = !digitalRead(SW_T2);
	boolean t3 = !digitalRead(SW_T3);

	//simultanious push of multiple buttons
	if (t1 + t2 + t3 > 1) {
		store_to = 255;
		store_invalid = true;
	} else if (error != NO_ERROR) {
		if (!(t1 |  t2 | t3)) {
			store_invalid = false;
		} else if (!store_invalid && t3) {
			error = NO_ERROR; //dismiss
			set_t_old = 0; //refresh set_t display
			store_invalid = true; //wait for release
		}
	} else {
		//all buttons released
		if (!(t1 |  t2 | t3)) {
			if (store_to != 255) {
				if (cnt_but_store <= 100) {
					set_t = stored[store_to];
					setStandby(false);
					updateEEPROM();
				}
			}
			store_to = 255;
			store_invalid = false;
			cnt_but_store = 0;
		} else
		//one button pressed
		if (!store_invalid) {
			store_to = t2 + 2*t3;
			if (cnt_but_store > 100) {
				if (set_t != stored[store_to] && !stby) {
					stored[store_to] = set_t;
					cnt_but_store = 100;
					updateEEPROM();
				}
			}
			cnt_but_store++;
		}
	}
#endif
}

void timer_isr(void) {

	rotary_encoder();

	if (cnt_compute >= TIME_COMPUTE_IN_MS) {
		analogWrite(HEATER_PWM, 0); //switch off heater to let the low pass settle

		if (cnt_compute >= TIME_COMPUTE_IN_MS+DELAY_BEFORE_MEASURE) {
			compute();
			cnt_compute=0;
		}
	}
	cnt_compute++;

	if(cnt_sw_poll >= TIME_SW_POLL_IN_MS){
		timer_sw_poll();
		cnt_sw_poll=0;
	}
	cnt_sw_poll++;

#ifdef USE_LIPO
	if(cnt_measure_voltage >= TIME_MEASURE_VOLTAGE_IN_MS) {
		measureVoltage();
		cnt_measure_voltage=0;
	}
	cnt_measure_voltage++;
#endif
}

void powerDown(void) {
	if (power_source != POWER_LIPO) {
		power_down = false;
		return;
	}
	Timer1.stop();
	setOff(true);
	delay(10);
	tft.fillScreen(TFT_BLACK);
	tft.setTextSize(4);
	tft.setTextColor(TFT_RED);
	tft.setCursor(50,40);
	tft.print("OFF");
	delay(3000);
	SPI.end();
	digitalWrite(POWER, LOW);
	pinMode(POWER, OUTPUT);
	delay(100);
	force_redraw = true;
	power_down = false;
	Timer1.start(); //unsuccessful
}

float toFahrenheit(float t) {
	return t * 1.8 + 32;
}

void setError(error_type e) {
	error = e;
	setOff(true);
}

void printTemp(float t) {
	if (fahrenheit) {
		t = toFahrenheit(t);
	}
	if (t < 100) tft.write(' ');
	tft.print((int)t);
}

void tft_display(void) {
	if (force_redraw) tft.fillScreen(TFT_BLACK);
	int16_t temperature = cur_t; //buffer volatile value
	boolean yell = stby || (stby_layoff && blink);
	tft.drawCircle(20,63,8, off?TFT_RED:yell?TFT_YELLOW:TFT_GREEN);
	tft.drawCircle(20,63,7,off?TFT_RED:yell?TFT_YELLOW:TFT_GREEN);
	tft.fillRect(19,55,3,3,TFT_BLACK);
	tft.drawFastVLine(20,53,10, off?TFT_RED:yell?TFT_YELLOW:TFT_GREEN);
	if (error != NO_ERROR) {
		if (error != error_old || force_redraw) {
			error_old = error;
			tft.setTextSize(1);
			tft.setTextColor(TFT_RED, TFT_BLACK);
			tft.setCursor(0,96);
			switch (error) {
				case EXCESSIVE_FALL:
					tft.print(F("Error: Temperature dropped\nTip slipped out?"));
					break;
				case NOT_HEATING:
					tft.print(F("Error: Not heating\nWeak power source or short"));
					break;
				case BATTERY_LOW:
					tft.print(F("Error: Battery low\nReplace or charge"));
					break;
				case USB_ONLY:
					tft.print(F("Error: Power too low\nConnect power >5V"));
					break;
				case NO_TIP:
					tft.print(F("Error: No tip connected\nTip slipped out?"));
					break;
			}
			tft.setTextSize(2);
			tft.setTextColor(TFT_YELLOW, TFT_BLACK);
			tft.setCursor(10,112);
			tft.print(F("         OK "));

			tft.setTextColor(TFT_RED, TFT_BLACK);
			tft.setCursor(36,26);
			tft.setTextSize(3);
			tft.print(F(" ERR  "));
		}
	} else {
		if (error != error_old || force_redraw) {
			tft.fillRect(0, 96, 160, 16, TFT_BLACK);
			error_old = NO_ERROR;
		}
		tft.setTextSize(2);
		tft.setCursor(15,112);
		tft.setTextColor(TFT_WHITE, TFT_BLACK);
		printTemp(stored[0]);
		tft.write(' ');
		printTemp(stored[1]);
		tft.write(' ');
		printTemp(stored[2]);

		if (set_t_old != set_t || old_stby != (stby || stby_layoff) || force_redraw) {
			tft.setCursor(36,26);
			tft.setTextSize(3);
			if (stby || stby_layoff) {
				old_stby = true;
				tft.setTextColor(TFT_YELLOW, TFT_BLACK);
				tft.print(F("STBY  "));
			} else {
				uint8_t height = 64;
				uint8_t width = 10;
				uint8_t origin_x = 149;
				uint8_t	origin_y = 24;
				old_stby = false;
				set_t_old = set_t;
				tft.setTextColor(TFT_WHITE, TFT_BLACK);
				tft.write(' ');
				printTemp(set_t);
				tft.write(247);
				tft.write(fahrenheit?'F':'C');
				//tft.fillTriangle(origin_x, origin_y, origin_x + width, origin_y, origin_x + width, origin_y + height, TFT_GRAY);
				uint8_t y = (set_t - TEMP_MIN) * height / (TEMP_MAX - TEMP_MIN);
				uint8_t x = y * width / height;
				tft.fillTriangle(origin_x + width - x, origin_y + height - y, origin_x + width, origin_y + height - y, origin_x + width, origin_y + height, TFT_WHITE);
				tft.fillTriangle(origin_x + width - x, origin_y + height - y, origin_x, origin_y, origin_x + width, origin_y, TFT_GRAY);
				tft.fillTriangle(origin_x + width - x, origin_y + height - y, origin_x + width, origin_y, origin_x + width, origin_y + height - y, TFT_GRAY);
			}
		}
		if (!off) {
#ifdef SHUTOFF_ACTIVE
			if (autopower) {
				int16_t tout;
				if (stby || stby_layoff) {
					tout = min(max(0,(last_on_state + OFF_TIMEOUT - (millis())/1000)), OFF_TIMEOUT);
				} else {
					tout = min(max(0,(last_temperature_drop + STANDBY_TIMEOUT - (millis())/1000)), STANDBY_TIMEOUT);
				}
				tft.setTextColor(stby?TFT_RED:TFT_YELLOW, TFT_BLACK);
				tft.setTextSize(2);
				tft.setCursor(46,78);
				if (tout < 600) tft.write('0');
				tft.print(tout/60);
				tft.write(':');
				if (tout%60 < 10) tft.write('0');
				tft.print(tout%60);
			}
#endif
		} else if (temperature != 999) {
			tft.fillRect(46, 78, 60, 20, TFT_BLACK);
		}
	}
	if (cur_t_old != temperature || force_redraw) {
		tft.setCursor(36,52);
		tft.setTextSize(3);
		if (temperature == 999) {
			tft.setTextColor(TFT_RED, TFT_BLACK);
			tft.print(F(" ERR  "));
			tft.setCursor(44,76);
			tft.setTextSize(2);
			tft.print(F("NO TIP"));
		} else {
			if (cur_t_old == 999) {
				tft.fillRect(44,76,72,16,TFT_BLACK);
			}
			tft.setTextColor(off ? temperature < TEMP_COLD ? TFT_CYAN : TFT_RED : tft.Color565(min(10,abs(temperature-target_t))*25, 250 - min(10,max(0,(abs(temperature-target_t)-10)))*25, 0), BLACK);
			if (temperature < TEMP_COLD) {
				tft.print(F("COLD  "));
			} else {
				tft.write(' ');
				printTemp(temperature);
				tft.write(247);
				tft.write(fahrenheit?'F':'C');
			}
		}
		if (temperature < cur_t_old)
			tft.fillRect(max(0, (temperature - TEMP_COLD)/2.4), 0, 160-max(0, (temperature - TEMP_COLD)/2.4), BAR_HEIGHT, BLACK);
		else if (cur_t != 999) {
			for (int16_t i = max(0, (cur_t_old - TEMP_COLD)/2.4); i < max(0, (temperature - TEMP_COLD)/2.4); i++) {
				tft.drawFastVLine(i, 0, BAR_HEIGHT, tft.Color565(min(255, max(0, i*5)), min(255, max(0, 450-i*2.5)), 0));
			}
		}
		cur_t_old = temperature;
	}
#ifdef USE_LIPO
	if (v_c3 > 1.0) {
		tft.setTextColor(TFT_YELLOW, TFT_BLACK);
		tft.setCursor(122,5);
		tft.setTextSize(2);
		int power = min(15,v)*min(15,v)/4.8*pwm/255;
		if (power < 10) tft.write(' ');
		tft.print(power);
		tft.write('W');

		if (v < 5.0) {
			power_source = POWER_USB;
		} else if (v_c2 < 1.0) {
			power_source = POWER_CORD;
		} else {
			power_source = POWER_LIPO; //Set charging later to not redraw if charging mode toggles
		}
		if (power_source != power_source_old || force_redraw) {
			tft.fillRect(0, 5, 128, 20, TFT_BLACK);
			tft.fillRect(11, 25, 21, 20, TFT_BLACK);
			switch (power_source) {
				case POWER_CHARGING:
				case POWER_LIPO:
					for (uint8_t i = 0; i < 3; i++) {
						tft.drawRect(11, 5+i*14, 20, 12, TFT_WHITE);
						tft.drawFastVLine(31,8+i*14,6,TFT_WHITE);
					}
					break;
				case POWER_USB:
					tft.setTextSize(1);
					tft.setTextColor(TFT_RED, TFT_BLACK);
					tft.setCursor(0,5);
					tft.print("USB power only\nConnect power supply.");
					if (!off) setError(USB_ONLY);
					break;
			}
			power_source_old = power_source;
		}
		if (power_source == POWER_CORD) {
			tft.drawBitmap(0, 5, power_cord, 24, 9, tft.Color565(max(0, min(255, (14.5-v)*112)), max(0, min(255, (v-11)*112)), 0));
		} else if (power_source == POWER_LIPO || power_source == POWER_CHARGING) {
			float volt[] = {v_c1, v_c2-v_c1, v_c3-v_c2};
			uint8_t volt_disp[] = {max(1,min(16,(volt[0]-3.0)*14.2)), max(1,min(16,(volt[1]-3.0)*14.2)), max(1,min(16,(volt[2]-3.0)*14.2))};
			if (power_source == POWER_CHARGING) {
				uint8_t p = min(16, (millis() / 100) % 20);
				for (uint8_t i = 0; i < 3; i++) {
					volt_disp[i] = max(0, min(volt_disp[i], p));
				}
			}
			for (uint8_t i = 0; i < 3; i++) {
				if (volt[i] < 3.20) {
					setError(BATTERY_LOW);
					tft.fillRect(13, 7+14*i, volt_disp[i], 8, blink?TFT_RED:TFT_BLACK);
				} else {
					tft.fillRect(13, 7+14*i, volt_disp[i], 8, tft.Color565(250-min(250, max(0, (volt[i]-3.4)*1000.0)), max(0,min(250, (volt[i]-3.15)*1000.0)), 0));
				}
				tft.fillRect(13+volt_disp[i], 7+14*i, 17-volt_disp[i], 8, TFT_BLACK);
			}
		}
	}
#endif
#ifdef SHUTOFF_ACTIVE
	if (autopower) {
		if (!stby_layoff) {
			if (pwm > max(20, (cur_t-150)/50*round(25-min(15,v)))+5) {
				if (autopower_repeat_under || stby) {
					if (stby && !wasOff) {
						setStandby(false);
					} else {
						last_temperature_drop = millis()/1000;
					}
				}
				autopower_repeat_under = true;
			} else if (wasOff) {
				wasOff = false;
			} else {
				autopower_repeat_under = false; //over the max pwm for at least two times
			}
		}
		if (!off && !stby && millis()/1000 > (last_temperature_drop + STANDBY_TIMEOUT)) {
			setStandby(true);
		}
		if (!off && (stby || stby_layoff) && millis()/1000 > (last_on_state + OFF_TIMEOUT)) {
			setOff(true);
		}
	}
#endif
	blink = !blink;
	force_redraw = false;
}

void setup(void) {
#ifdef USE_EXTERNAL_AREF
	analogReference(EXTERNAL);
#endif
	digitalWrite(HEATER_PWM, LOW);
	pinMode(HEATER_PWM, OUTPUT);
	pinMode(POWER, INPUT_PULLUP);
#ifdef USE_NEOPIXEL
	pinMode(NEOPIXEL, OUTPUT);
	neo_ring.begin();
	neo_ring.setBrightness(NEO_BRIGHTNESS);
#else
	pinMode(HEAT_LED, OUTPUT);
	digitalWrite(HEAT_LED, HIGH);
#endif
	pinMode(TEMP_SENSE, INPUT);
	pinMode(SW_T1, INPUT_PULLUP);
	pinMode(SW_T2, INPUT_PULLUP);
	pinMode(SW_T3, INPUT_PULLUP);
	pinMode(SW_STBY, INPUT_PULLUP);
	pinMode (RE_CLK,INPUT_PULLUP);
	pinMode (RE_DT,INPUT_PULLUP);
	pinMode(STBY_NO, INPUT_PULLUP);
	pinMode(TFT_CS, OUTPUT);
	digitalWrite(TFT_CS, HIGH);
#ifdef USE_SERIAL
	Serial.begin(115200);
#endif
	boolean force_menu = false;
	if (EEPROM.read(0) != EEPROM_CHECK) {
		EEPROM.update(0, EEPROM_CHECK);
		updateEEPROM();
		force_menu = true;
	}
	tft.begin();
#ifdef USE_SSD1306
	oled.begin(SSD1306_SWITCHCAPVCC, OLED_ADDR);
	oled.display();
	oled.clearDisplay();
	for (int i = 0; i < OLED_SCREEN_WIDTH; i++) {oled_buffer[i] = -1;}
#endif

#ifdef HARDWARE_DEFINED_TFT
	#if HARDWARE_DEFINED_TFT == 1
		EEPROM.update(EEPROM_DISPLAY, RGB_DISP);
		setDisplayMode(0);
	#else
		EEPROM.update(EEPROM_DISPLAY, BGR_DISP);
		setDisplayMode(1);
	#endif
#else
	if (force_menu || EEPROM.read(EEPROM_VERSION) < 23 || EEPROM.read(EEPROM_VERSION) == 255 || (EEPROM.read(EEPROM_DISPLAY) != BGR_DISP && EEPROM.read(EEPROM_DISPLAY) != RGB_DISP)) {
		tft.fillScreen(TFT_BLACK);
		setDisplayMode(1);
		tft.setTextSize(2);
		tft.setCursor(0,0);
		tft.setTextColor(TFT_WHITE);
		tft.print(F("What color is displayed?"));
		tft.setCursor(10,112);
		tft.setTextColor(TFT_RED);
		tft.print("RED     BLUE");
		while (true) {
			if (!digitalRead(SW_T1)) {
				EEPROM.update(EEPROM_DISPLAY, BGR_DISP);
				setDisplayMode(1);
				break;
			}
			if (!digitalRead(SW_T3)) {
				EEPROM.update(EEPROM_DISPLAY, RGB_DISP);
				setDisplayMode(0);
				break;
			}
		}
		tft.fillScreen(TFT_BLACK);
		tft.setTextColor(TFT_YELLOW);
#ifndef USE_SSD1306
		tft.drawBitmap(0, 20, maiskolben, 160, 64, YELLOW);
#endif
		tft.setCursor(20,86);
		tft.setTextColor(TFT_YELLOW);
		tft.setTextSize(2);
		tft.print("Maiskolben");
		tft.setCursor(35,104);
		tft.print("Welcome!");
		delay(4000);
		while (!digitalRead(SW_T3) || !digitalRead(SW_T1)) delay(100);
	} else {
		setDisplayMode(EEPROM.read(EEPROM_DISPLAY) == BGR_DISP);
	}
#endif
#ifdef INSTALL
	if (EEPROM.read(EEPROM_INSTALL) != EEPROM_CHECK) {
		tft.fillScreen(TFT_BLACK);
		tft.setTextColor(TFT_RED, TFT_BLACK);
		tft.setCursor(0,0);
		tft.setTextSize(2);
		tft.println("Installation");
#ifndef USE_NEOPIXEL
		for (int16_t i = -255; i < 256; i++) {
			analogWrite(HEAT_LED, 255-abs(i));
			delay(1);
		}
#endif
		uint16_t adc1 = 0, adc2 = 0;
		while (digitalRead(SW_STBY)) {
			int t = getTemperature();
			uint16_t adc = analogRead(TEMP_SENSE);
			digitalWrite(HEATER_PWM, !digitalRead(SW_T3));
			if (!digitalRead(SW_T1)) { // SW_DOWN
				if (!adc) {
					digitalWrite(HEATER_PWM, HIGH);
				} else {
					adc1 = adc;
				}
			}
			if (!digitalRead(SW_T2)) { // SW_UP
				if (!adc) {
					digitalWrite(HEATER_PWM, HIGH);
				} else {
					adc2 = adc;
				}
			}
			tft.setCursor(0,18);
			tft.print(t);
			tft.println("  ");
			tft.print(adc);
			tft.println("   ");
			tft.println(adc * adc_gain + adc_offset);
			if (adc1 != 0 && adc2 != 0) {
				adc_gain = DELTA_REF_T / (float)(adc2 - adc1);
				adc_offset = REF_T1 - adc_gain * adc1;
				tft.println(adc_gain);
				tft.println(adc_offset);
			}
			delay(50);
		}
		EEPROM.update(EEPROM_OPTIONS,  (fahrenheit << 2) | (bootheat << 1) | autopower);
		EEPROM.update(EEPROM_VERSION, EE_VERSION);
		EEPROM.update(EEPROM_INSTALL, EEPROM_CHECK);
		EEPROM.put(EEPROM_ADCTTG, adc_gain);
		EEPROM.put(EEPROM_ADCOFF, adc_offset);

		tft.println("done.");
		delay(1000);
		asm volatile("jmp 0");
	}
#endif
	if (EEPROM.read(EEPROM_VERSION) != EE_VERSION) {
		force_menu = true;
	}
	tft.fillScreen(TFT_BLACK);
	uint8_t options = EEPROM.read(EEPROM_OPTIONS);
	autopower = options & 1;
	bootheat = options & 2;
	fahrenheit = options & 4;
	if (force_menu) optionMenu();
	else {
		updateRevision();
#ifndef USE_SSD1306
		tft.drawBitmap(0, 20, maiskolben, 160, 64, TFT_YELLOW);
#endif
		tft.setCursor(20,86);
		tft.setTextColor(TFT_YELLOW);
		tft.setTextSize(2);
		tft.print("Maiskolben");
		tft.setCursor(50,110);
		tft.setTextSize(1);
		tft.print("Version ");
		tft.print(VERSION);
		tft.setCursor(46,120);
		tft.print("HW Revision ");
		tft.print(revision);
		//Allow Options to be set at startup
		delay(100);
		attachInterrupt(digitalPinToInterrupt(SW_STBY), optionMenu, LOW);
		for (int i = 0; i < NUM_LED && !menu_dismissed; i++) {
#ifdef USE_NEOPIXEL
			neo_ring.setPixelColor(i, neo_ring.Color(200, 200, 200));
			neo_ring.show();
#else
			digitalWrite(HEAT_LED, i % 2);
#endif
			delay(200);
		}
		detachInterrupt(digitalPinToInterrupt(SW_STBY));
	}
	/*
	 * lower frequency = noisier tip
	 * higher frequency = needs higher pwm
	 */

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
	//TCCR2B = (TCCR2B & 0b11111000) | 4
	//PWM Prescaler = 32  980Hz
	//TCCR2B = (TCCR2B & 0b11111000) | 3;
	//PWM Prescaler = 8  3.9kHz
	//TCCR2B = (TCCR2B & 0b11111000) | 2
	//PWM Prescaler = 1    31kHz - no Noise
	//TCCR2B = (TCCR2B & 0b11111000) | 1;
	stby = EEPROM.read(1);
	for (uint8_t i = 0; i < 3; i++) {
		stored[i] = EEPROM.read(2+i*2) << 8;
		stored[i] |= EEPROM.read(3+i*2);
	}
	set_t = EEPROM.read(EEPROM_SET_T) << 8;
	set_t |= EEPROM.read(EEPROM_SET_T+1);
	set_t -= set_t % 5;

#ifdef USE_LIPO
	for (uint8_t i = 0; i < 50; i++) measureVoltage(); //measure average 50 times to get realistic results
#endif

	tft.fillScreen(TFT_BLACK);
	last_measured = getTemperature();
	Timer1.initialize(1000); // 1 mSec -1 kHz
	Timer1.attachInterrupt(timer_isr);
	heaterPID.SetMode(AUTOMATIC);
	sendNext = millis();
	if (bootheat) {
		threshold_counter = TEMP_UNDER_THRESHOLD;
		setOff(false);
	}
	if (EEPROM.read(EEPROM_ADCTTG) == 255) { //Override unset values from older versions
		EEPROM.put(EEPROM_ADCTTG, adc_gain);
		EEPROM.put(EEPROM_ADCOFF, adc_offset);
	}
	EEPROM.get(EEPROM_ADCTTG, adc_gain);
	EEPROM.get(EEPROM_ADCOFF, adc_offset);
}

/* *************** MAIN *************** */
int main(void) {
	init();
	setup();
	while (true) {
#ifdef USE_NEOPIXEL
		if (stby) {
			for (int i = 0; i < NUM_LED; i++) {
				neo_ring.setPixelColor(i, neo_ring.Color(0, 0, 200));
			}
			neo_ring.setBrightness(neo_lightness);
			neo_ring.show();

			if (neo_lightness >= STBY_LIGTHNESS_MAX) neo_lightness_direction = false;
			if (neo_lightness <= STBY_LIGTHNESS_MIN) neo_lightness_direction = true;
			if (neo_lightness_direction) neo_lightness += STBY_LIGTHNESS_STEP; else neo_lightness -= STBY_LIGTHNESS_STEP;

		} else if (off == true) {
			for (int i = 0; i < NUM_LED; i++) {
				neo_ring.setPixelColor(i, neo_ring.Color(0, 0, 0));
			}
			neo_ring.show();
		} else {
			// if (pwm > 0) {
			// 	int count = pwm / 255 * NUM_LED;
			// 	for (int i = 0; i < NUM_LED; i++) {
			// 		if (i <= count) {
			// 			neo_ring.setPixelColor(i, neo_ring.Color(200, 200, 200));
			// 		} else {
			// 			neo_ring.setPixelColor(i, neo_ring.Color(0, 0, 0));
			// 		}
			// 	}
			// } else {
				int g = 96;
				int count = (set_t - TEMP_MIN) * NUM_LED / (TEMP_MAX - TEMP_MIN);
				int g_step = - 96 / NUM_LED;
				for (int i = 0; i < NUM_LED; i++) {
					if (i <= count) {
						neo_ring.setPixelColor(i, neo_ring.Color(255, g, 0));
					} else {
						neo_ring.setPixelColor(i, neo_ring.Color(0, 0, 0));
					}
					g += g_step;
				}
			// }
			neo_ring.setBrightness(NEO_BRIGHTNESS);
			neo_ring.show();
		}
#else
		analogWrite(HEAT_LED, pwm);
#endif
		if (sendNext <= millis()) {
			sendNext += 100;
#ifdef USE_SSD1306
			oled.clearDisplay();
			oled.setTextSize(1);
			oled.setTextColor(WHITE);
			oled.setCursor(0,0);
			oled.println(cur_t); // temperature
			oled.setCursor(0,10);
			oled.println(adc); // adc
			oled.setCursor(0,20);
			oled.println(pwm); // pwm
			// graph
			for (int i = 0; i < OLED_SCREEN_WIDTH - OLED_SCREEN_OFFSET; i++) {
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
			} else oled_buffer_index++;
			oled.display();
#endif
		tft_display();
#ifdef USE_SERIAL
		Serial.print(0);
		Serial.print(" ");
		Serial.print(255);
		Serial.print(" ");
		Serial.print(pwm);
		Serial.print(" ");
		Serial.println(cur_t);

		// original code
		// Serial.print(stored[0]);
		// Serial.print(";");
		// Serial.print(stored[1]);
		// Serial.print(";");
		// Serial.print(stored[2]);
		// Serial.print(";");
		// Serial.print(off?0:1);
		// Serial.print(";");
		// Serial.print(error);
		// Serial.print(";");
		// Serial.print(stby?1:0);
		// Serial.print(";");
		// Serial.print(stby_layoff?1:0);
		// Serial.print(";");
		// Serial.print(set_t);
		// Serial.print(";");
		// Serial.print(cur_t);
		// Serial.print(";");
		// Serial.print(pid_val);
		// Serial.print(";");
		// Serial.print(v_c2>1.0?v_c1:0.0);
		// Serial.print(";");
		// Serial.print(v_c2);
		// Serial.print(";");
		// Serial.println(v);
		// Serial.flush();
#endif
		}
		delay(DELAY_MAIN_LOOP);
		if (power_down) {
			powerDown();
		}
	}
}
