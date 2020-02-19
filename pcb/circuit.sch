EESchema Schematic File Version 4
LIBS:circuit-cache
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L MCU_Module:Arduino_Nano_v3.x A1
U 1 1 5E4D681D
P 5700 3450
F 0 "A1" H 5700 2361 50  0000 C CNN
F 1 "Arduino_Nano_v3.x" H 5700 2270 50  0000 C CNN
F 2 "Module:Arduino_Nano" H 5850 2500 50  0001 L CNN
F 3 "http://www.mouser.com/pdfdocs/Gravitech_Arduino_Nano3_0.pdf" H 5700 2450 50  0001 C CNN
	1    5700 3450
	-1   0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x08_Female J3
U 1 1 5E4F402F
P 10250 2950
F 0 "J3" H 10278 2926 50  0000 L CNN
F 1 "Conn_01x08_Female" H 10278 2835 50  0000 L CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_1x08_P1.27mm_Horizontal" H 10250 2950 50  0001 C CNN
F 3 "~" H 10250 2950 50  0001 C CNN
	1    10250 2950
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4050 U2
U 7 1 5E4F7EA0
P 6650 5150
F 0 "U2" H 6880 5196 50  0000 L CNN
F 1 "4050" H 6880 5105 50  0000 L CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 6650 5150 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 6650 5150 50  0001 C CNN
	7    6650 5150
	1    0    0    -1  
$EndComp
$Comp
L MCU_Microchip_ATmega:ATmega328-PU U1
U 1 1 5E4F8E4A
P 1850 5850
F 0 "U1" H 1206 5896 50  0000 R CNN
F 1 "ATmega328-PU" H 1206 5805 50  0000 R CNN
F 2 "Package_DIP:DIP-28_W7.62mm" H 1850 5850 50  0001 C CIN
F 3 "http://ww1.microchip.com/downloads/en/DeviceDoc/ATmega328_P%20AVR%20MCU%20with%20picoPower%20Technology%20Data%20Sheet%2040001984A.pdf" H 1850 5850 50  0001 C CNN
	1    1850 5850
	1    0    0    -1  
$EndComp
$Comp
L Device:Rotary_Encoder_Switch SW4
U 1 1 5E4FA227
P 2300 1600
F 0 "SW4" H 2300 1967 50  0000 C CNN
F 1 "Rotary_Encoder_Switch" H 2300 1876 50  0000 C CNN
F 2 "Rotary_Encoder:RotaryEncoder_Alps_EC11E-Switch_Vertical_H20mm" H 2150 1760 50  0001 C CNN
F 3 "~" H 2300 1860 50  0001 C CNN
	1    2300 1600
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW1
U 1 1 5E4FBC7D
P 1850 2950
F 0 "SW1" H 1850 3235 50  0000 C CNN
F 1 "SW_Push" H 1850 3144 50  0000 C CNN
F 2 "Button_Switch_THT:SW_Tactile_Straight_KSL0Axx1LFTR" H 1850 3150 50  0001 C CNN
F 3 "~" H 1850 3150 50  0001 C CNN
	1    1850 2950
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW2
U 1 1 5E4FD724
P 1850 3300
F 0 "SW2" H 1850 3585 50  0000 C CNN
F 1 "SW_Push" H 1850 3494 50  0000 C CNN
F 2 "Button_Switch_THT:SW_Tactile_Straight_KSL0Axx1LFTR" H 1850 3500 50  0001 C CNN
F 3 "~" H 1850 3500 50  0001 C CNN
	1    1850 3300
	1    0    0    -1  
$EndComp
$Comp
L Switch:SW_Push SW3
U 1 1 5E4FEE8B
P 1850 3700
F 0 "SW3" H 1850 3985 50  0000 C CNN
F 1 "SW_Push" H 1850 3894 50  0000 C CNN
F 2 "Button_Switch_THT:SW_Tactile_Straight_KSL0Axx1LFTR" H 1850 3900 50  0001 C CNN
F 3 "~" H 1850 3900 50  0001 C CNN
	1    1850 3700
	1    0    0    -1  
$EndComp
$Comp
L Transistor_FET:2N7000 Q2
U 1 1 5E4FFEE1
P 9000 1950
F 0 "Q2" H 9206 1996 50  0000 L CNN
F 1 "2N7000" H 9206 1905 50  0000 L CNN
F 2 "Package_TO_SOT_THT:TO-92_Inline" H 9200 1875 50  0001 L CIN
F 3 "https://www.fairchildsemi.com/datasheets/2N/2N7000.pdf" H 9000 1950 50  0001 L CNN
	1    9000 1950
	1    0    0    -1  
$EndComp
$Comp
L Transistor_FET:IRF4905 Q1
U 1 1 5E500EC3
P 9100 1150
F 0 "Q1" V 9443 1150 50  0000 C CNN
F 1 "IRF5305" V 9352 1150 50  0000 C CNN
F 2 "Package_TO_SOT_THT:TO-220-3_Vertical" H 9300 1075 50  0001 L CIN
F 3 "http://www.infineon.com/dgdl/irf4905.pdf?fileId=5546d462533600a4015355e32165197c" H 9100 1150 50  0001 L CNN
	1    9100 1150
	0    1    -1   0   
$EndComp
$Comp
L Connector:Conn_01x04_Female J2
U 1 1 5E504703
P 9900 4000
F 0 "J2" H 9928 3976 50  0000 L CNN
F 1 "Conn_01x04_Female" H 9928 3885 50  0000 L CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_1x04_P1.27mm_Vertical" H 9900 4000 50  0001 C CNN
F 3 "~" H 9900 4000 50  0001 C CNN
	1    9900 4000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C1
U 1 1 5E5052D0
P 7800 1850
F 0 "C1" H 7915 1896 50  0000 L CNN
F 1 "10nF" H 7915 1805 50  0000 L CNN
F 2 "Capacitor_THT:CP_Axial_L10.0mm_D4.5mm_P15.00mm_Horizontal" H 7838 1700 50  0001 C CNN
F 3 "~" H 7800 1850 50  0001 C CNN
	1    7800 1850
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 5E506FB9
P 3600 1850
F 0 "C2" H 3715 1896 50  0000 L CNN
F 1 "C" H 3715 1805 50  0000 L CNN
F 2 "Capacitor_THT:CP_Radial_D5.0mm_P2.50mm" H 3638 1700 50  0001 C CNN
F 3 "~" H 3600 1850 50  0001 C CNN
	1    3600 1850
	-1   0    0    1   
$EndComp
$Comp
L Device:R R9
U 1 1 5E50773B
P 1100 950
F 0 "R9" H 1170 996 50  0000 L CNN
F 1 "R" H 1170 905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1030 950 50  0001 C CNN
F 3 "~" H 1100 950 50  0001 C CNN
	1    1100 950 
	1    0    0    -1  
$EndComp
$Comp
L Device:R R10
U 1 1 5E5093D0
P 1350 950
F 0 "R10" H 1420 996 50  0000 L CNN
F 1 "R" H 1420 905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1280 950 50  0001 C CNN
F 3 "~" H 1350 950 50  0001 C CNN
	1    1350 950 
	1    0    0    -1  
$EndComp
$Comp
L Device:R R11
U 1 1 5E509E69
P 1550 950
F 0 "R11" H 1620 996 50  0000 L CNN
F 1 "R" H 1620 905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 1480 950 50  0001 C CNN
F 3 "~" H 1550 950 50  0001 C CNN
	1    1550 950 
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 5E50A726
P 6600 1550
F 0 "R5" V 6807 1550 50  0000 C CNN
F 1 "5,6kΩ" V 6716 1550 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 6530 1550 50  0001 C CNN
F 3 "~" H 6600 1550 50  0001 C CNN
	1    6600 1550
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R4
U 1 1 5E50AED4
P 7050 1100
F 0 "R4" V 6843 1100 50  0000 C CNN
F 1 "68kΩ" V 6934 1100 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 6980 1100 50  0001 C CNN
F 3 "~" H 7050 1100 50  0001 C CNN
	1    7050 1100
	0    1    1    0   
$EndComp
$Comp
L Device:R R12
U 1 1 5E50B74B
P 2100 950
F 0 "R12" H 2170 996 50  0000 L CNN
F 1 "R" H 2170 905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 2030 950 50  0001 C CNN
F 3 "~" H 2100 950 50  0001 C CNN
	1    2100 950 
	1    0    0    -1  
$EndComp
$Comp
L Device:R R13
U 1 1 5E50C018
P 2100 950
F 0 "R13" H 2170 996 50  0000 L CNN
F 1 "R" H 2170 905 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 2030 950 50  0001 C CNN
F 3 "~" H 2100 950 50  0001 C CNN
	1    2100 950 
	1    0    0    -1  
$EndComp
$Comp
L Device:R R3
U 1 1 5E50C80F
P 7600 1850
F 0 "R3" H 7530 1804 50  0000 R CNN
F 1 "100Ω" H 7530 1895 50  0000 R CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 7530 1850 50  0001 C CNN
F 3 "~" H 7600 1850 50  0001 C CNN
	1    7600 1850
	1    0    0    1   
$EndComp
$Comp
L Device:R R2
U 1 1 5E50D168
P 8000 1850
F 0 "R2" H 8070 1896 50  0000 L CNN
F 1 "100kΩ" H 8070 1805 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 7930 1850 50  0001 C CNN
F 3 "~" H 8000 1850 50  0001 C CNN
	1    8000 1850
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 5E50D9A2
P 8800 2250
F 0 "R7" H 8870 2296 50  0000 L CNN
F 1 "10kΩ" H 8870 2205 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 8730 2250 50  0001 C CNN
F 3 "~" H 8800 2250 50  0001 C CNN
	1    8800 2250
	1    0    0    -1  
$EndComp
$Comp
L Device:R R14
U 1 1 5E50E1F8
P 8400 1050
F 0 "R14" H 8470 1096 50  0000 L CNN
F 1 "10MΩ" H 8470 1005 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 8330 1050 50  0001 C CNN
F 3 "~" H 8400 1050 50  0001 C CNN
	1    8400 1050
	1    0    0    -1  
$EndComp
$Comp
L Device:R R15
U 1 1 5E50EB3C
P 3150 3150
F 0 "R15" H 3220 3196 50  0000 L CNN
F 1 "R" H 3220 3105 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 3080 3150 50  0001 C CNN
F 3 "~" H 3150 3150 50  0001 C CNN
	1    3150 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R16
U 1 1 5E50F3DF
P 3150 3150
F 0 "R16" H 3220 3196 50  0000 L CNN
F 1 "R" H 3220 3105 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 3080 3150 50  0001 C CNN
F 3 "~" H 3150 3150 50  0001 C CNN
	1    3150 3150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R6
U 1 1 5E50FC8E
P 8800 1200
F 0 "R6" H 8870 1246 50  0000 L CNN
F 1 "10kΩ" H 8870 1155 50  0000 L CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 8730 1200 50  0001 C CNN
F 3 "~" H 8800 1200 50  0001 C CNN
	1    8800 1200
	1    0    0    -1  
$EndComp
$Comp
L Device:R R1
U 1 1 5E510611
P 8250 1450
F 0 "R1" V 8457 1450 50  0000 C CNN
F 1 "5,6kΩ" V 8366 1450 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 8180 1450 50  0001 C CNN
F 3 "~" H 8250 1450 50  0001 C CNN
	1    8250 1450
	0    -1   -1   0   
$EndComp
$Comp
L Device:R R8
U 1 1 5E5110C1
P 8550 1950
F 0 "R8" V 8757 1950 50  0000 C CNN
F 1 "1kΩ" V 8666 1950 50  0000 C CNN
F 2 "Resistor_THT:R_Axial_DIN0204_L3.6mm_D1.6mm_P7.62mm_Horizontal" V 8480 1950 50  0001 C CNN
F 3 "~" H 8550 1950 50  0001 C CNN
	1    8550 1950
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D1
U 1 1 5E511A9F
P 4450 800
F 0 "D1" H 4443 1016 50  0000 C CNN
F 1 "LED" H 4443 925 50  0000 C CNN
F 2 "Diode_THT:D_DO-15_P2.54mm_Vertical_AnodeUp" H 4450 800 50  0001 C CNN
F 3 "~" H 4450 800 50  0001 C CNN
	1    4450 800 
	1    0    0    -1  
$EndComp
Text Notes 9300 850  0    50   ~ 0
J1: 1=Tip, 2=Sensor, 3=Switch/LED, 4 Gnd
$Comp
L power:+12C #PWR0101
U 1 1 5E5E1DAD
P 8800 850
F 0 "#PWR0101" H 8800 700 50  0001 C CNN
F 1 "+12C" H 8815 1023 50  0000 C CNN
F 2 "" H 8800 850 50  0001 C CNN
F 3 "" H 8800 850 50  0001 C CNN
	1    8800 850 
	1    0    0    -1  
$EndComp
Wire Wire Line
	8800 850  8800 1050
Wire Wire Line
	8800 1050 8900 1050
Connection ~ 8800 1050
Wire Wire Line
	8800 1350 9100 1350
Wire Wire Line
	8700 1950 8800 1950
Wire Wire Line
	8800 1950 8800 2100
Connection ~ 8800 1950
$Comp
L power:GNDD #PWR0102
U 1 1 5E63AC48
P 8800 2400
F 0 "#PWR0102" H 8800 2150 50  0001 C CNN
F 1 "GNDD" H 8804 2245 50  0000 C CNN
F 2 "" H 8800 2400 50  0001 C CNN
F 3 "" H 8800 2400 50  0001 C CNN
	1    8800 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 2150 9100 2400
Wire Wire Line
	9100 2400 8800 2400
Connection ~ 8800 2400
Wire Wire Line
	9850 1050 9300 1050
Wire Wire Line
	9100 2400 9850 2400
Connection ~ 9100 2400
Wire Wire Line
	8400 900  8400 850 
Wire Wire Line
	8400 850  8800 850 
Connection ~ 8800 850 
Wire Wire Line
	9850 1450 8400 1450
Wire Wire Line
	8400 1450 8400 1200
$Comp
L Connector:Conn_01x04_Female J1
U 1 1 5E501C61
P 10050 1450
F 0 "J1" H 10078 1426 50  0000 L CNN
F 1 "soldering iron" H 10078 1335 50  0000 L CNN
F 2 "Connector_PinHeader_1.27mm:PinHeader_1x04_P1.27mm_Vertical" H 10050 1450 50  0001 C CNN
F 3 "~" H 10050 1450 50  0001 C CNN
	1    10050 1450
	1    0    0    -1  
$EndComp
Wire Wire Line
	9100 1350 9100 1750
Connection ~ 9100 1350
Wire Wire Line
	9850 1050 9850 1350
Connection ~ 8400 1450
$Comp
L power:GNDD #PWR0103
U 1 1 5E7B03BA
P 8000 2100
F 0 "#PWR0103" H 8000 1850 50  0001 C CNN
F 1 "GNDD" H 8004 1945 50  0000 C CNN
F 2 "" H 8000 2100 50  0001 C CNN
F 3 "" H 8000 2100 50  0001 C CNN
	1    8000 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8000 2100 8000 2000
Connection ~ 8000 2100
Wire Wire Line
	7800 2000 7800 2100
$Comp
L 4xxx:4050 U2
U 5 1 5E4DB4A0
P 8850 6150
F 0 "U2" H 8850 6467 50  0000 C CNN
F 1 "4050" H 8850 6376 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 8850 6150 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 8850 6150 50  0001 C CNN
	5    8850 6150
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4050 U2
U 4 1 5E4DA910
P 8850 5650
F 0 "U2" H 8850 5967 50  0000 C CNN
F 1 "4050" H 8850 5876 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 8850 5650 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 8850 5650 50  0001 C CNN
	4    8850 5650
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4050 U2
U 3 1 5E4D9A59
P 8900 5050
F 0 "U2" H 8900 5367 50  0000 C CNN
F 1 "4050" H 8900 5276 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 8900 5050 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 8900 5050 50  0001 C CNN
	3    8900 5050
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4050 U2
U 2 1 5E4D891D
P 8900 4500
F 0 "U2" H 8900 4817 50  0000 C CNN
F 1 "4050" H 8900 4726 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 8900 4500 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 8900 4500 50  0001 C CNN
	2    8900 4500
	1    0    0    -1  
$EndComp
$Comp
L 4xxx:4050 U2
U 1 1 5E4D7F80
P 8950 4100
F 0 "U2" H 8950 4417 50  0000 C CNN
F 1 "4050" H 8950 4326 50  0000 C CNN
F 2 "Package_DIP:DIP-16_W7.62mm" H 8950 4100 50  0001 C CNN
F 3 "http://www.intersil.com/content/dam/intersil/documents/cd40/cd4050bms.pdf" H 8950 4100 50  0001 C CNN
	1    8950 4100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7500 1450 7800 1450
Wire Wire Line
	7500 1650 7600 1650
Wire Wire Line
	7600 1650 7600 1700
Wire Wire Line
	7800 2100 8000 2100
Wire Wire Line
	7600 2000 7600 2100
Wire Wire Line
	7600 2100 7800 2100
Connection ~ 7800 2100
Wire Wire Line
	7800 1700 7800 1450
Connection ~ 7800 1450
Wire Wire Line
	7800 1450 8000 1450
Wire Wire Line
	8000 1700 8000 1450
Connection ~ 8000 1450
Wire Wire Line
	8000 1450 8100 1450
$Comp
L Amplifier_Operational:OP179GS IC1
U 1 1 5E4F719F
P 7200 1550
F 0 "IC1" H 7200 1244 50  0000 C CNN
F 1 "OP703PA" H 7200 1153 50  0000 C BNN
F 2 "Package_SO:SOIC-8_3.9x4.9mm_P1.27mm" H 7200 1550 50  0001 C CNN
F 3 "https://www.analog.com/media/en/technical-documentation/data-sheets/OP179_279.pdf" H 7350 1700 50  0001 C CNN
	1    7200 1550
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7200 1100 7600 1100
Wire Wire Line
	7600 1100 7600 1650
Connection ~ 7600 1650
Wire Wire Line
	6900 1550 6850 1550
Wire Wire Line
	6450 1550 4850 1550
Wire Wire Line
	4850 1550 4850 3450
Wire Wire Line
	4850 3450 5200 3450
Wire Wire Line
	9850 1650 9850 2400
Wire Wire Line
	7300 1850 7300 2100
Wire Wire Line
	7300 2100 7600 2100
Connection ~ 7600 2100
Wire Wire Line
	7300 1250 7300 850 
Wire Wire Line
	7300 850  8400 850 
Connection ~ 8400 850 
Wire Wire Line
	6900 1100 6850 1100
Wire Wire Line
	6850 1100 6850 1550
Connection ~ 6850 1550
Wire Wire Line
	6850 1550 6750 1550
Wire Wire Line
	8400 1950 8250 1950
Wire Wire Line
	8250 1950 8250 3150
Wire Wire Line
	8250 3150 6200 3150
$EndSCHEMATC
