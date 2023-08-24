local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mTimeUtil = require "Utils/TimeUtil"
local mGameTimer = require "Core/Timer/GameTimer"
local mLayoutController = require "Core/Layout/LayoutController"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mConfigSysnpc = require "ConfigFiles/ConfigSysnpc"
local mMysteryController = require "Module/Mystery/MysteryController"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local MysteryView = mLuaClass("MysteryView", mQueueWindow);

function MysteryView:InitViewParam()
	return {
		["viewPath"] = "ui/mystery/",
		["viewName"] = "mystery_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["full_cost"] = {"gold","silver","strength","energy"},
		["ChangeSceneDispose"] = true,
	};
end

function MysteryView:Init()
	self.mModelShowViewQueen = mModelShowView.LuaNew(self:Find('queenModel'));

	self.mTextTime = self:FindComponent("Window/Bottom/Time","Text");
	self.mTextCost = self:FindComponent("Window/Bottom/Cost","Text");
	self.mTextCost.text = mConfigSysglobal_value[mConfigGlobalConst.SHOP_MYSTERY_REFRESH_CONSUME];

	local parent = self:Find("Window/scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Mystery/MysteryItem");

	self:FindAndAddClickListener("Window/Bottom/Btn",function() self:OnClickRefresh(); end);
	self:FindAndAddClickListener("Button_return",function() self:ReturnPrevQueueWindow(); end);

	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_GET_MYSTERY_LIST,function(data)
		self:CreateList(data);
		self:CreateTime();
		end,true);
end

function MysteryView:OnClickRefresh()
	mMysteryController:SendRefresh();
end

function MysteryView:OnViewShow(logicParams)
	local bustIcon1 = mConfigSysnpc[205].model;
    self.mModelShowViewQueen:ShowView();
    self.mModelShowViewQueen:OnUpdateUI(bustIcon1);

    self:CreateList(nil);
    self:CreateTime();
end

function MysteryView:CreateList(data)
	local model = mGameModelManager.MysteryModel;
    if model.mIsEverGetList then
    	self.mGridEx:UpdateDataSource(model.mDataSoure);
    else
    	model.mIsEverGetList = true;
    	mMysteryController:SendGetList();
    end
end

function MysteryView:CreateTime()
	if self.mTimerInterval ~= nil then
		self.mTimerInterval:Stop();
	end
	local model = mGameModelManager.MysteryModel;
	if model.mTime == 0 then
		return;
	end
	local second = model.mTime - mGameModelManager.LoginModel:GetCurrentTime();
	if second < 0 then
		second = 0;
	end

	self.mSecond = second;
	self.mTimerInterval = mGameTimer.SetInterval(1, function() self:OnTimerInterval() end);
	self:OnTimerInterval();
end

function MysteryView:OnTimerInterval()
	local second = self.mSecond;
	if second <= 0 then
		self.mTimerInterval:Stop();
		mMysteryController:SendGetList();
	else
		self.mTextTime.text = mTimeUtil:TransToHourMinSec(second);
		self.mSecond = self.mSecond - 1;
	end
end

function MysteryView:TimeStop()
	local time_interval = self.mTimerInterval;
	if time_interval ~= nil then	
		time_interval:Dispose();
		self.mTimerInterval = nil;
	end
end

function MysteryView:Dispose()
	self.mModelShowViewQueen:Dispose();
	self:TimeStop();
end

function MysteryView:OnViewHide()
	self.mTextTime.text = "";
	self.mModelShowViewQueen:HideView();
	self:TimeStop();
end

return MysteryView;