local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local CommonMoveToggleButton = mLuaClass("CommonMoveToggleButton", mBaseView);
local mEventEnum = require "Enum/EventEnum"
local mSuper = nil;
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"
local mVector3 = Vector3

local DISTANCE = 3;

function CommonMoveToggleButton:OnLuaNew(index, go, callback)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);

	self.mIndex = index;
	self.mCallback = callback;
end

function CommonMoveToggleButton:Init()
	self.mNormal = self:Find('on_normal').gameObject;
	self.mSelect = self:Find('on_select').gameObject;
	local trans = self:Find('redPoint');
	if trans ~= nil then
       self.mRedpoint = trans.gameObject;
	end
	self:AddBtnClickListener(self.mGameObject, function() self:OnClick() end);
end

function CommonMoveToggleButton:SetSelected(select)
	self.mIsSelect = select;
	local transText = self:Find("text");
	local X = transText.localPosition.x;
	local Y = transText.localPosition.y;
	if select then
		transText.localPosition = mVector3(X+DISTANCE,Y);
	else
		transText.localPosition = mVector3(X-DISTANCE,Y);
	end
	self.mSelect:SetActive(select);
end

function CommonMoveToggleButton:SetRedPoint(value)
	local redPoint = self.mRedpoint;
	if redPoint ~= nil then
       self.mRedpoint:SetActive(value);
	end
end

function CommonMoveToggleButton:OnClick()
	if self.mIsSelect ~= true then
       local call_back = self.mCallback;
	   if call_back ~= nil then
		  call_back(self.mIndex);

		  self:Dispatch(mEventEnum.PLAY_SOUND,mSoundConst.ty_0204);
	   end
	end

end

return CommonMoveToggleButton;