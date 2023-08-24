local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local CommonToggleButton = mLuaClass("CommonToggleButton", mBaseView);
local mEventEnum = require "Enum/EventEnum"
local mSuper = nil;
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"

function CommonToggleButton:OnLuaNew(index, go, callback, findText)
	self.mFindText = findText;
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);

	self.mIndex = index;
	self.mCallback = callback;
end

function CommonToggleButton:Init()
	self.mSelect = self:Find('on_select').gameObject;
	self.mNormal = self:Find('on_normal').gameObject;
	self:AddBtnClickListener(self.mGameObject, function() self:OnClick() end);
end

function CommonToggleButton:SetSelected(select,color)
	self.mIsSelect = select;
	self.mSelect:SetActive(select);
	--self.mNormal:SetActive(not select);隐藏了会导致引导点击标签没反应
	if color ~= nil then
		local text = self.mText;
		if text ~= nil then
			text.color = color;
		else
			text = self:FindComponent('text','Text');
			text.color = color;
			self.mText = text;
		end
	end
end

function CommonToggleButton:SetRedPoint(value)
	local redPoint = self.mRedPoint;
	if redPoint ~= nil then
		redPoint:SetActive(value);
	else
		redPoint = self:Find('redPoint').gameObject;
		redPoint:SetActive(value);
		self.mRedPoint = redPoint;
	end
end

function CommonToggleButton:OnClick()
	--if self.mIsSelect ~= true then
       local call_back = self.mCallback;
	   if call_back ~= nil then
		  call_back(self.mIndex);

		  self:Dispatch(mEventEnum.PLAY_SOUND,mSoundConst.ty_0204);
	   end
	--end
end

return CommonToggleButton;