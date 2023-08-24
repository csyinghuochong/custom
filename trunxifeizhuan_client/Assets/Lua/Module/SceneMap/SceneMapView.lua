local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local GameObject = UnityEngine.GameObject;
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mAssetManager = require "AssetManager/AssetManager"
local SceneMapView = mLuaClass("SceneMapView");
local mTable = table

--0 不做处理
--1 只匹配位置
--2 匹配宽度和位置
function SceneMapView:OnLuaNew(parent)
	self.mGoParent = parent;

	self.mLoadBgComplete = function ( go )
		self:OnLoadBgComplete(go);
	end
end

function SceneMapView:Dispose(  )
	self.mMap = nil;
	GameObject.DestroyImmediate(self.mGameObject);

	local fxList = self.mFxList;
	if fxList then
		for i,v in ipairs(fxList) do
			GameObject.DestroyImmediate(v);
		end
	end
end

function SceneMapView:ShowCombatBg( bg )
	if self.mMap == bg then
		return;
	end
	if self.mGameObject ~= nil then
		self:Dispose(  );
	end

	self.mMap = bg;
	mUIManager:LoadView('ui/scene_map/', bg, self.mLoadBgComplete);
end

local mStandardWidth = 1024;
function SceneMapView:OnLoadBgComplete( go )
	self.mGameObject = go;
	local fxList = {};
	self.mFxList = fxList;

	local goTransform = go.transform;
	local parent = self.mGoParent;

	mGameObjectUtil:SetParent(goTransform,parent);
	mGameObjectUtil:RestRectTransform(goTransform);
	goTransform.localRotation = Vector3.zero;
	goTransform:SetSiblingIndex(0);

	--[[local childCount = goTransform.childCount;
	for i = 1, childCount do
		local item_go = goTransform:GetChild(i - 1).gameObject;

		if string.len(item_go.name) > 3 then
			local callBack = function ( go )
				mGameObjectUtil:SetParent(go.transform, item_go.transform)

				fxList[#fxList + 1] = go;
			end

			mAssetManager.LoadUIFXExternal(item_go.name, callBack);
			local scale = item_go.transform.localScale.x;
			item_go.transform.localScale = Vector3.one * scale * mUIManager.mDeviceWidth / mStandardWidth ;
		end
	end]]
end

return SceneMapView;