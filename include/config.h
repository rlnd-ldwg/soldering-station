#define USE_SSD1306
//#define USE_NEOPIXEL
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

#define RGB_DISP 0x0
#define BGR_DISP 0x2

#define	TFT_BLACK   0x0000
#define	TFT_BLUE    0x001F
#define	TFT_RED     0xF800
#define	TFT_GREEN   0x07E0
#define TFT_CYAN    0x07FF
#define TFT_MAGENTA 0xF81F
#define TFT_YELLOW  0xFFE0
#define TFT_WHITE   0xFFFF
#define TFT_GRAY    0x94B2

// rotary encoder
#define RE_NONE  0
#define RE_LEFT1 1
#define RE_LEFT2 2
#define RE_LEFT3 3
#define RE_RIGHT1  4
#define RE_RIGHT2  5
#define RE_RIGHT3  6

// neo pixel
#define STBY_LIGTHNESS_MAX 	96
#define STBY_LIGTHNESS_MIN 	32
#define STBY_LIGTHNESS_STEP 1
#define NEO_BRIGHTNESS 		32
#define NUM_LED 			12

// oled display
#define OLED_SCREEN_WIDTH	128
#define OLED_SCREEN_HEIGHT	32
#define OLED_SCREEN_OFFSET 	32
#define OLED_SCREEN_DIVIDER	1
#define OLED_RESET 			4
#define OLED_ADDR 			0x3C
