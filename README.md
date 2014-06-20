electricimp
===========

Kombi-Pack PCD8544 (Nokia 5110) / DS3231 (RTS) to electricImp
Working Software: postVoltage

PIN CONF:

ElectricImp <> PCD8544

GND   - 1 GND
3V3   - 2 VCC
Pin 9 - 6 CS (ChipSelect)
Pin 8 - 5 D/C
Pin 7 - 4 DIN (MOSI)
Pin 5 - 3 CLK (SCLK)

CAVE (8 LED / 7 RST on PCD8544 nicht belegt)
        8 LED - 2 VCC
        7 RST - (offen)
        
        
ElectricImp <> DS3231 (Chronodot)

Pin 1 - SCL (PullUp with 10K to VCC)
Pin 2 - SDA (PullUp with 10K to VCC)
GND   - GND
3V3   - VCC





