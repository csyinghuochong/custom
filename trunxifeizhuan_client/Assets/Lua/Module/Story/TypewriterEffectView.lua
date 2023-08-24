--打字机效果--
local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mUGUIText = require "Utils/UGUIText"
local mStringUtils= require "Utils/StringUtil"
local mUpdateManager = require "Manager/UpdateManager"
local TypewriterEffectView = mLuaClass("TypewriterEffectView", mBaseView);
local mTime = Time;

function TypewriterEffectView:Init()
	self.mText = self:FindComponent('Text_content', 'Text');
end

function TypewriterEffectView:SetData(data)
	self:Reset();
	self.mIsActive = true;
	self.mFullText = data.text;
	self.mCallback = data.callback;
	self.mFullTextLength = mStringUtils:Utf8len(data.text);
	self.mDelayOnPeriod = 1 / data.charsPerSecond;

	mUpdateManager:AddUpdate(self);
end

function TypewriterEffectView:Reset()
	self.mText.text = "";
	self.mCurrentOffset = 1;
	self.mNextCharTime = 0;
	self.mParseColor = false;
	self.mLastText = "";
	self.mLastOffset = 1;
end

function TypewriterEffectView:OnUpdate()
	local current_offset = self.mCurrentOffset;
	local next_char_time = self.mNextCharTime;
	local full_length = self.mFullTextLength;
	local full_text = self.mFullText;
	local delay_period = self.mDelayOnPeriod;
	local bool_color = self.mParseColor;
	local last_text = self.mLastText;
	local last_offset = self.mLastOffset;

	while(current_offset <= full_length and  next_char_time <= mTime.time) do
		local current_get = "";
		local temp_index = current_offset;
		local char = mStringUtils:Utf8sub(full_text, current_offset , 1);
		if(char == '<') then
			current_offset, bool_color = mUGUIText:ParseSymbol(full_text, current_offset);
		end
		
		if(next_char_time == 0) then
			next_char_time = mTime.time + delay_period;
		else
			next_char_time = next_char_time + delay_period;
		end

		current_offset = current_offset + 1;
		current_get, last_offset = mStringUtils:Utf8sub2(full_text, last_offset, current_offset - temp_index, true);

		self.mText.text = last_text..current_get..(bool_color and "</color>" or "");
		last_text = last_text..current_get;
		
		if(current_offset > full_length) then
			self:ShowAllText();
		end
	end

	self.mLastText = last_text;
	self.mParseColor = bool_color;
	self.mCurrentOffset = current_offset;
	self.mNextCharTime = next_char_time;
	self.mLastOffset = last_offset;
end

function TypewriterEffectView:OnViewHide( )
	mUpdateManager:RemoveUpdate(self);
end

function TypewriterEffectView:ShowAllText()
	self.mIsActive = false;
	self.mText.text = self.mFullText;
	local callback = self.mCallback;
	if(callback ~= nil) then
		callback();
	end

	mUpdateManager:RemoveUpdate(self);
end

return TypewriterEffectView;