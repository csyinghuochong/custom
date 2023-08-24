local mLuaClass = require "Core/LuaClass"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local mAssetLoaderManager = require("AssetManager/AssetLoaderManager")
local GameObjectUtil = mLuaClass("GameObjectUtil",mEventDispatcherInterface);
local mVector3 = Vector3;
local mEventEnum = require "Enum/EventEnum"

function GameObjectUtil:OnLuaNew()
	self:AddEventListener(mEventEnum.MEMORY_DISPOSE,function(reLogin)
		if reLogin then
			self.mCommonImageSprites = nil;
			self.mCommonBundle = nil;
		end
	end)
end

function GameObjectUtil:SetParent(childTransform,parentTransform)
	if not childTransform then
		return
	end

	childTransform:SetParent(parentTransform);
	childTransform.localPosition = mVector3.zero;
	childTransform.localScale = mVector3.one;
end

function  GameObjectUtil:RestRectTransform(go)
	local rectTransfrom = go:GetComponent('RectTransform');
	rectTransfrom.sizeDelta = mVector3.zero;
end

function GameObjectUtil:SetImageSprite(image,spriteName)
	local commonImageSprites = self.mCommonImageSprites;
	if commonImageSprites == nil then
		commonImageSprites = {};
		self.mCommonImageSprites = commonImageSprites;
	end

	local sprite = commonImageSprites[spriteName];
	if sprite == nil then
		local commonBundle = self.mCommonBundle;
		if commonBundle == nil then
			commonBundle = mAssetLoaderManager:GetBundle("common/common2",false).mBundle;
			self.mCommonBundle = commonBundle;
		end
		
		sprite = commonBundle:LoadAsset(spriteName);
		commonImageSprites[spriteName] = sprite;
	end

	image.sprite = sprite;
end

local instance = GameObjectUtil.LuaNew();
return instance;