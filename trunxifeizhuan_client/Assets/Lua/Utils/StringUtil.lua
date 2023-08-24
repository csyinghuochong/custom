local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mString = require "string"
local mMath = require "math"

local StringUtil = mLuaClass("StringUtil",mBaseLua);

--含有数字.字符之外的字符--
function StringUtil:HaveInvalidChar(str)
	local text, index = mString.gsub(str, "%W", "")
	return index > 0;
end

--暂时不考虑中文--
function StringUtil:GetStrLength(str)
	return mString.len(str);
end

--随机字符串--
function StringUtil:GetRandomStr(length)
    local rt = ""
    for i = 1, length do
        rt = rt..mString.char(self:Random(97, 122));
    end
    return rt;
end

function StringUtil:Random(n, m)
    return mMath.random(n, m);
end

------------------------来自网络------------------------
-- 判断utf8字符byte长度
-- 0xxxxxxx - 1 byte
-- 110yxxxx - 192, 2 byte
-- 1110yyyy - 225, 3 byte
-- 11110zzz - 240, 4 byte
function StringUtil:CharSize(char)
    if not char then
        return 0
    elseif char > 240 then
        return 4
    elseif char > 225 then
        return 3
    elseif char > 192 then
        return 2
    else
        return 1
    end
end

-- 计算utf8字符串字符数, 各种字符都按一个字符计算
-- 例如utf8len("1你好") => 3
function StringUtil:Utf8len(str)
    local len = 0
    local currentIndex = 1
    while currentIndex <= mString.len(str) do
        local char = mString.byte(str, currentIndex)
        currentIndex = currentIndex + self:CharSize(char)
        len = len +1
    end
    return len
end

-- 截取utf8 字符串
-- str:            要截取的字符串
-- startChar:    开始字符下标,从1开始
-- numChars:    要截取的字符长度
function StringUtil:Utf8sub(str, startChar, numChars)
    local startIndex = 1
    while startChar > 1 do
        local char = mString.byte(str, startIndex)
        startIndex = startIndex + self:CharSize(char)
        startChar = startChar - 1
    end

    local currentIndex = startIndex

    while numChars > 0 and currentIndex <= #str do
        local char = mString.byte(str, currentIndex)
        currentIndex = currentIndex + self:CharSize(char)
        numChars = numChars -1
    end
    return str:sub(startIndex, currentIndex - 1);
end

-- startChar.. 真实的下标索引.
function StringUtil:Utf8sub2(str, startIndex, numChars, utf8)
    local currentIndex = startIndex
    while numChars > 0 and currentIndex <= #str do
        local char = mString.byte(str, currentIndex)
        currentIndex = currentIndex + self:CharSize(char)
        numChars = numChars -1
    end

    return str:sub(startIndex, currentIndex - 1), currentIndex;
end
------------------------来自网络------------------------

local instance = StringUtil.LuaNew();
return instance;