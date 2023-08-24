local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mSortTable = require "Common/SortTable"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameTimer = require "Core/Timer/GameTimer"
local mActorConfig = require "ConfigFiles/ConfigSysactor"
local mDraftConfig = require "ConfigFiles/ConfigSysdraft"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local mDraftController = require "Module/Draft/DraftController"
local mCommonSkillVO = require "Module/CommonUI/CommonSkillVO"
local mFollowerConfig = require "ConfigFiles/ConfigSysfollower_office_up"
local mFollowerItem = require "Module/CommonUI/CommonFollowerItemView"
local mFollowerVOControl = require "Module/Follower/FollowerVOControl"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mDGTween = DG.Tweening.ShortcutExtensions;
local mGameLuaInterface = GameLuaInterface;
local mVector3 = Vector3;
local mIpairs = ipairs
local mLanguage = require "Utils/LanguageUtil"
local mTypeList = {mLanguage.follower_type_name_1,
                    mLanguage.follower_type_name_2,
                    mLanguage.follower_type_name_3,
                    mLanguage.follower_type_name_4,
                    mLanguage.follower_type_name_5}
local DraftSuccessView = mLuaClass("DraftSuccessView", mQueueWindow);

local mDraftEffect1 = "ui_draft_success_view_01";
local mDraftEffect2 = "ui_draft_success_view_02";

function DraftSuccessView:InitViewParam()
	return {
		["viewPath"] = "ui/draft/",
		["viewName"] = "draft_success_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function DraftSuccessView:Init()
    self.mGoClick = self:Find("rectClick").gameObject;
    self.mModelShow = self:Find('modelShow').gameObject;
    self.mModel = self:Find('model').gameObject;
    self.mModelAttri = self:Find('modelAttri').gameObject;
    local draftStarList = {};
    local showStarList = {};
    for i = 1,5 do
    	local draftStar = self:Find('modelShow/starGrid/star'..i).gameObject;
    	local showStar = self:Find('modelAttri/star/star'..i).gameObject;
    	draftStarList[i] = draftStar;
    	showStarList[i] = showStar;
    end
    self.mDraftStarList = draftStarList;
    self.mShowStarList = showStarList;
    self.mDraftImage = self:FindComponent("modelShow/title", 'GameImage');
    self:FindAndAddClickListener("modelAttri/Guide_Draft_ConfirmBtn",function() self:ReturnPrevQueueWindow(); end);
    self:FindAndAddClickListener("BtnTalk",function() self:OnClickTalk(); end);
    self:FindAndAddClickListener("rectClick",function() self:OnClickRect(); end);
    self.mName = self:FindComponent("modelAttri/name","Text");
    self.mFollower = mFollowerItem.LuaNew(self:Find('modelAttri/followeritem').gameObject);
    self.mSkillGrid = mLayoutController.LuaNew(self:Find("modelAttri/skillGrid"), require "Module/CommonUI/CommonSkillItemView");
    self.mAttriGrid = mLayoutController.LuaNew(self:Find("modelAttri/Grid"), require "Module/Draft/DraftFollowerAttriItem");

    self.mFollowerNode = ModelRenderTexture.LuaNew( self:Find('model/modelObj'),true);

    self.mImgIcon = self:FindComponent("modelAttri/icon","Image");
    self.mTextType = self:FindComponent("modelAttri/type","Text");
    self.mGoTalk = self:Find("BtnTalk").gameObject;

    local textMaxLevel = self:FindComponent("modelAttri/lv","Text");
    textMaxLevel.text = mConfigSysglobal_value[mConfigGlobalConst.PLAYER_MAX_LV];
end

function DraftSuccessView:OnClickRect()
    self:ShowModel();
    self.mIsPlayAnimate = false;
    self.mEffectTrans.gameObject:SetActive(false);
    mGameTimer.SetTimeout(2, function()self:Move(false);end);
    self.mGoClick:SetActive(false);
end

function DraftSuccessView:OnClickTalk()
    local actor = self.mActorSys;
    if actor ~= nil then
        local data = {mID = actor.actor};
        mUIManager:HandleUIWithParent(mMainLayer2,mViewEnum.FollowerCommentView, 1, data);
    end
end

function DraftSuccessView:OnViewShow(logicParams)
    self.mGoTalk:SetActive(false);
    self.mFollowerId = logicParams.mId;
    self.mModelAttri:SetActive(false);
    local actorSys = mActorConfig[logicParams.mId];
    self.mActorSys = actorSys;
    self.mModel.transform.localPosition = mVector3.zero;
    local key = string.format("%d_%d", logicParams.mId, actorSys.position);
    local followerSys = mFollowerConfig[key];
    self.mFollowerSys = followerSys;

    self.mFollowerNode:OnUpdateUI( followerSys.model) ;

	local initStar = actorSys.star;
	local draftStarList = self.mDraftStarList
    for i,v in mIpairs(draftStarList) do
    	v:SetActive(i <= initStar);
    end
    local imageName = "recruit_word1";
    local trans;
    if logicParams.mType ~= 0 then
       local config = mDraftConfig[logicParams.mType];
       if initStar >= config.star then
          imageName = "recruit_word2";
          --特效 to do
          trans = self:GetTransEffect(2);
       else
          trans = self:GetTransEffect(1);
       end
    else
        trans = self:GetTransEffect(1);
    end
    trans.gameObject:SetActive(true);
    self.mEffectTrans = trans;
    self.mDraftImage:SetSprite(imageName);
    self.mIsPlayAnimate = true;
    self.mGoClick:SetActive(true);
    mGameTimer.SetTimeout(2, function()self:ShowModel();end);
end

function DraftSuccessView:ShowModel()
    if not self.mIsPlayAnimate then
        return;
    end
    self.mFollowerNode:ShowView();
    self.mModelShow:SetActive(true);
    self.mGoClick:SetActive(false);
    mGameTimer.SetTimeout(2, function()self:Move(true);end);
end

function DraftSuccessView:Move(isCheck)
    local transform = self.mEffectTrans;
    if transform ~= nil then
        transform.gameObject:SetActive(false);
    end
    if not self.mIsPlayAnimate and isCheck then
        return;
    end
	self.mModelShow:SetActive(false);
	self.mModelAttri.transform.localPosition = mVector3(mUIManager:GetDeviceWidth()/2,0,0);
	self.mModelAttri:SetActive(true);
    self.mAttriGrid:Reset();
    self:InitFollowerInfo()
    self.mGoTalk:SetActive(true);
	mDGTween.DOLocalMoveX(self.mModelAttri.transform, 0, 1,true);
	mGameLuaInterface.DOLocalMoveX(self.mModel.transform, -mUIManager:GetDeviceWidth()/4, 1, function() self:OnMoveEnd() end);
end

function DraftSuccessView:OnMoveEnd()
    self:Dispatch(mEventEnum.ON_RUN_NEXT_STEP);
end

function DraftSuccessView:GetTransEffect(index)
    local trans;
    if index == 1 then
        trans = self.mTransEffect1;
        if trans == nil then
            trans = self:Find("Effect1");
            self:AddUIEffect(mDraftEffect1, trans);
            self.mTransEffect1 = trans;
        end
        return trans;
    else
        trans = self.mTransEffect2;
        if trans == nil then
            trans = self:Find("Effect2");
            self:AddUIEffect(mDraftEffect2, trans);
            self.mTransEffect2 = trans;
        end
        return trans;
    end
end

function DraftSuccessView:InitFollowerInfo()
	local actorSys = self.mActorSys;
	local followerSys = self.mFollowerSys;
    local star = actorSys.star;
    local showStarList = self.mShowStarList
    for i,v in mIpairs(showStarList) do
    	v:SetActive(i <= star);
    end
    self.mName.text = actorSys.name;
    self.mGameObjectUtil:SetImageSprite(self.mImgIcon,"common_power_"..actorSys.camp);
    self.mTextType.text = mTypeList[actorSys.type];
    local data_soure = mSortTable.LuaNew();
    for i,v in mIpairs(followerSys.skills) do
    	data_soure:AddOrUpdate(i,mCommonSkillVO.LuaNew(v,0,true,true));
    end
    self.mSkillGrid:UpdateDataSource(data_soure);
    
    local followerData = mFollowerVOControl:CreateConfigFollowerVO(self.mFollowerId);
    self.mFollower:ExternalUpdateData(followerData);
    local data_attri = mSortTable.LuaNew();
    for i,v in mIpairs(actorSys.base_attri) do
        local key = v.key
        if key == 1 or key == 2 or key == 3 or key == 8 then
            local data = {key = v.key,value = v.value,actor = actorSys.actor};
            data_attri:AddOrUpdate(i,data);
        end
    end
    self.mAttriGrid:UpdateDataSource(data_attri);
end

function DraftSuccessView:OnViewHide()
	self.mFollowerNode:HideView( );
    self.mEffectTrans.gameObject:SetActive(false);
end

function DraftSuccessView:Dispose()
	self.mSkillGrid:Dispose();
	self.mAttriGrid:Dispose();
    self.mFollowerNode:Dispose();
end

return DraftSuccessView;