local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mGameTimer = require "Core/Timer/GameTimer"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"
local mConfigSysstory = require "ConfigFiles/ConfigSysstory"
local mStoryBaseView = require "Module/Story/StoryBaseView"
local StorySceneView = require "Module/Story/StorySceneView"
local StoryFullScreenView = mLuaClass("StoryFullScreenView",mStoryBaseView);
local GameObject = UnityEngine.GameObject;
local mStartVector = mVector3.New(-452, 212, 0);
local mVector3 = Vector3;
local mTable = require "table"

function StoryFullScreenView:InitViewParam()
	return {
		["viewPath"] = "ui/story/",
		["viewName"] = "story_fullscreen_view",
		["ParentLayer"] = mCommonStoryLayer,
	};
end

function StoryFullScreenView:Init()
	self.mTextItem = self:Find("Text_content");
	self.mTextItem.gameObject:SetActive(false);
	self:FindAndAddClickListener('Button_skip',function() self:OnEndDialog() end);

	self.mStorySceneView = StorySceneView.LuaNew( self:Find('main_bg').gameObject ); 
end

function StoryFullScreenView:OnViewShow()
	local data = self.mLogicParams;
	self.mCallBack = data.callBack;
	self.mDialogList = data.sys_story.story_dialogs;
	self.mDialogIndex = 1;

	self:OnClickNext();
	self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);
	self.mStorySceneView:LoadMainBg(data.sys_story.main_bg);
end

function StoryFullScreenView:OnTimerInterval()
	self:OnClickNext();
end

function StoryFullScreenView:OnClickNext()
	local dialog_index = self.mDialogIndex;
	local dialog_list = self.mDialogList;

	if(dialog_index <= mTable.getn(dialog_list)) then
		self:ShowDialogContent(dialog_list[dialog_index]);
	else
		self:OnEndDialog();
	end

	self.mDialogIndex = dialog_index + 1;
end

function StoryFullScreenView:ShowDialogContent(data)
	local text_item = GameObject.Instantiate(self.mTextItem);
	local text_transform = text_item.transform;

	text_item.gameObject:SetActive(true);
	mGameObjectUtil:SetParent(text_transform, self.mTransform);
	local text_pos = mStartVector + mVector3(44 * self.mDialogIndex, 0, 0);
	text_transform.localPosition = text_pos;
	text_item:GetComponent('Text').text = data.chinese_content;

	self:PlaySoundName(data.sound_id);
end

function StoryFullScreenView:OnEndDialog()
	self:HideView();

	local call_back = self.mCallBack;
	if call_back ~= nil then
		call_back();
	end
end

function StoryFullScreenView:OnViewHide()
	self:DisposeMap();
	local time_interval = self.mTimerInterval;
	if  time_interval ~= nil then	
		time_interval:Dispose();
		time_interval = nil;
	end

	self.mTimerInterval = time_interval;
end

function StoryFullScreenView:Dispose()
	self.mStorySceneView:DisposeMap();
end

return StoryFullScreenView;

