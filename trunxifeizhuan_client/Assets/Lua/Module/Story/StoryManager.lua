local mViewEnum = require "Enum/ViewEnum"
local LuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mConfigSysstory = require "ConfigFiles/ConfigSysstory"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local StoryManager = LuaClass("StoryManager");

function StoryManager:OnLuaNew()
	self.mStoryParam = {};
end

function StoryManager:OnPlayStory(id, callBack)
	if id == nil or id == 0 then
		callBack();
		return;
	end
	local param = self.mStoryParam;
	local story = mConfigSysstory[id];
	if story == nil then
		print('无效的剧情  '..id)
		return;
	end
	param.sys_story  =story;
	param.callBack = callBack;

	if story.ui_type == 1 then
		mUIManager:HandleUI(mViewEnum.StoryFullScreenView,1, param);
	else
		mUIManager:HandleUI(mViewEnum.StoryDialogViewNew,1, param);
	end
end

local instance = StoryManager.LuaNew();
return instance;