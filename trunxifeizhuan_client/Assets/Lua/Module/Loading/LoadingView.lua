local mBaseWindow = require "Core/BaseWindow"
local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local LoadingView = mLuaClass("LoadingView",mBaseWindow);

local mUpdateManager = require "Manager/UpdateManager";
local mVector3 = Vector3;
local mTime = UnityEngine.Time;

function LoadingView:InitViewParam()
	return {
		["viewPath"] = "ui/loading/",
		["viewName"] = "loading_view",
		["viewBgEnum"] = mViewBgEnum.transparent,
		["ParentLayer"] = mLoadingLayer,
		["ForbitSound"] = true,
	};
end

function  LoadingView:Init()
	self.mImage = self:Find('view');
	self.mImageGo = self.mImage.gameObject;
	self.mAngles = Vector3.New(0,0,-1.5);
end

function LoadingView:OnViewShow()
	self.mImage.localEulerAngles = mVector3.zero;
	self.mImageGo:SetActive(false);
	self.mShowTime = mTime.realtimeSinceStartup;
	
	mUpdateManager:AddUpdate(self);
end

function LoadingView:OnViewHide()
	mUpdateManager:RemoveUpdate(self);
end

function LoadingView:OnUpdate()
	local show = mTime.realtimeSinceStartup - self.mShowTime > 0.1;

	if show then
		self.mImageGo:SetActive(show);
		self.mImage.localEulerAngles = self.mImage.localEulerAngles + self.mAngles;
	end
	
end

return LoadingView;
