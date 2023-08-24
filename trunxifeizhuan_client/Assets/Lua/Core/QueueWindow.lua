local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"
local mSceneManager = require "Module/Scene/SceneManager"
local QueueWindow = mLuaClass("QueueWindow",mBaseWindow);
local mSuper = nil;
local mType = type;
local CanvasType = typeof(UnityEngine.Canvas);
local GraphicRaycasterType = typeof(UnityEngine.UI.GraphicRaycaster);
local mAdditionalCanvasShaderChannels = UnityEngine.AdditionalCanvasShaderChannels;

function QueueWindow:OnLuaNew(go)
	mSuper = self:GetSuper(mBaseWindow.LuaClassName);
	mSuper.OnLuaNew(self,go);
end

function QueueWindow:OnLoadViewCompleteInit(go)
	local canvas = go:AddComponent(CanvasType);
	self.mGraphicRayCaster = go:AddComponent(GraphicRaycasterType);

	if self.mViewParams.AdditionalShaderChannels then
		canvas.additionalShaderChannels = mAdditionalCanvasShaderChannels.TexCoord1;
	end

	self.mCanvas = canvas;
end

function QueueWindow:InternalSetGameObjectActive(active)
	if active then
		self.mGameObject.layer = 5;--UI
	else
		self.mGameObject.layer = 9;--HideUI
	end

	self.mGraphicRayCaster.enabled = active;
end

function QueueWindow:InternalOnViewShow()
	
	local logicParams = self.mLogicParams;
	if logicParams and mType(logicParams) == "table" then
		local changeParentLayer = logicParams["changeParentLayer"];
		if changeParentLayer then
			self.mTransform:SetParent(changeParentLayer);
		end
	end

	mSuper.InternalOnViewShow(self);
	mUIManager:AddQueueWindow(self);
end

function QueueWindow:InternalOnViewHide()
	mSuper.InternalOnViewHide(self);
end

function QueueWindow:CheckForbitSound()
	if self.mViewParams["ForbitExternalForceShowSound"] then
		if self.mExternalForceShow then
			return true;
		end
	end

	if self.mViewParams["ForbitExternalForceHideSound"] then
		if self.mExternalForceHide then
			return true;
		end
	end

	return self.mViewParams["ForbitSound"];
end

function QueueWindow:OnClickHideView()
	mSuper.OnClickHideView(self);
	mUIManager:RemoveQueueWindow(self);
end

function QueueWindow:OnClickHideViewForbitSound()
	self.mExternalForceHide = true;
	self:OnClickHideView();
	self.mExternalForceHide = false;
end

function QueueWindow:ReturnPrevQueueWindow()
	local stopSound = self.mViewParams["ViewSoundStop"];
	if stopSound ~= nil then
		self:PlaySceneSound();
	end

	mUIManager:ReturnPrevQueueWindow();
end

function QueueWindow:PlaySceneSound()
	mSceneManager:GetCurScene():PlaySound();
end

return QueueWindow;
