EESchema Schematic File Version 4
LIBS:circuit-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "soldering station"
Date "2020-03-01"
Rev "1.0.4"
Comp "(c) by KARL"
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L 4xxx:4050 U2
U 7 1 5E4F7EA0
P 10350 5850
F 0 "U2" H 10250 5900 50  0000 L CNN
F 1 "4050" H 10250 5800 50  0000 L CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 10350 5850 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 10350 5850 50  0001 C CNN
	7    10350 5850
	0    1    -1   0   
$EndComp
$Comp
L Device:Rotary_Encoder_Switch SW7
U 1 1 5E4FA227
P 2050 6800
F 0 "SW7" H 2050 7167 50  0000 C CNN
F 1 "Menu" H 2050 7076 50  0000 C CNN
F 2 "Rotary_Encoder:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm" H 1900 6960 50  0001 C CNN
F 3 "~" H 2050 7060 50  0001 C CNN
	1    2050 6800
	-1   0    0    -1  
$EndComp
$Comp
L Transistor_FET:2N7000 Q2
U 1 1 5E4FFEE1
P 10100 2150
F 0 "Q2" H 10306 2196 50  0000 L CNN
F 1 "2N7000" H 10306 2105 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 10300 2075 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N7000.pdf" H 10100 2150 50  0001 L CNN
	1    10100 2150
	1    0    0    -1  
$EndComp
$Comp
L Transistor_FET:IRF4905 Q1
U 1 1 5E500EC3
P 10200 1350
F 0 "Q1" V 10543 1350 50  0000 C CNN
F 1 "IRF5305" V 10452 1350 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Horizontal_TabDown" H 10400 1275 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/irf4905.pdf?fileId=5546d462533600a4015355e32165197c" H 10200 1350 50  0001 L CNN
	1    10200 1350
	0    1    -1   0   
$EndComp
$Comp
L Device:C C1
U 1 1 5E5052D0
P 8900 2050
F 0 "C1" H 9015 2096 50  0000 L CNN
F 1 "10nF" H 9015 2005 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 8938 1900 50  0001 C CNN
F 3 "~" H 8900 2050 50  0001 C CNN
	1    8900 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5E506FB9
P 7400 1900
F 0 "C2" H 7515 1946 50  0000 L CNN
F 1 "C" H 7515 1855 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 7438 1750 50  0001 C CNN
F 3 "~" H 7400 1900 50  0001 C CNN
	1    7400 1900
	-1   0    0    1   
$EndComp
$Comp
L Device:R R10
U 1 1 5E5093D0
P 5850 3600
F 0 "R10" H 5920 3646 50  0000 L CNN
F 1 "220Ω/0Ω" H 5920 3555 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 5780 3600 50  0001 C CNN
F 3 "~" H 5850 3600 50  0001 C CNN
	1    5850 3600
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R5
U 1 1 5E50A726
P 7600 1750
F 0 "R5" V 7807 1750 50  0000 C CNN
F 1 "5,6kΩ" V 7716 1750 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 7530 1750 50  0001 C CNN
F 3 "~" H 7600 1750 50  0001 C CNN
	1    7600 1750
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R4
U 1 1 5E50AED4
P 8150 1300
F 0 "R4" V 7943 1300 50  0000 C CNN
F 1 "68kΩ" V 8034 1300 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 8080 1300 50  0001 C CNN
F 3 "~" H 8150 1300 50  0001 C CNN
	1    8150 1300
	0    1    1    0   
$EndComp
$Comp
L Device:R R3
U 1 1 5E50C80F
P 8700 2050
F 0 "R3" H 8630 2004 50  0000 R CNN
F 1 "100Ω" H 8630 2095 50  0000 R CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 8630 2050 50  0001 C CNN
F 3 "~" H 8700 2050 50  0001 C CNN
	1    8700 2050
	1    0    0    1   
$EndComp
$Comp
L Device:R R2
U 1 1 5E50D168
P 9100 2050
F 0 "R2" H 9170 2096 50  0000 L CNN
F 1 "100kΩ" H 9170 2005 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 9030 2050 50  0001 C CNN
F 3 "~" H 9100 2050 50  0001 C CNN
	1    9100 2050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5E50D9A2
P 9900 2450
F 0 "R7" H 9970 2496 50  0000 L CNN
F 1 "10kΩ" H 9970 2405 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 9830 2450 50  0001 C CNN
F 3 "~" H 9900 2450 50  0001 C CNN
	1    9900 2450
	1    0    0    -1  
$EndComp
$Comp
L Device:R R14
U 1 1 5E50E1F8
P 9500 1250
F 0 "R14" H 9570 1296 50  0000 L CNN
F 1 "10MΩ" H 9570 1205 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 9430 1250 50  0001 C CNN
F 3 "~" H 9500 1250 50  0001 C CNN
	1    9500 1250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 5E50FC8E
P 9900 1400
F 0 "R6" H 9970 1446 50  0000 L CNN
F 1 "10kΩ" H 9970 1355 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 9830 1400 50  0001 C CNN
F 3 "~" H 9900 1400 50  0001 C CNN
	1    9900 1400
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5E510611
P 9350 1650
F 0 "R1" V 9557 1650 50  0000 C CNN
F 1 "5,6kΩ" V 9466 1650 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 9280 1650 50  0001 C CNN
F 3 "~" H 9350 1650 50  0001 C CNN
	1    9350 1650
	0    -1   -1   0   
$EndComp
Wire Wire Line
	9900 1050 9900 1250
Wire Wire Line
	9900 1250 10000 1250
Connection ~ 9900 1250
Wire Wire Line
	9900 1550 10200 1550
Wire Wire Line
	9900 2150 9900 2300
Connection ~ 9900 2150
$Comp
L power:GNDD #PWR0102
U 1 1 5E63AC48
P 9900 2600
F 0 "#PWR0102" H 9900 2350 50  0001 C CNN
F 1 "GNDD" H 9904 2445 50  0000 C CNN
F 2 "" H 9900 2600 50  0001 C CNN
F 3 "" H 9900 2600 50  0001 C CNN
	1    9900 2600
	1    0    0    -1  
$EndComp
Wire Wire Line
	10200 2350 10200 2600
Wire Wire Line
	10200 2600 9900 2600
Connection ~ 9900 2600
Wire Wire Line
	10200 2600 10600 2600
Connection ~ 10200 2600
Wire Wire Line
	9500 1100 9500 1050
Wire Wire Line
	9500 1650 9500 1400
Wire Wire Line
	10200 1550 10200 1950
Connection ~ 10200 1550
Wire Wire Line
	10600 1250 10600 1550
Connection ~ 9500 1650
$Comp
L power:GNDD #PWR0103
U 1 1 5E7B03BA
P 8700 2300
F 0 "#PWR0103" H 8700 2050 50  0001 C CNN
F 1 "GNDD" H 8704 2145 50  0000 C CNN
F 2 "" H 8700 2300 50  0001 C CNN
F 3 "" H 8700 2300 50  0001 C CNN
	1    8700 2300
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 2300 9100 2200
Wire Wire Line
	8900 2200 8900 2300
$Comp
L 4xxx:4050 U2
U 5 1 5E4DB4A0
P 9000 5850
F 0 "U2" H 9000 6167 50  0000 C CNN
F 1 "4050" H 9000 6076 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 9000 5850 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 9000 5850 50  0001 C CNN
	5    9000 5850
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4050 U2
U 4 1 5E4DA910
P 9000 5500
F 0 "U2" H 9000 5817 50  0000 C CNN
F 1 "4050" H 9000 5726 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 9000 5500 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 9000 5500 50  0001 C CNN
	4    9000 5500
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4050 U2
U 3 1 5E4D9A59
P 9000 5150
F 0 "U2" H 9000 5467 50  0000 C CNN
F 1 "4050" H 9000 5376 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 9000 5150 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 9000 5150 50  0001 C CNN
	3    9000 5150
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4050 U2
U 2 1 5E4D891D
P 9000 4800
F 0 "U2" H 9000 5117 50  0000 C CNN
F 1 "4050" H 9000 5026 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 9000 4800 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 9000 4800 50  0001 C CNN
	2    9000 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	8600 1650 8900 1650
Wire Wire Line
	8600 1850 8700 1850
Wire Wire Line
	8700 1850 8700 1900
Wire Wire Line
	8900 2300 9100 2300
Wire Wire Line
	8700 2200 8700 2300
Wire Wire Line
	8700 2300 8900 2300
Connection ~ 8900 2300
Wire Wire Line
	8900 1900 8900 1650
Connection ~ 8900 1650
Wire Wire Line
	8900 1650 9100 1650
Wire Wire Line
	9100 1900 9100 1650
Connection ~ 9100 1650
Wire Wire Line
	9100 1650 9200 1650
Wire Wire Line
	8300 1300 8700 1300
Wire Wire Line
	8700 1300 8700 1850
Connection ~ 8700 1850
Wire Wire Line
	8000 1750 7950 1750
Wire Wire Line
	10600 1850 10600 2600
Wire Wire Line
	8400 2050 8400 2300
Wire Wire Line
	8400 2300 8700 2300
Connection ~ 8700 2300
Wire Wire Line
	8400 1450 8400 1050
Wire Wire Line
	8400 1050 9500 1050
Wire Wire Line
	8000 1300 7950 1300
Wire Wire Line
	7950 1300 7950 1750
Connection ~ 7950 1750
$Comp
L Connector:Screw_Terminal_01x04 J1
U 1 1 5E5068C5
P 10800 1650
F 0 "J1" H 10487 1642 50  0000 L CNN
F 1 "Soldering iron" H 107730 1551 50  0000 L CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-1,5-4-5.08_1x04_P5.08mm_Horizontal" H 10800 1650 50  0001 C CNN
F 3 "~" H 10800 1650 50  0001 C CNN
	1    10800 1650
	1    0    0    -1  
$EndComp
Wire Wire Line
	10600 1250 10400 1250
Wire Wire Line
	10600 1650 9500 1650
Text Notes 10350 1200 0    50   ~ 0
J1:\n1=Tip\n2=Sensor\n3=Switch/LED\n4 Gnd
$Comp
L power:+3V3 #PWR0105
U 1 1 5E605821
P 2800 1600
F 0 "#PWR0105" H 2800 1450 50  0001 C CNN
F 1 "+3V3" H 2815 1773 50  0000 C CNN
F 2 "" H 2800 1600 50  0001 C CNN
F 3 "" H 2800 1600 50  0001 C CNN
	1    2800 1600
	-1   0    0    -1  
$EndComp
$Comp
L Device:Crystal Y1
U 1 1 5E6832F5
P 5550 1900
F 0 "Y1" V 5550 1900 50  0000 C CNN
F 1 "16MHz" H 5850 1900 50  0000 C CNN
F 2 "Crystal:Crystal_HC49-U_Vertical" H 5550 1900 50  0001 C CNN
F 3 "~" H 5550 1900 50  0001 C CNN
	1    5550 1900
	1    0    0    -1  
$EndComp
Text GLabel 7350 1750 0    50   Input ~ 0
Sensor
Text GLabel 5400 2100 2    50   Input ~ 0
Sensor
Wire Wire Line
	7350 1750 7400 1750
Wire Wire Line
	9650 2150 9900 2150
Wire Wire Line
	9650 2150 9650 2300
Text GLabel 5400 3200 2    50   Input ~ 0
Tip
$Comp
L Device:R R8
U 1 1 5E5110C1
P 9650 2450
F 0 "R8" V 9857 2450 50  0000 C CNN
F 1 "1kΩ" V 9766 2450 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 9580 2450 50  0001 C CNN
F 3 "~" H 9650 2450 50  0001 C CNN
	1    9650 2450
	-1   0    0    1   
$EndComp
Wire Wire Line
	9650 2600 9650 2650
Wire Wire Line
	9650 2650 9500 2650
Text GLabel 5400 2400 2    50   Input ~ 0
LiPo1
Text GLabel 5400 2300 2    50   Input ~ 0
LiPo2
Text GLabel 5400 2200 2    50   Input ~ 0
LiPo3
$Comp
L power:GNDD #PWR0109
U 1 1 5E8AC0C9
P 9850 6000
F 0 "#PWR0109" H 9850 5750 50  0001 C CNN
F 1 "GNDD" H 9854 5845 50  0000 C CNN
F 2 "" H 9850 6000 50  0001 C CNN
F 3 "" H 9850 6000 50  0001 C CNN
	1    9850 6000
	1    0    0    -1  
$EndComp
Wire Wire Line
	10850 5850 10850 5500
Wire Wire Line
	9850 6000 9850 5850
Wire Wire Line
	9850 5850 9850 5500
Wire Wire Line
	9850 5300 10000 5300
Connection ~ 9850 5850
Wire Wire Line
	9850 5200 10150 5200
$Comp
L 4xxx:4050 U2
U 1 1 5E4D7F80
P 9000 4450
F 0 "U2" H 9000 4767 50  0000 C CNN
F 1 "4050" H 9000 4676 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 9000 4450 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 9000 4450 50  0001 C CNN
	1    9000 4450
	1    0    0    -1  
$EndComp
Text GLabel 8350 4900 0    50   Input ~ 0
Res
Text GLabel 5400 2700 2    50   Input ~ 0
Res
Text GLabel 8700 4800 0    50   Input ~ 0
DC
Text GLabel 5400 1300 2    50   Input ~ 0
DC
Text GLabel 8700 4450 0    50   Input ~ 0
CS
Text GLabel 5400 1400 2    50   Input ~ 0
CS
Text GLabel 8700 5500 0    50   Input ~ 0
MOSI
Text GLabel 5400 1500 2    50   Input ~ 0
MOSI
Text GLabel 8700 5850 0    50   Input ~ 0
SCK
Text GLabel 5400 1700 2    50   Input ~ 0
SCK
Wire Wire Line
	5400 1800 5700 1800
Wire Wire Line
	5700 1800 5700 1900
Wire Wire Line
	9300 5850 9750 5850
Wire Wire Line
	9300 5500 9700 5500
Wire Wire Line
	9300 5150 9650 5150
Wire Wire Line
	10150 4900 9650 4900
Wire Wire Line
	9650 4900 9650 5150
Wire Wire Line
	9700 5500 9700 5000
Wire Wire Line
	9700 5000 10150 5000
Wire Wire Line
	10150 5100 9750 5100
Wire Wire Line
	9750 5100 9750 5850
$Comp
L Connector:Conn_01x08_Male J2
U 1 1 5EA67A4A
P 10350 3800
F 0 "J2" H 10322 3682 50  0000 R CNN
F 1 "TFT AK" H 10322 3773 50  0000 R CNN
F 2 "my:TFT-1.8-AK" H 10350 3800 50  0001 C CNN
F 3 "~" H 10350 3800 50  0001 C CNN
	1    10350 3800
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x08_Male J3
U 1 1 5EA68828
P 10350 5000
F 0 "J3" H 10322 4882 50  0000 R CNN
F 1 "TFT RL" H 10322 4973 50  0000 R CNN
F 2 "my:TFT-1.8-RGB" H 10350 5000 50  0001 C CNN
F 3 "~" H 10350 5000 50  0001 C CNN
	1    10350 5000
	-1   0    0    1   
$EndComp
Wire Wire Line
	10150 3900 9750 3900
Wire Wire Line
	9750 3900 9750 5100
Connection ~ 9750 5100
Wire Wire Line
	10150 3800 9700 3800
Wire Wire Line
	9700 3800 9700 5000
Connection ~ 9700 5000
Wire Wire Line
	9300 4800 9600 4800
Wire Wire Line
	10150 3700 9600 3700
Wire Wire Line
	9600 3700 9600 4800
Connection ~ 9600 4800
Wire Wire Line
	9600 4800 10150 4800
Wire Wire Line
	10150 3600 9550 3600
Wire Wire Line
	9550 4450 9300 4450
Wire Wire Line
	9550 4700 10150 4700
Wire Wire Line
	10150 3500 9650 3500
Wire Wire Line
	9650 3500 9650 4900
Connection ~ 9650 4900
Connection ~ 9550 4450
Wire Wire Line
	9550 4450 9550 4700
Wire Wire Line
	9550 3600 9550 4450
$Comp
L Switch:SW_Push SW1
U 1 1 5E594634
P 1050 6150
F 0 "SW1" H 1050 6435 50  0000 C CNN
F 1 "T1" H 1050 6344 50  0000 C CNN
F 2 "Button_Switch_THT:SW_Tactile_Straight_KSL0Axx1LFTR" H 1050 6350 50  0001 C CNN
F 3 "~" H 1050 6350 50  0001 C CNN
	1    1050 6150
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 5E59463A
P 1050 6500
F 0 "SW2" H 1050 6785 50  0000 C CNN
F 1 "T2" H 1050 6694 50  0000 C CNN
F 2 "Button_Switch_THT:SW_Tactile_Straight_KSL0Axx1LFTR" H 1050 6700 50  0001 C CNN
F 3 "~" H 1050 6700 50  0001 C CNN
	1    1050 6500
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW3
U 1 1 5E594640
P 1050 6900
F 0 "SW3" H 1050 7185 50  0000 C CNN
F 1 "T3" H 1050 7094 50  0000 C CNN
F 2 "Button_Switch_THT:SW_Tactile_Straight_KSL0Axx1LFTR" H 1050 7100 50  0001 C CNN
F 3 "~" H 1050 7100 50  0001 C CNN
	1    1050 6900
	1    0    0    -1  
$EndComp
$Comp
L power:GNDD #PWR0112
U 1 1 5E5BCEDD
P 1450 7350
F 0 "#PWR0112" H 1450 7100 50  0001 C CNN
F 1 "GNDD" H 1454 7195 50  0000 C CNN
F 2 "" H 1450 7350 50  0001 C CNN
F 3 "" H 1450 7350 50  0001 C CNN
	1    1450 7350
	1    0    0    -1  
$EndComp
Wire Wire Line
	850  6150 850  6500
Connection ~ 850  6500
Wire Wire Line
	850  6500 850  6900
Text GLabel 1250 6150 2    50   Input ~ 0
T1
Text GLabel 5400 2900 2    50   Input ~ 0
T1
Text GLabel 1250 6500 2    50   Input ~ 0
T2
Text GLabel 5400 3000 2    50   Input ~ 0
T2
Text GLabel 1250 6900 2    50   Input ~ 0
T3
Text GLabel 2350 6900 2    50   Input ~ 0
Up
Text GLabel 2350 6700 2    50   Input ~ 0
Down
Text GLabel 5400 3400 2    50   Input ~ 0
Down
Text GLabel 1750 6700 0    50   Input ~ 0
Pow
Text GLabel 5400 3100 2    50   Input ~ 0
Pow
$Comp
L power:GNDD #PWR0113
U 1 1 5E695AE0
P 6000 4200
F 0 "#PWR0113" H 6000 3950 50  0001 C CNN
F 1 "GNDD" H 6004 4045 50  0000 C CNN
F 2 "" H 6000 4200 50  0001 C CNN
F 3 "" H 6000 4200 50  0001 C CNN
	1    6000 4200
	1    0    0    -1  
$EndComp
Text Notes 950  3050 0    50   ~ 0
Ohne LiPo:\nR21/R22 entfallen\nR23, R24, R25=10kΩ\nPin 3-4 gebrückt
Wire Wire Line
	1550 2200 1550 2400
Wire Wire Line
	1550 2700 1700 2700
Connection ~ 1550 2700
Wire Wire Line
	1250 2700 1550 2700
Connection ~ 1250 2400
Wire Wire Line
	1250 2700 1250 2400
Wire Wire Line
	1700 2100 1800 2100
Connection ~ 1700 2100
Wire Wire Line
	1700 2400 1700 2100
Wire Wire Line
	1550 2200 1450 2200
Connection ~ 1550 2200
Wire Wire Line
	1450 2300 1800 2300
Wire Wire Line
	1800 2200 1550 2200
Wire Wire Line
	1450 2100 1700 2100
$Comp
L Device:R R25
U 1 1 5E85DEF0
P 1700 2550
F 0 "R25" H 1770 2596 50  0000 L CNN
F 1 "1MΩ" H 1770 2505 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1630 2550 50  0001 C CNN
F 3 "~" H 1700 2550 50  0001 C CNN
	1    1700 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R24
U 1 1 5E85CD88
P 1550 2550
F 0 "R24" H 1620 2596 50  0000 L CNN
F 1 "1MΩ" H 1620 2505 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1480 2550 50  0001 C CNN
F 3 "~" H 1550 2550 50  0001 C CNN
	1    1550 2550
	1    0    0    -1  
$EndComp
$Comp
L Device:R R23
U 1 1 5E845DBA
P 1300 2300
F 0 "R23" V 1093 2300 50  0000 C CNN
F 1 "1MΩ" V 1184 2300 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1230 2300 50  0001 C CNN
F 3 "~" H 1300 2300 50  0001 C CNN
	1    1300 2300
	0    1    1    0   
$EndComp
$Comp
L Device:R R22
U 1 1 5E844DA1
P 1300 2200
F 0 "R22" V 1093 2200 50  0000 C CNN
F 1 "1MΩ" V 1184 2200 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1230 2200 50  0001 C CNN
F 3 "~" H 1300 2200 50  0001 C CNN
	1    1300 2200
	0    1    1    0   
$EndComp
$Comp
L Device:R R21
U 1 1 5E843C07
P 1300 2100
F 0 "R21" V 1093 2100 50  0000 C CNN
F 1 "2MΩ" V 1184 2100 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1230 2100 50  0001 C CNN
F 3 "~" H 1300 2100 50  0001 C CNN
	1    1300 2100
	0    1    1    0   
$EndComp
Text GLabel 1800 2100 2    50   Input ~ 0
LiPo3
Text GLabel 1800 2200 2    50   Input ~ 0
LiPo2
Text GLabel 1800 2300 2    50   Input ~ 0
LiPo1
Wire Wire Line
	1250 1600 1400 1600
Connection ~ 1250 1600
Wire Wire Line
	1250 2400 1250 1600
Wire Wire Line
	1150 2400 1250 2400
$Comp
L Connector:Conn_01x04_Female J6
U 1 1 5E6EDFD1
P 950 2200
F 0 "J6" H 842 2485 50  0000 C CNN
F 1 "LiPo-Bal" H 842 2394 50  0000 C CNN
F 2 "Connector_JST:JST_EH_S4B-EH_1x04_P2.50mm_Horizontal" H 950 2200 50  0001 C CNN
F 3 "~" H 950 2200 50  0001 C CNN
	1    950  2200
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1150 1600 1250 1600
Connection ~ 2100 1000
Connection ~ 1400 1600
$Comp
L power:GNDD #PWR0107
U 1 1 5E71A655
P 1400 1600
F 0 "#PWR0107" H 1400 1350 50  0001 C CNN
F 1 "GNDD" H 1404 1445 50  0000 C CNN
F 2 "" H 1400 1600 50  0001 C CNN
F 3 "" H 1400 1600 50  0001 C CNN
	1    1400 1600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Barrel_Jack J4
U 1 1 5E6ECC2D
P 1100 1100
F 0 "J4" H 1157 1425 50  0000 C CNN
F 1 "12V" H 1157 1334 50  0000 C CNN
F 2 "Connector_BarrelJack:BarrelJack_CUI_PJ-063AH_Horizontal" H 1150 1060 50  0001 C CNN
F 3 "~" H 1150 1060 50  0001 C CNN
	1    1100 1100
	1    0    0    -1  
$EndComp
$Comp
L Regulator_Linear:LM7805_TO220 Q4
U 1 1 5E601A73
P 2400 1600
F 0 "Q4" H 2400 1842 50  0000 C CNN
F 1 "LM117T 3.3" H 2400 1751 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Horizontal_TabDown" H 2400 1825 50  0001 C CIN
F 3 "http://www.fairchildsemi.com/ds/LM/LM7805.pdf" H 2400 1550 50  0001 C CNN
	1    2400 1600
	1    0    0    1   
$EndComp
$Comp
L Regulator_Linear:LM7805_TO220 Q3
U 1 1 5E5FF5BA
P 2400 1000
F 0 "Q3" H 2400 1242 50  0000 C CNN
F 1 "LM7805" H 2400 1151 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Horizontal_TabDown" H 2400 1225 50  0001 C CIN
F 3 "http://www.fairchildsemi.com/ds/LM/LM7805.pdf" H 2400 950 50  0001 C CNN
	1    2400 1000
	1    0    0    -1  
$EndComp
$Comp
L Reference_Voltage:LM4040LP-4.1 U3
U 1 1 5E5FBA11
P 1550 1200
F 0 "U3" H 1550 1416 50  0000 C CNN
F 1 "LM4040LP-4.1" H 1550 1325 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 1550 1000 50  0001 C CIN
F 3 "http://www.ti.com/lit/ds/symlink/lm4040-n.pdf" H 1550 1200 50  0001 C CIN
	1    1550 1200
	1    0    0    1   
$EndComp
$Comp
L Connector:Screw_Terminal_01x02 J5
U 1 1 5E5C6557
P 950 1500
F 0 "J5" H 868 1717 50  0000 C CNN
F 1 "Power 12V" H 868 1626 50  0000 C CNN
F 2 "TerminalBlock_Phoenix:TerminalBlock_Phoenix_MKDS-1,5-2-5.08_1x02_P5.08mm_Horizontal" H 950 1500 50  0001 C CNN
F 3 "~" H 950 1500 50  0001 C CNN
	1    950  1500
	-1   0    0    -1  
$EndComp
Connection ~ 7400 1750
Wire Wire Line
	7400 1750 7450 1750
$Comp
L power:GNDD #PWR0114
U 1 1 5E7A6B0F
P 7400 2050
F 0 "#PWR0114" H 7400 1800 50  0001 C CNN
F 1 "GNDD" H 7404 1895 50  0000 C CNN
F 2 "" H 7400 2050 50  0001 C CNN
F 3 "" H 7400 2050 50  0001 C CNN
	1    7400 2050
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J9
U 1 1 5E7CF26E
P 1300 3750
F 0 "J9" H 1350 4067 50  0000 C CNN
F 1 "ISP" H 1350 3976 50  0000 C CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_2x03_P2.54mm_Vertical" H 1300 3750 50  0001 C CNN
F 3 "~" H 1300 3750 50  0001 C CNN
	1    1300 3750
	1    0    0    -1  
$EndComp
Text GLabel 5700 1550 2    50   Input ~ 0
MISO
Text GLabel 1100 3650 0    50   Input ~ 0
MISO
Text GLabel 1600 3750 2    50   Input ~ 0
MOSI
Text GLabel 1100 3750 0    50   Input ~ 0
SCK
Text GLabel 1100 3850 0    50   Input ~ 0
Res
$Comp
L power:+5V #PWR0115
U 1 1 5E7D8ED0
P 1600 3650
F 0 "#PWR0115" H 1600 3500 50  0001 C CNN
F 1 "+5V" H 1615 3823 50  0000 C CNN
F 2 "" H 1600 3650 50  0001 C CNN
F 3 "" H 1600 3650 50  0001 C CNN
	1    1600 3650
	1    0    0    -1  
$EndComp
$Comp
L power:GNDD #PWR0116
U 1 1 5E7DA489
P 1600 3850
F 0 "#PWR0116" H 1600 3600 50  0001 C CNN
F 1 "GNDD" H 1604 3695 50  0000 C CNN
F 2 "" H 1600 3850 50  0001 C CNN
F 3 "" H 1600 3850 50  0001 C CNN
	1    1600 3850
	1    0    0    -1  
$EndComp
Text GLabel 5400 1200 2    50   Input ~ 0
TFT-RST
Text GLabel 8350 5400 0    50   Input ~ 0
TFT-RST
Wire Wire Line
	2350 6800 2600 6800
Wire Wire Line
	2600 6800 2600 7150
Wire Wire Line
	2600 7150 1750 7150
Wire Wire Line
	1450 7150 1450 7350
Wire Wire Line
	1750 6900 1750 7150
Connection ~ 1750 7150
Wire Wire Line
	1750 7150 1450 7150
$Comp
L power:+5V #PWR0117
U 1 1 5E73FDEA
P 9500 1050
F 0 "#PWR0117" H 9500 900 50  0001 C CNN
F 1 "+5V" H 9515 1223 50  0000 C CNN
F 2 "" H 9500 1050 50  0001 C CNN
F 3 "" H 9500 1050 50  0001 C CNN
	1    9500 1050
	1    0    0    -1  
$EndComp
Connection ~ 9500 1050
Text GLabel 5400 2500 2    50   Input ~ 0
SDA
Text GLabel 5400 2600 2    50   Input ~ 0
SCL
Text GLabel 2250 4700 2    50   Input ~ 0
SDA
Text GLabel 2250 4900 2    50   Input ~ 0
SCL
$Comp
L MCU_Microchip_ATmega:ATmega328-PU U1
U 1 1 5E4F8E4A
P 4800 2400
F 0 "U1" H 4156 2446 50  0000 R CNN
F 1 "ATmega328-PU" H 4156 2355 50  0000 R CNN
F 2 "Package_DIP:DIP-28_W7.62mm" H 4800 2400 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 4800 2400 50  0001 C CNN
	1    4800 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9850 4300 9850 5200
Wire Wire Line
	9850 4300 10850 4300
Wire Wire Line
	10150 4600 10100 4600
Wire Wire Line
	10100 4600 10100 4100
Wire Wire Line
	10150 4100 10100 4100
Wire Wire Line
	10150 4000 9850 4000
Wire Wire Line
	9850 4000 9850 3450
Wire Wire Line
	9850 4300 9850 4000
Connection ~ 9850 4300
Connection ~ 9850 4000
Text GLabel 8400 4350 0    50   Input ~ 0
BL
Text GLabel 5400 3500 2    50   Input ~ 0
BL
$Comp
L Logic_LevelTranslator:TXS0102DCT U4
U 1 1 5E6CF7FC
P 1750 4800
F 0 "U4" H 1750 4211 50  0000 C CNN
F 1 "TXS0102DCT" H 1750 4600 50  0000 C CNN
F 2 "Package_DIP:DIP-8_W7.62mm" H 1750 4250 50  0001 C CNN
F 3 "http://www.ti.com/lit/gpn/txs0102" H 1750 4780 50  0001 C CNN
	1    1750 4800
	1    0    0    -1  
$EndComp
$Comp
L power:GNDD #PWR0121
U 1 1 5E7470E9
P 1750 5400
F 0 "#PWR0121" H 1750 5150 50  0001 C CNN
F 1 "GNDD" H 1754 5245 50  0000 C CNN
F 2 "" H 1750 5400 50  0001 C CNN
F 3 "" H 1750 5400 50  0001 C CNN
	1    1750 5400
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0122
U 1 1 5E74AF37
P 1650 4300
F 0 "#PWR0122" H 1650 4150 50  0001 C CNN
F 1 "+5V" H 1665 4473 50  0000 C CNN
F 2 "" H 1650 4300 50  0001 C CNN
F 3 "" H 1650 4300 50  0001 C CNN
	1    1650 4300
	1    0    0    -1  
$EndComp
$Comp
L power:+3.3V #PWR0123
U 1 1 5E74C9C1
P 1850 4300
F 0 "#PWR0123" H 1850 4150 50  0001 C CNN
F 1 "+3.3V" H 1865 4473 50  0000 C CNN
F 2 "" H 1850 4300 50  0001 C CNN
F 3 "" H 1850 4300 50  0001 C CNN
	1    1850 4300
	1    0    0    -1  
$EndComp
Wire Wire Line
	1350 5100 1300 5100
Wire Wire Line
	1300 5100 1300 4300
Wire Wire Line
	1300 4300 1650 4300
Connection ~ 1650 4300
Wire Wire Line
	10150 4200 10000 4200
Wire Wire Line
	10000 4200 10000 5300
Connection ~ 10000 5300
Wire Wire Line
	10000 5300 10150 5300
Wire Wire Line
	4800 3900 4800 4200
$Comp
L power:+5V #PWR0110
U 1 1 5E5CCF95
P 4800 800
F 0 "#PWR0110" H 4800 650 50  0001 C CNN
F 1 "+5V" H 4815 973 50  0000 C CNN
F 2 "" H 4800 800 50  0001 C CNN
F 3 "" H 4800 800 50  0001 C CNN
	1    4800 800 
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4050 U2
U 6 1 5E57BA7A
P 9000 4100
F 0 "U2" H 9000 4417 50  0000 C CNN
F 1 "4050" H 9000 4326 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 9000 4100 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 9000 4100 50  0001 C CNN
	6    9000 4100
	1    0    0    -1  
$EndComp
Text GLabel 9500 2650 0    50   Input ~ 0
Tip
Wire Wire Line
	9300 4100 10100 4100
Connection ~ 10100 4100
$Comp
L Jumper:Jumper_3_Bridged12 JP2
U 1 1 5E5BE383
P 8400 4100
F 0 "JP2" V 8446 4167 50  0000 L CNN
F 1 "BL Control" V 8355 4167 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 8400 4100 50  0001 C CNN
F 3 "~" H 8400 4100 50  0001 C CNN
	1    8400 4100
	0    -1   -1   0   
$EndComp
$Comp
L Jumper:Jumper_3_Bridged12 JP1
U 1 1 5E5BF609
P 8350 5150
F 0 "JP1" V 8396 5217 50  0000 L CNN
F 1 "TFT Reset" V 8305 5217 50  0000 L CNN
F 2 "Connector_PinHeader_2.54mm:PinHeader_1x03_P2.54mm_Vertical" H 8350 5150 50  0001 C CNN
F 3 "~" H 8350 5150 50  0001 C CNN
	1    8350 5150
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R9
U 1 1 5E639DF8
P 8400 3700
F 0 "R9" H 8470 3746 50  0000 L CNN
F 1 "10kΩ" H 8470 3655 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 8330 3700 50  0001 C CNN
F 3 "~" H 8400 3700 50  0001 C CNN
	1    8400 3700
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0101
U 1 1 5E63AAFA
P 8400 3550
F 0 "#PWR0101" H 8400 3400 50  0001 C CNN
F 1 "+5V" H 8415 3723 50  0000 C CNN
F 2 "" H 8400 3550 50  0001 C CNN
F 3 "" H 8400 3550 50  0001 C CNN
	1    8400 3550
	1    0    0    -1  
$EndComp
Wire Wire Line
	8700 4100 8550 4100
Wire Wire Line
	8500 5150 8700 5150
Text GLabel 5400 3300 2    50   Input ~ 0
Up
Wire Notes Line
	7850 3200 7850 6250
Wire Notes Line
	7850 6250 10950 6250
Wire Notes Line
	10950 6250 10950 3200
Wire Notes Line
	10950 3200 7850 3200
Text Notes 8000 6150 0    50   ~ 0
TFT control
Wire Notes Line
	6900 750  6900 2900
Wire Notes Line
	10950 2900 10950 750 
Text Notes 7000 2800 0    50   ~ 0
Heat/temperatur control
$Comp
L power:+12V #PWR0120
U 1 1 5E5B0C7D
P 2100 1000
F 0 "#PWR0120" H 2100 850 50  0001 C CNN
F 1 "+12V" H 2115 1173 50  0000 C CNN
F 2 "" H 2100 1000 50  0001 C CNN
F 3 "" H 2100 1000 50  0001 C CNN
	1    2100 1000
	1    0    0    -1  
$EndComp
$Comp
L power:+12V #PWR0124
U 1 1 5E5B1666
P 9900 1050
F 0 "#PWR0124" H 9900 900 50  0001 C CNN
F 1 "+12V" H 9915 1223 50  0000 C CNN
F 2 "" H 9900 1050 50  0001 C CNN
F 3 "" H 9900 1050 50  0001 C CNN
	1    9900 1050
	1    0    0    -1  
$EndComp
Text Notes 2100 3050 0    50   ~ 0
Power supply
Wire Notes Line
	750  3300 2500 3300
Wire Notes Line
	2500 3300 2500 5600
Wire Notes Line
	2500 5600 750  5600
Wire Notes Line
	750  5600 750  3300
Text Notes 900  5500 0    50   ~ 0
ISP / I2C
Wire Wire Line
	1450 7150 850  7150
Wire Wire Line
	850  7150 850  6900
Connection ~ 1450 7150
Connection ~ 850  6900
Wire Notes Line
	750  5750 2700 5750
Wire Notes Line
	2700 5750 2700 7600
Wire Notes Line
	2700 7600 750  7600
Wire Notes Line
	750  7600 750  5750
Text Notes 850  7500 0    50   ~ 0
Input
Wire Wire Line
	4900 900  4800 900 
Connection ~ 4800 900 
$Comp
L Device:C C3
U 1 1 5E8352FE
P 4650 800
F 0 "C3" V 4398 800 50  0000 C CNN
F 1 "100nF" V 4489 800 50  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 4688 650 50  0001 C CNN
F 3 "~" H 4650 800 50  0001 C CNN
	1    4650 800 
	0    1    1    0   
$EndComp
$Comp
L Device:C C5
U 1 1 5E83679A
P 10350 5500
F 0 "C5" V 10602 5500 50  0000 C CNN
F 1 "100nF" V 10511 5500 50  0000 C CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 10388 5350 50  0001 C CNN
F 3 "~" H 10350 5500 50  0001 C CNN
	1    10350 5500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4800 900  4800 800 
Connection ~ 4800 800 
$Comp
L power:GNDD #PWR01
U 1 1 5E857C9A
P 4500 800
F 0 "#PWR01" H 4500 550 50  0001 C CNN
F 1 "GNDD" H 4504 645 50  0000 C CNN
F 2 "" H 4500 800 50  0001 C CNN
F 3 "" H 4500 800 50  0001 C CNN
	1    4500 800 
	1    0    0    -1  
$EndComp
Wire Wire Line
	10500 5500 10850 5500
Connection ~ 10850 5500
Wire Wire Line
	10850 5500 10850 4300
Wire Wire Line
	10200 5500 9850 5500
Connection ~ 9850 5500
Wire Wire Line
	9850 5500 9850 5300
$Comp
L Device:C C4
U 1 1 5E88D3FF
P 7850 2100
F 0 "C4" H 7965 2146 50  0000 L CNN
F 1 "100nF" H 7965 2055 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 7888 1950 50  0001 C CNN
F 3 "~" H 7850 2100 50  0001 C CNN
	1    7850 2100
	1    0    0    -1  
$EndComp
$Comp
L Amplifier_Operational:OP179GS IC1
U 1 1 5E4F719F
P 8300 1750
F 0 "IC1" H 8550 2000 50  0000 C CNN
F 1 "OP703PA" H 8450 2050 50  0000 C BNN
F 2 "Package_DIP:DIP-8_W7.62mm" H 8300 1750 50  0001 C CNN
F 3 "https://www.analog.com/media/en/technical-documentation/data-sheets/OP179_279.pdf" H 8450 1900 50  0001 C CNN
	1    8300 1750
	-1   0    0    -1  
$EndComp
Connection ~ 8400 2300
Wire Wire Line
	7750 1750 7950 1750
Wire Wire Line
	7850 2250 7850 2300
Wire Wire Line
	7850 2300 8400 2300
Wire Wire Line
	7850 1950 7850 1050
Wire Wire Line
	7850 1050 8400 1050
Connection ~ 8400 1050
Wire Notes Line
	10950 2900 6900 2900
Wire Notes Line
	6900 750  10950 750 
Wire Notes Line
	750  3150 750  650 
Text GLabel 5700 1650 2    50   Input ~ 0
T3
Wire Wire Line
	5700 1550 5650 1550
Wire Wire Line
	5650 1550 5650 1600
Wire Wire Line
	5650 1650 5700 1650
Wire Wire Line
	5400 1600 5650 1600
Connection ~ 5650 1600
Wire Wire Line
	5650 1600 5650 1650
Text GLabel 4200 1200 0    50   Output ~ 0
AREF
Text GLabel 1750 950  1    50   Input ~ 0
AREF
Wire Wire Line
	4250 1200 4200 1200
Wire Wire Line
	1400 1200 1400 1300
Connection ~ 1400 1200
Connection ~ 2100 1500
Wire Wire Line
	2100 1500 2100 1600
Wire Wire Line
	1700 1200 1750 1200
Wire Wire Line
	1400 1000 2100 1000
Wire Wire Line
	1750 950  1750 1200
Connection ~ 1750 1200
Wire Wire Line
	1750 1200 1800 1200
Connection ~ 2400 1300
Connection ~ 1400 1300
Wire Wire Line
	1400 1300 1400 1600
Wire Notes Line
	750  650  2950 650 
Wire Notes Line
	2950 650  2950 3150
Wire Notes Line
	2950 3150 750  3150
$Comp
L power:+5V #PWR0106
U 1 1 5E6063C7
P 2800 1000
F 0 "#PWR0106" H 2800 850 50  0001 C CNN
F 1 "+5V" H 2800 1200 50  0000 C CNN
F 2 "" H 2800 1000 50  0001 C CNN
F 3 "" H 2800 1000 50  0001 C CNN
	1    2800 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 1000 2800 1000
Wire Wire Line
	2800 1600 2700 1600
Wire Wire Line
	2100 1000 2100 1500
Wire Wire Line
	2400 1300 1400 1300
$Comp
L Device:R R20
U 1 1 5E509E69
P 1800 1350
F 0 "R20" H 1870 1396 50  0000 L CNN
F 1 "560Ω" H 1870 1305 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1730 1350 50  0001 C CNN
F 3 "~" H 1800 1350 50  0001 C CNN
	1    1800 1350
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1800 1500 1800 1900
Wire Wire Line
	1800 1900 2900 1900
Wire Wire Line
	2900 1900 2900 1000
Wire Wire Line
	2900 1000 2800 1000
Connection ~ 2800 1000
Wire Wire Line
	1150 1500 2100 1500
$Comp
L Device:C C6
U 1 1 5E60986F
P 1300 5250
F 0 "C6" H 1185 5204 50  0000 R CNN
F 1 "100nf" H 1185 5295 50  0000 R CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 1338 5100 50  0001 C CNN
F 3 "~" H 1300 5250 50  0001 C CNN
	1    1300 5250
	-1   0    0    1   
$EndComp
Connection ~ 1300 5100
Wire Wire Line
	1750 5300 1750 5400
Wire Wire Line
	1750 5400 1300 5400
Connection ~ 1750 5400
$Comp
L Device:C C7
U 1 1 5E62B12B
P 2150 5250
F 0 "C7" H 2265 5296 50  0000 L CNN
F 1 "100nF" H 2265 5205 50  0000 L CNN
F 2 "Capacitor_THT:C_Disc_D4.3mm_W1.9mm_P5.00mm" H 2188 5100 50  0001 C CNN
F 3 "~" H 2150 5250 50  0001 C CNN
	1    2150 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2150 4900 2250 4900
Wire Wire Line
	2250 4700 2150 4700
Wire Wire Line
	1850 4300 2150 4300
Connection ~ 1850 4300
Wire Wire Line
	2150 5400 1750 5400
Wire Wire Line
	2150 4300 2150 5100
$Comp
L power:+3.3V #PWR0104
U 1 1 5E5F2BB0
P 9850 3450
F 0 "#PWR0104" H 9850 3300 50  0001 C CNN
F 1 "+3.3V" H 9865 3623 50  0000 C CNN
F 2 "" H 9850 3450 50  0001 C CNN
F 3 "" H 9850 3450 50  0001 C CNN
	1    9850 3450
	1    0    0    -1  
$EndComp
$Comp
L Connector_Generic:Conn_01x24 Prototype1
U 1 1 5E5DA727
P 4750 5750
F 0 "Prototype1" V 4875 5696 50  0000 C CNN
F 1 "Conn_01x24" V 4966 5696 50  0001 C CNN
F 2 "my:Proto1x24" H 4750 5750 50  0001 C CNN
F 3 "~" H 4750 5750 50  0001 C CNN
	1    4750 5750
	-1   0    0    -1  
$EndComp
Text GLabel 4950 5550 2    50   Input ~ 0
SDA
Text GLabel 4950 5450 2    50   Input ~ 0
SCL
Text GLabel 4950 6250 2    50   Input ~ 0
BL
Text GLabel 4950 6150 2    50   Input ~ 0
TFT-RST
Text GLabel 4950 5850 2    50   Input ~ 0
Sensor
Text GLabel 4950 6350 2    50   Input ~ 0
Res
Text GLabel 4950 5950 2    50   Input ~ 0
Tip
Wire Wire Line
	4950 6750 4950 6850
Connection ~ 4950 6850
Wire Wire Line
	4950 6850 4950 6950
Connection ~ 4950 6950
Wire Wire Line
	4950 6950 4950 7050
Connection ~ 4950 4650
Wire Wire Line
	4950 4650 4950 4550
Connection ~ 4950 4750
Wire Wire Line
	4950 4750 4950 4650
Wire Wire Line
	4950 4850 4950 4750
$Comp
L power:GNDD #PWR0108
U 1 1 5E64E3DC
P 4950 7050
F 0 "#PWR0108" H 4950 6800 50  0001 C CNN
F 1 "GNDD" H 4954 6895 50  0000 C CNN
F 2 "" H 4950 7050 50  0001 C CNN
F 3 "" H 4950 7050 50  0001 C CNN
	1    4950 7050
	1    0    0    -1  
$EndComp
$Comp
L power:+5V #PWR0111
U 1 1 5E64F00C
P 4950 4550
F 0 "#PWR0111" H 4950 4400 50  0001 C CNN
F 1 "+5V" H 4965 4723 50  0000 C CNN
F 2 "" H 4950 4550 50  0001 C CNN
F 3 "" H 4950 4550 50  0001 C CNN
	1    4950 4550
	1    0    0    -1  
$EndComp
$Comp
L LED:NeoPixel_THT D1
U 1 1 5E6743B6
P 6900 3600
F 0 "D1" H 7244 3646 50  0000 L CNN
F 1 "NeoPixel_THT" H 7244 3555 50  0000 L CNN
F 2 "LED_THT:LED_D5.0mm-4_RGB" H 6950 3300 50  0001 L TNN
F 3 "https://www.adafruit.com/product/1938" H 7000 3225 50  0001 L TNN
	1    6900 3600
	1    0    0    -1  
$EndComp
Wire Wire Line
	6900 3900 6900 4200
Wire Wire Line
	4950 5150 4950 5050
Wire Wire Line
	4950 4950 5150 4950
Connection ~ 4950 4950
Connection ~ 4950 5050
Wire Wire Line
	4950 5050 4950 4950
$Comp
L power:+3.3V #PWR0126
U 1 1 5E6E9231
P 5150 4950
F 0 "#PWR0126" H 5150 4800 50  0001 C CNN
F 1 "+3.3V" H 5165 5123 50  0000 C CNN
F 2 "" H 5150 4950 50  0001 C CNN
F 3 "" H 5150 4950 50  0001 C CNN
	1    5150 4950
	1    0    0    -1  
$EndComp
Wire Wire Line
	5400 3600 5600 3600
Wire Wire Line
	4950 5650 5600 5650
Wire Wire Line
	5600 5650 5600 3600
Connection ~ 5600 3600
Wire Wire Line
	5600 3600 5700 3600
Wire Wire Line
	7200 3600 7200 5750
NoConn ~ 4950 6450
NoConn ~ 4950 6550
NoConn ~ 4950 6650
Wire Wire Line
	4800 4200 6000 4200
Wire Wire Line
	6900 4200 6000 4200
Connection ~ 6000 4200
Wire Wire Line
	6000 3600 6600 3600
Wire Wire Line
	7200 5750 4950 5750
Text GLabel 1250 4700 0    50   Input ~ 0
SDA5V
Text GLabel 1250 4900 0    50   Input ~ 0
SCL5V
Wire Wire Line
	1250 4700 1350 4700
Wire Wire Line
	1250 4900 1350 4900
Text GLabel 4950 5250 2    50   Input ~ 0
SDA5V
Text GLabel 4950 5350 2    50   Input ~ 0
SCL5V
$Comp
L power:+5V #PWR0125
U 1 1 5E6D7FA6
P 6900 3300
F 0 "#PWR0125" H 6900 3150 50  0001 C CNN
F 1 "+5V" H 6915 3473 50  0000 C CNN
F 2 "" H 6900 3300 50  0001 C CNN
F 3 "" H 6900 3300 50  0001 C CNN
	1    6900 3300
	1    0    0    -1  
$EndComp
Text GLabel 10600 1750 0    50   Input ~ 0
Tip2
Text GLabel 4950 6050 2    50   Input ~ 0
Tip2
$EndSCHEMATC
