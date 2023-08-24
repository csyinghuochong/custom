local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum";
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mEventEnum = require "Enum/EventEnum"
local mPreloadManager = require "Manager/PreloadManager"
local mConfigSysdungeon_play = require "ConfigFiles/ConfigSysdungeon_play"
local SceneLoadingView = mLuaClass("SceneLoadingView", mBaseWindow);
local mAssetLoaderManager = require("AssetManager/AssetLoaderManager")
local mUpdateManager = require "Manager/UpdateManager"
local GC = System.GC


function SceneLoadingView:InitViewParam()
	return {
		["viewPath"] = "ui/scene_loading/",
		["viewName"] = "scene_loading_view",
		["ParentLayer"] = mSceneLoadingLayer,
		["ForbitSound"] = true,
	};
end

function SceneLoadingView:Init()
	self.mTextTip = self:FindComponent("Text_tip", "Text");
	self.mSlider = self:FindComponent("Slider","Slider");

	self:RegisterEventListener(mEventEnum.SCENE_START_PRELOAD, function()
		self:OnBattlePreload();
	end, true);
end

function SceneLoadingView:OnUpdate()
	if self.mProgress > 0.9 and #mAssetLoaderManager.mTasks >0 then
		return;
	end

	local progress = self.mProgress + self.mProgressValue;
	self.mProgress = progress;
	self.mSlider.value = progress;

	if progress >= 1 then
		self:HideView();
	end
end

function SceneLoadingView:RandomGetTip( play_type )
	local tip = '';
	if play_type ~= nil then
		local player_vo = mConfigSysdungeon_play[play_type];
		if player_vo == nil then
			print('ConfigSysdungeon_play == nil,  玩法id: '..play_type)
			return tip;
		end
		local tip_list = player_vo.load_tips;
		return tip_list[math.random(1, table.getn(tip_list))];
	end
	return tip;
end

function SceneLoadingView:OnBattlePreload()
	mPreloadManager:OnBattlePreload();
	mUpdateManager:AddUpdate(self);

	GC.Collect();
	collectgarbage("collect");
end

function SceneLoadingView:OnViewShow(play_type)
	self:Dispatch(mEventEnum.SCENE_LOADING_SHOW);
	self.mProgressValue = 0.02;
	self.mProgress = 0;
	self.mSlider.value = self.mProgress;
	self.mTextTip.text = self:RandomGetTip(play_type);
end

function SceneLoadingView:OnViewHide()
	mUpdateManager:RemoveUpdate(self);
	self:Dispatch(mEventEnum.SCENE_LOADING_HIDE);
end

return SceneLoadingView;