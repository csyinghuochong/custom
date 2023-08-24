local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mOs = os;

local TimeUtil = mLuaClass("TimeUtil",mBaseLua);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgDay = mLanguageUtil.time_day;
local mLgHour = mLanguageUtil.time_hour;
local mLgMin = mLanguageUtil.time_min;

--把秒转为00:00:00格式的时间
function TimeUtil:TransToHourMinSec(second)
     local hour1,hour2 = math.modf(second/60/60);
     local hourStr = hour1 < 10 and "0".. hour1 or hour1;

     local min1,min2 = math.modf(second/60);
     local min = min1%60;
     local minStr = min < 10 and "0".. min or min;

     local sec = second%60;
     local secStr = sec < 10 and "0".. sec or sec;

     return hourStr ..":"..minStr..":"..secStr;
end

--把秒转为00:00格式的时间
function TimeUtil:TransToMinSec(second)
     local min1,min2 = math.modf(second/60);
     local min = min1%60;
     local minStr = min < 10 and "0".. min or min;

     local sec = second%60;
     local secStr = sec < 10 and "0".. sec or sec;

     return minStr..":"..secStr;
end

--把秒转为xx天xx小时格式的时间
function TimeUtil:TransToDayHour(second)
	local day,day2 = math.modf(second/60/60/24);
	local dayStr = day..mLgDay;

	local hour,hour2 = math.modf((second%86400)/3600);
	local hourStr = (hour + 1)..mLgHour;

	return dayStr..hourStr;
end

--把秒转为xx天格式的时间
function TimeUtil:TransToDay(second)
     local day,day2 = math.modf(second/86400);
     local dayStr = day..mLgDay;

     return dayStr;
end

--把秒转为xx小时格式的时间
function TimeUtil:TransToHour(second)
     local hour,hour2 = math.modf(second/3600);
     local hourStr = hour..mLgHour;

     return hourStr;
end

--把秒转为xx分钟格式的时间
function TimeUtil:TransToMin(second)
	local min,min2 = math.modf(second/60);
	local minStr = (min + 1)..mLgMin;

	return minStr;
end

--把时间戳转为YYYY-MM-DD格式的时间
function TimeUtil:TransToYearMonthDay(second)
	return mOs.date("%Y-%m-%d",second);
end

--把时间戳转为YYYY-MM-DD HH:MM:SS格式的时间
function TimeUtil:TransToYearMonthDayHMS(second)
	return mOs.date("%Y-%m-%d %H:%M:%S",second);
end

local instance = TimeUtil.LuaNew();
return instance;