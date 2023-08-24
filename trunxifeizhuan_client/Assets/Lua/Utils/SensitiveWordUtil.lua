local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mString = require "string"
local mStringUtil = require "Utils/StringUtil"
local SensitiveWordUtil = mLuaClass("SensitiveWordUtil",mBaseLua);
local mipairs = ipairs;
local mpairs = pairs;
local mSensitiveWordConfig = require "ConfigFiles/ConfigSyssensitive_word";

function SensitiveWordUtil:OnLuaNew()
	local sensitiveWordMap = {};

	local str = nil;
	local firstChar = nil;
	local firstCharMap = nil;
	local len = nil;
	local lenMap = nil;

	for i,str in mpairs(mSensitiveWordConfig) do
		
		firstChar = mStringUtil:Utf8sub(str,1,1);
		firstCharMap = sensitiveWordMap[firstChar];
		if firstCharMap == nil then
			firstCharMap = {};
			sensitiveWordMap[firstChar] = firstCharMap;
		end

		len = #str;
		if len ~= 0 then
			lenMap = firstCharMap[len];
			if lenMap == nil then
				lenMap = {};
				firstCharMap[len] = lenMap;
			end

			lenMap[#lenMap + 1] = str;
		end
	end

	self.mSensitiveWordMap = sensitiveWordMap;
end

function SensitiveWordUtil:CheckSensitiveWord(str)
	if str == nil then
		return false;
	end

    local strLen = #str;
    if strLen <= 0 then
    	return false;
    end

    local charByte = nil;
    local charSize = nil;
    local firstChar = nil;
    local wordByteLen = nil;
    local i = 1;
    while i <= strLen do
    	charByte = mString.byte(str,i);
    	charSize = mStringUtil:CharSize(charByte);

    	firstChar = str:sub(i,i + charSize - 1);
    	wordByteLen = self:CheckWord(firstChar,str,i,strLen);
    	if wordByteLen > 0 then
    		return true;
    	end

    	i = i + charSize;
    end

    return false;
end

function SensitiveWordUtil:ReplaceSensitiveWord(str)
    if str == nil then
		return str;
	end

    local strLen = #str;
    if strLen <= 0 then
    	return str;
    end

    local charByte = nil;
    local charSize = nil;
    local firstChar = nil;
    local wordByteLen = nil;
    local subIndex = 1;
    local subStr = "";
    local i = 1;
    while i <= strLen do
    	charByte = mString.byte(str,i);
    	charSize = mStringUtil:CharSize(charByte);

    	firstChar = str:sub(i,i + charSize - 1);
    	wordByteLen = self:CheckWord(firstChar,str,i,strLen);
    	if wordByteLen > 0 then
    		if subIndex ~= i then
    			subStr = subStr .. str:sub(subIndex,i - 1);
    		end
    		subStr = subStr .. "*";
    		
    		i = i + wordByteLen;
    		subIndex = i;
    	else
    		i = i + charSize;
    	end
    end

    if subIndex ~= 1 then
    	if subIndex ~= strLen then
    		subStr = subStr .. str:sub(subIndex,strLen);
    	end

    	return subStr;
    end

    return str;
end

function SensitiveWordUtil:CheckWord(firstChar,str,i,strLen)
	local sensitiveWordMap = self.mSensitiveWordMap;
    local firstCharMap = nil;
    local word = nil;
    local endIndex = nil;

	firstCharMap = sensitiveWordMap[firstChar];
	if firstCharMap then
		for len,lenMap in mpairs(firstCharMap) do
			endIndex = i + len  - 1;
			if endIndex <= strLen then
				word = str:sub(i,endIndex);
				for index,value in mipairs(lenMap) do
					if word == value then
						return len;
					end
   				end
			end
		end
	end

	return 0;
end

local instance = SensitiveWordUtil.LuaNew();
return instance;