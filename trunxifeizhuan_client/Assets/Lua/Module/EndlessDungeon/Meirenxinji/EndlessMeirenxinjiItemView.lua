local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mColor = Color
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mGameModelManager = require "Manager/GameModelManager"
local mUIManager = require "Manager/UIManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local EndlessMeirenxinjiItemView = mLuaClass("EndlessMeirenxinjiItemView", mBaseView);
local mSuper = nil;

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgNextNotOpen = mLanguageUtil.endless_not_open;

function EndlessMeirenxinjiItemView:Init()
	self.mTextName = self:FindComponent("name","Text");
	self.mTextLevel = self:FindComponent("level","Text");
	self.mTextIndex = self:FindComponent("index","Text");
	self.mGoLose = self:Find("lose").gameObject;
	self.mMonsterModel = mModelShowView.LuaNew(self:Find('model'));
	self.mIsShowModel = false;
	self.mRawImgModel = self:FindComponent("model","RawImage");

	self:FindAndAddClickListener("model",function()self:OnClickItem()end);
end

function EndlessMeirenxinjiItemView:OnClickItem()
	local data = self.mData;
	local meirenxinjiData = mGameModelManager.EndlessDungeonModel.mMeirenxinjiData;
	local nowBattleID = meirenxinjiData.mBattleID;
	if meirenxinjiData.mStatus == 0 then
		if data.mBattleID == nowBattleID then
			self:Dispatch(self.mEventEnum.ON_SHOW_MEIRENXINJI_ROTATION,data);
		elseif data.mBattleID > nowBattleID then
			mCommonTipsView.Show(mLgNextNotOpen);
		end
	end
end

function EndlessMeirenxinjiItemView:SetData(data)
	self.mData = data;
	self.mTextName.text = data.mName;
	self.mTextLevel.text = data.mLevel;
	self.mTextIndex.text = data.mID;

	local meirenxinjiData = mGameModelManager.EndlessDungeonModel.mMeirenxinjiData;
	local nowBattleID = meirenxinjiData.mBattleID;
	if data.mBattleID < nowBattleID or meirenxinjiData.mStatus == 1 then
		self.mGoLose:SetActive(true);
		self.mRawImgModel.color = mColor.New(0.5,0.5,0.5,1);
	else
		self.mGoLose:SetActive(false);
		self.mRawImgModel.color = mColor.white;
	end

	self.mMonsterModel:OnUpdateLead(data.mSex);
	self:CalculateIsShowModel();
end

function EndlessMeirenxinjiItemView:CalculateIsShowModel()
	local nowPosX = mGameModelManager.EndlessDungeonModel.mNowPosX;
	local monsterPosX = self.mTransform.localPosition.x;
	local nowLeftPos = -nowPosX - mUIManager:GetDeviceWidth()/2 - 200;
	local nowRightPos = -nowPosX + mUIManager:GetDeviceWidth()/2 + 200;
	if monsterPosX >= nowLeftPos and monsterPosX <= nowRightPos then
		self:ChangeModelState(true);
	else
		self:ChangeModelState(false);
	end
end

function EndlessMeirenxinjiItemView:OnViewHide()
	self.mMonsterModel:HideView();
	self.mIsShowModel = false;
end

function EndlessMeirenxinjiItemView:ChangeModelState(state)
	if state and not self.mIsShowModel then
		self.mMonsterModel:ShowView();
		self.mIsShowModel = true;
	end
	if not state and self.mIsShowModel then
		self.mMonsterModel:HideView();
		self.mIsShowModel = false;
	end
end

return EndlessMeirenxinjiItemView;