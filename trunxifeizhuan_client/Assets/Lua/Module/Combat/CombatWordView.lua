local BaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mCameraController = require "Manager/CameraController"
local CombatWordView = mLuaClass("CombatWordView",BaseView);
local Vector3 = Vector3;
local mGameTimer = require "Core/Timer/GameTimer"

function CombatWordView:Init()
	self.mFadeGraphic= self:FindComponent('view/word', 'Graphic');
	self:Awake();
end

function CombatWordView:Awake()
end

function CombatWordView:SetPosition(position)

	local transform = self.mTransform;
	if transform then
		local screenPoint = mCameraController:WorldToScreenPoint(position+Vector3.up);
		transform.position = mUICamera:ScreenToWorldPoint(screenPoint);
		local localPosition = transform.localPosition;
		localPosition.z = 0;
		transform.localPosition = localPosition;
	end

end

function CombatWordView:FadeInOut()
	self.mFadeGraphic:CrossFadeAlpha(1,0.5,true);
	mGameTimer.SetTimeout(1, function()
		self.mFadeGraphic:CrossFadeAlpha(0,0.5,true);
	end);
end

function CombatWordView:GetData()
	local data = self.mData;
	if not data then
		data = {};
		self.mData = data;
	end

	return data;
end

function CombatWordView:FillData(src,dst)
end

function CombatWordView:SetData(params)
	self:FillData(params,self:GetData());
end

return CombatWordView;