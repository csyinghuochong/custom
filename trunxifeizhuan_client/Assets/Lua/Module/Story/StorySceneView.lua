local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local StorySceneView = mLuaClass("StorySceneView",mBaseView);
local GameObject = UnityEngine.GameObject;
local mSuper = nil;

function StorySceneView:OnLuaNew(go, callBack)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self,go);

	self.mLoadBgComplete = function ( go )
    	self:OnLoadBgComplete(go);
    end
    self.mCallBack = callBack;
end

function StorySceneView:LoadMainBg( bg )
	if bg == nil and bg == "" then
		return;
	end

	if bg == self.mMainMap then
		return;
	end
	self:DisposeMap();
	self.mMainMap = bg;

	mUIManager:LoadView('ui/common_bg/', bg, self.mLoadBgComplete);
end

function StorySceneView:OnLoadBgComplete(go)
	if go ~= nil then
		self.mMainMapObj = go;
		mGameObjectUtil:SetParent(go.transform, self.mTransform);
		mGameObjectUtil:RestRectTransform(go.transform);
	end
	local callBack = self.mCallBack;
	if callBack ~= nil then
		callBack( );
	end
end

function StorySceneView:DisposeMap(  )
	if self.mMainMapObj ~= nil then
		GameObject.DestroyImmediate(self.mMainMapObj);
		self.mMainMapObj = nil;
	end
	self.mMainMap = nil;
end

return StorySceneView;