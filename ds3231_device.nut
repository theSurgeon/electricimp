//// CLASS


class ds3231 {
 
    _i2c  = null;
    _addr = null;
    
    static REG_LTHB = "\x11";
    static REG_LTLB = "\x12";
    
    static REG_SEC  = "\x00";
    static REG_MIN  = "\x01";
    static REG_HOUR = "\x02";
    
    static REG_WDAY = "\x03";
    static REG_DATE = "\x04";
    static REG_MONTH= "\x05";
    static REG_YEAR = "\x06";
    
    constructor(i2c, address) 
    {
        _i2c  = i2c;
        _addr = address;
    }
    
    function setTime(hour,minute,second,wday,date,month,year) 
    {
     
    //local second   ="\x50";
     //local minute   ="\x59";
     //local hour     ="\x23";
     //local wday     ="\x01"; // sunday = 01
     //local date     ="\x31";
     //local month    ="\x12";
     //local year     ="\x14";
     
     //server.log("SET SEC: "+dec2bcd(second));
     _i2c.write(_addr, REG_SEC+second); 
     _i2c.write(_addr, REG_MIN+minute); 
     _i2c.write(_addr, REG_HOUR+hour); 
     
     _i2c.write(_addr, REG_WDAY+wday);
     _i2c.write(_addr, REG_DATE+date);
     _i2c.write(_addr, REG_MONTH+month);
     _i2c.write(_addr, REG_YEAR+year); 
     
    }
  

    function getDate(debug) 
    {
        local wday = format("%d",bcd2dec(_i2c.read(_addr, REG_WDAY, 1)[0]));
        local date = format("%02d",bcd2dec(_i2c.read(_addr, REG_DATE, 1)[0]));
        local month = format("%02d",bcd2dec(_i2c.read(_addr, REG_MONTH, 1)[0]));
        local year = format("%02d",bcd2dec(_i2c.read(_addr, REG_YEAR, 1)[0]));
    
    if (debug){
    
         server.log("WdAY: "+wday);
         server.log("DATE: "+date);
         server.log("MONTH: "+month);
         server.log("YEAR: "+year); 
      
    }
      
    return date+"."+month+".20"+year;
         
       
     
     
     
    } 
    
    
    function getTime(debug) 
    {

    
   
    
        local hour = format("%02d",bcd2dec(_i2c.read(_addr, REG_HOUR, 1)[0]));
        local min = format("%02d",bcd2dec(_i2c.read(_addr, REG_MIN, 1)[0]));
        local sec = format("%02d",bcd2dec(_i2c.read(_addr, REG_SEC, 1)[0]));
       
    
    if (debug){
    
        server.log("HOUR: "+hour);
         server.log("MIN: "+min);
         server.log("SEC: "+sec);
      
    }
      
    return hour+":"+min+":"+sec;
         
       
     
     
     
    }

  function getTemp(debug) 
    {
  
  local temp;
   
   local tMSB = _i2c.read(_addr,REG_LTHB, 1)[0];
   local tLSB = _i2c.read(_addr, REG_LTLB, 1)[0];
   temp = (tMSB & 127);
   temp += ( (tLSB >> 6) *0.25);
   
   if (debug){
   server.log("TEMP: "+temp+" °C");     
   
   }
   
   
   return temp;
   
        
    }


 // Convert Decimal to Binary Coded Decimal (BCD)
function dec2bcd(num)
{
 return ((num/10 * 16) + (num % 10));
}
 
// Convert Binary Coded Decimal (BCD) to Decimal
function bcd2dec(num)
{
 return ((num/16 * 10) + (num % 16));
} 
    
    
    
}
 
///// CLASS END 
 
 
// Configure i2c bus
hardware.i2c12.configure(CLOCK_SPEED_400_KHZ);
 
// Create ds3231 object
RTC <- ds3231(hardware.i2c12, 0xD0);
 
// Set Time
//setTime(hour,minute,second,wday,date,month,year) [wday 1=sunday]
//RTC.setTime("\x15","\x17","\x00","\x01","\x15","\x06","\x14");

// Get Time getTime(debug) [debug true -> server.log]
server.log(RTC.getTime(false));

// Get Date getDate(debug) [debug true -> server.log]
server.log(RTC.getDate(false));

// Get Temp getTemp(debug) [debug true -> server.log]
server.log(RTC.getTemp(false)+" °C");