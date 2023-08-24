local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mStringUtils= require "Utils/StringUtil"

local UGUIText = mLuaClass("UGUIText",mBaseLua);

function UGUIText:ParseSymbol(str, index)
	local parse = false;
	local bold = false;                 --粗体--
	local italic = false;               --斜体  
	local underline = false;            --下划线--
	local strikethrough = false;        --栅格线--
	local ignoreColor = false;          --颜色--

	--目前只支持解析颜色，并且不支持多层嵌套，其他有需要再加--
	if(mStringUtils:Utf8sub(str, index + 7, 1) == '>') then
		index = index + 7;
		ignoreColor = false;
	elseif (mStringUtils:Utf8sub(str, index + 14, 1) == '>') then
		index = index + 14;
		ignoreColor = true;
	end

	return index, ignoreColor;
end

local instance = UGUIText.LuaNew();
return instance;