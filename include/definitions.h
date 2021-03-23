#include <SPI.h>
#include <Wire.h>
#include <TFT_ILI9163C.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <PID_v1.h>
#include <EEPROM.h>

#define USE_SSD1306
#define USE_EXTERNAL_AREF
#define USE_SERIAL
#define USE_TFT_RESET

#define PID_MAX             48
#define TEMP_STEP           1
#define ADC_STBY            228     // 150 Grad
#define ADC_SET1            672     // 300 Grad
#define ADC_SET2            820     // 350 Grad
#define ADC_SET3            970     // 400 Grad
#define ADC_MAX             ADC_SET3
#define ADC_MIN             ADC_STBY
#define SHORT_PRESS         32
#define LONG_PRESS          64

// pins
#define SW_T3               0
#define SW_T2               1
#define RE_CLK 		        2
#define HEATER_PWM_PIN      3
#define RE_DT 		        4
#define SW_STBY             5
#define STBY_NO		        8
#define TFT_DC              9
#define TFT_CS              10
#define SW_T1               12
#define ADC_PIN             A0
#define HEARTBEAT_PIN       A3

// oled display
#define OLED_SCREEN_WIDTH	128
#define OLED_SCREEN_HEIGHT	32
#define OLED_SCREEN_OFFSET 	32
#define OLED_SCREEN_DIVIDER	1
#define OLED_RESET 			4
#define OLED_ADDR 			0x3C

// tft display
#define RGB_DISP            0x0
#define BGR_DISP            0x2
#define	TFT_BLACK           0x0000
#define	TFT_BLUE            0x001F
#define	TFT_RED             0xF800
#define	TFT_GREEN           0x07E0
#define TFT_CYAN            0x07FF
#define TFT_MAGENTA         0xF81F
#define TFT_YELLOW          0xFFE0
#define TFT_WHITE           0xFFFF
#define TFT_GRAY            0x94B2

#define EEPROM_CHECK        0x4152  // AR

typedef enum state {
	STATE_OFF,
	STATE_STANDBY,
	STATE_ON,
	STATE_ERROR
} state_t;
