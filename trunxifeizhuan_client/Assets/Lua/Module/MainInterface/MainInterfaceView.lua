local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local mGameTimer = require "Core/Timer/GameTimer"
local mAlertView = require "Module/CommonUI/AlertView"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysexp = require "ConfigFiles/ConfigSysexp"
local mCameraController = require "Manager/CameraController"
local mConfigsysfunction = require "ConfigFiles/ConfigSysfunction_open"
local mConfigsysfunctionConst = require "ConfigFiles/ConfigSysfunction_openConst"
local MainInterfaceView = mLuaClass("MainInterfaceView",mQueueWindow);
local mFunctionOpenManager = require "Module/MainInterface/FunctionOpenManager"
require "Module/Face/FaceConfig"
local mSensitiveWordUtil = require "Utils/SensitiveWordUtil"
local Application = UnityEngine.Application;
local mCommonChatButton = require "Module/CommonUI/CommonChatButton"
local mGuideController = require "Module/Guide/GuideController"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"

local mReceivePowerController = require "Module/ReceivePower/RecievePowerController"
local mMainRestorePower = require "Module/MainInterface/MainRestorePower"

local mVetor3 = Vector3;
local mAnimator = UnityEngine.Animator;
local mDGTween = DG.Tweening.ShortcutExtensions;
local mGameLuaInterface = GameLuaInterface;

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgSystem = mLanguageUtil.chat_system;
local mLgWan = mLanguageUtil.wan;
local mLgYi = mLanguageUtil.yi;
local mLgCombat = mLanguageUtil.common_combat;
local mLgLevelMax = mLanguageUtil.common_level_max;

function MainInterfaceView:InitViewParam()
	return {
		["viewPath"] = "ui/main_interface/",
		["viewName"] = "main_interface_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = -1, --UIManager:OnLayerShow需要显示mMainSceneLayer
		["ForbitSound"] = true,
		["AdditionalShaderChannels"] = true,
	};
end

function  MainInterfaceView:Init()
	self.mTweener = nil;
	self.mExpandButton = true;
	self.mIsAnimator = false;
	self.mArrowTransform = self:Find("BottomRight/Button_arrow");
	self.mBRTransform_1 = self:Find("BottomRight/GameObject1");
	self.mBRTransform_2 = self:Find("BottomRight/GameObject2");
	--self.mBRAnimatorList = self:Find("BottomRight"):GetComponentsInChildren(typeof(mAnimator));
	self.mTextCoin = self:FindComponent('TopRight/GameObject/Image_silver/Text_count', 'Text');
	self.mTextGold = self:FindComponent('TopRight/GameObject/Image_gold/Text_count', 'Text');
	self.mTextSp = self:FindComponent('TopRight/GameObject/Image_strength/Text_count', 'Text');
	self.mTextEnergy = self:FindComponent('TopRight/GameObject/Image_energe/Text_count', 'Text');
	self.mTextLv = self:FindComponent('TopLeft/GameObject/Text_lv', 'Text');
	self.mTextName = self:FindComponent('TopLeft/GameObject/Text_name', 'Text');
	self.mTextCombat = self:FindComponent('TopLeft/GameObject/Text_power', 'Text');
	local goChatButton = self:Find("TopRight/InputField_chat").gameObject;
	self.mChatButton = mCommonChatButton.LuaNew(goChatButton);
	local mEnergyTime = self:FindComponent('TopRight/GameObject/Image_energe/Time','Text');
	local mStrengthTime = self:FindComponent('TopRight/GameObject/Image_strength/Time','Text');
	local mSpRestoreBtn = self:Find("TopRight/GameObject/Image_strength/RestoreBtn").gameObject;
	local mEnergeRestoreBtn = self:Find("TopRight/GameObject/Image_energe/RestoreBtn").gameObject;
	self.mRestorePower = mMainRestorePower.LuaNew(mSpRestoreBtn,mEnergeRestoreBtn,mStrengthTime,mEnergyTime);

	self.mTextExp = self:FindComponent('TopLeft/GameObject/Text_exp', 'Text');
	self.mSliderExp = self:FindComponent('TopLeft/GameObject/Slider_exp/Slider', 'Slider');
	self.mGameImageHead = self:FindComponent("TopLeft/GameObject/Image_head_icon/head","GameImage");
	self:FindAndAddClickListener('TopLeft/GameObject/Image_head_icon',function() self:OnClickHead() end);
	self:FindAndAddClickListener('BottomRight/Button_arrow',function() self:OnClickArrowButton() end,"ty_0204");
	self:FindAndAddClickListener('TopRight/GameObject/Image_gold/Button',function() self:OnClickAdd() end);
	self:FindAndAddClickListener('TopRight/GameObject/Image_silver/Button',function() self:OnClickAdd() end);
	self:FindAndAddClickListener('TopRight/GameObject/Image_strength/Button',function() self:OnClickAdd() end);
	self:FindAndAddClickListener('TopRight/GameObject/Image_energe/Button',function() self:OnClickAdd() end);
	
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.CHAPTERLIST,self:FindAndAddClickListenerReturnTrance('Left/GameObject/Guide_Button_Story',function() self:OnClickStoryButton() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.ACHIEVE_TASK, self:FindAndAddClickListenerReturnTrance('Left/GameObject/Button_task',function() self:OnClickTaskButton() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.RANK, self:FindAndAddClickListenerReturnTrance('Left/GameObject/Button_rank',function() self:OnClickRank() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.MAIL, self:FindAndAddClickListenerReturnTrance('Left/GameObject/Button_mail',function() self:OnClickMail() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.ROLE, self:FindAndAddClickListenerReturnTrance('BottomRight/GameObject2/Button_player',function() self:OnClickPlayerButton() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.FOLLOWER, self:FindAndAddClickListenerReturnTrance('BottomRight/GameObject2/Guide_Button_Follower',function() self:OnClickFollowerButton() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.BAG, self:FindAndAddClickListenerReturnTrance('BottomRight/GameObject2/Button_bag',function() self:OnClickBagButton() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.FRIEND, self:FindAndAddClickListenerReturnTrance('BottomRight/GameObject2/Button_social',function() self:OnClickSocialButton() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.MANSION, self:FindAndAddClickListenerReturnTrance('BottomRight/GameObject2/Button_mansion',function() self:OnClickMansionButton() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.FIRST_CHARGE, self:FindAndAddClickListenerReturnTrance('BottomRight/GameObject1/Button_charge_dis',function() self:OnClickChargeButton() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.DAY_ACTIVITY, self:FindAndAddClickListenerReturnTrance('BottomRight/GameObject1/Button_wonderful_activity',function() self:OnClickWonderfulButton() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.STORE, self:FindAndAddClickListenerReturnTrance('BottomRight/GameObject1/Button_mall',function() self:OnClickMall() end).gameObject);
	mFunctionOpenManager:RegisterFunctionGo(mConfigsysfunctionConst.TIME_ACTIVITY, self:FindAndAddClickListenerReturnTrance('BottomRight/GameObject1/Button_mansion_activity',function() self:OnClickTimeActivyButton() end).gameObject);
	
	if Application.isEditor then
		self:FindAndAddClickListenerReturnTrance('Left/GameObject/Button_gm',function() self:OnClickGmButton() end);		
	end

	mGuideController:SendGetGuideInfo();

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_STRENGTH, function(value) self:UpdateSpOrEnerge(value); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_ENERGY,function(value) self:UpdateSpOrEnerge(value); end,true);	
	self:RegisterEventListener(mEventEnum.ON_RESTORE_UPDATE_STRENGTH, function(value) self:UpdateSp(value); end,true);
	self:RegisterEventListener(mEventEnum.ON_RESTORE_UPDATE_ENERGY,function(value) self:UpdateEnerge(value); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_COIN,function(value) self:UpdateCoin(value); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_GOLD,function(value) self:UpdateGold(value); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_LEVEL,function(value) self:UpdateLevel(value); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_EXP,function(value) self:UpdateExp(value); end,true);
	self:RegisterEventListener(mEventEnum.ON_LEAD_COMBAT_UPDATE,function(combat) self:UpdateCombat(combat); end,true);
end

function MainInterfaceView:OnViewShow()
	self:UpdateRoleInfo();
	mCameraController:OnEnterMainScene();
	self.mRestorePower:IsShowView(true);
end

function MainInterfaceView:OnViewHide(removeQueueWindow)
	if removeQueueWindow then
		mUIManager:RemoveQueueWindow(self);		
	end
	self.mRestorePower:IsShowView(false);
end

function MainInterfaceView:UpdateRoleInfo(  )
	local roleBase = mGameModelManager.RoleModel.mPlayerBase;
	
	self:UpdateName(roleBase.name);
	self:UpdateLevel(roleBase.level);
	self:UpdateCoin(roleBase.coin);
	self:UpdateGold(roleBase.gold);
	self:UpdateSp(roleBase.sp);
	self:UpdateEnerge(roleBase.energy);
	self:UpdateExp(roleBase.exp);
	self:SetHead(roleBase.sex);

	local followerModel = mGameModelManager.FollowerModel;
	self:UpdateCombat(followerModel:GetLeadCombat());
end

function MainInterfaceView:UpdateName( name )
	self.mTextName.text = name;
end

function MainInterfaceView:UpdateLevel( level )
	self.mTextLv.text = level;
	self:CheckIsMaxLevel(level);
end

function MainInterfaceView:CheckIsMaxLevel(level)
	local maxLevel = mConfigSysglobal_value[mConfigGlobalConst.PLAYER_MAX_LV];
	if level >= maxLevel then
		self.mTextExp.text = mLgLevelMax;
		self.mSliderExp.value = 0;
	end
end

function MainInterfaceView:UpdateCoin( coin )
	self.mTextCoin.text = self:GetNumString(coin);
end

function MainInterfaceView:UpdateGold( gold )
	self.mTextGold.text = self:GetNumString(gold);
end

function MainInterfaceView:UpdateCombat( combat )
	self.mTextCombat.text = mLgCombat..combat;
end

function MainInterfaceView:SetHead(sex)
	if sex == 2 then
		self.mGameImageHead:SetSprite("city_head_10201");
	else
		self.mGameImageHead:SetSprite("city_head_10103");
	end
end

function MainInterfaceView:GetNumString(Num)
	if Num >= 1000000000 then
		local num1,num2 = math.modf(Num/100000000);
		return num1..mLgYi;
	elseif Num >= 100000 then
		local num1,num2 = math.modf(Num/10000);
		return num1..mLgWan;
	else
		return tostring(Num);
	end
end

function MainInterfaceView:UpdateSpOrEnerge()
	mMainRestorePower:RefreshRestoreData();
end

function MainInterfaceView:UpdateSp( sp )
	self.mTextSp.text = sp.."/100";
end

function MainInterfaceView:UpdateEnerge( energy )
	self.mTextEnergy.text = energy.."/10";
end

function MainInterfaceView:UpdateExp( exp )
	local level = mGameModelManager.RoleModel.mPlayerBase.level
	local maxExp = mConfigSysexp[level].lead_exp;
	self.mTextExp.text = exp.."/"..maxExp;
	self.mSliderExp.maxValue = maxExp;
	self.mSliderExp.minValue = 0;
	self.mSliderExp.value = exp;
	self:CheckIsMaxLevel(level);
end

function MainInterfaceView:OnClickArrowButton()
	is_animator = self.mIsAnimator;
	if(is_animator) then return end

	self.mIsAnimator = true;
	local expand = self.mExpandButton;
	local arrow_transform = self.mArrowTransform;
	local transform_1 = self.mBRTransform_1;
	local transform_2 = self.mBRTransform_2;
	
	if(expand) then
		expand = false;
		mGameLuaInterface.DOScale(transform_1, mVetor3.New(0, 0, 0), 0.3, function() self:ShowButtonAnimator(false) end);
		mDGTween.DOScale(transform_2, mVetor3.New(0, 0, 0), 0.3);
		arrow_transform.localEulerAngles = mVetor3.New(0, 0, 45);
	else
		expand = true;
		mGameLuaInterface.DOScale(transform_1, mVetor3.New(1, 1, 1), 0.3, function() self:ShowButtonAnimator(true) end);
		mDGTween.DOScale(transform_2, mVetor3.New(1, 1, 1), 0.3);
		arrow_transform.localEulerAngles = mVetor3.New(0, 0, 0);
	end

	self.mExpandButton = expand;
end

function MainInterfaceView:ShowButtonAnimator(show_animator)
	self.mIsAnimator = false;

	--[[if(show_animator) then
		animator_list = self.mBRAnimatorList;
		for i = 0 , animator_list.Length - 1  do
			animator_list[i]:CrossFade("Pressed", 0);
		end
	end--]]
end

--剧情
function MainInterfaceView:OnClickStoryButton()
	mUIManager:HandleUI(mViewEnum.DungeonStoryEntryView, 1);
end

--角色
function MainInterfaceView:OnClickPlayerButton()
	mUIManager:HandleUI(mViewEnum.LeadView,1);
end

--随从
function MainInterfaceView:OnClickFollowerButton()
	mUIManager:HandleUI(mViewEnum.FollowerMainView,1);
end

--玉石
function MainInterfaceView:OnClickStoneButton()
	
end

--才艺
function MainInterfaceView:OnClickPromoteButton( )
	
end

--府邸
function MainInterfaceView:OnClickMansionButton()
	mUIManager:HandleUI(mViewEnum.MansionMainView,1);
end

--首充
function MainInterfaceView:OnClickChargeButton()
	
end

--任务
function MainInterfaceView:OnClickTaskButton()
	mUIManager:HandleUI(mViewEnum.TaskView,1);
end

--背包
function MainInterfaceView:OnClickBagButton()
	mUIManager:HandleUI(mViewEnum.BagView,1);
end

function MainInterfaceView:OnClickGmButton()
	mUIManager:HandleUI(mViewEnum.GmView, 1);
end

--好友
function MainInterfaceView:OnClickSocialButton()
	mUIManager:HandleUI(mViewEnum.FriendView,1);
end

--邮件
function MainInterfaceView:OnClickMail()
	mUIManager:HandleUI(mViewEnum.MailView,1);
end

--每日限时
function MainInterfaceView:OnClickWonderfulButton()
end

--商城
function MainInterfaceView:OnClickMall()
	mUIManager:HandleUIWithParent(mMainLayer,mViewEnum.StoreView,1);
end

--排行榜
function MainInterfaceView:OnClickRank()
	mUIManager:HandleUI(mViewEnum.RankView,1);
	--mUIManager:HandleUI(mViewEnum.WorshipQueenView,1);
end

--限时活动
function MainInterfaceView:OnClickTimeActivyButton()
	
end

function MainInterfaceView:OnClickAdd()
	local data = { first = 1, second = 1 };
	mUIManager:HandleUIWithParent(mMainLayer,mViewEnum.StoreView,1, data);
end

function MainInterfaceView:OnClickHead()
	mUIManager:HandleUI(mViewEnum.SetView,1);
end

function MainInterfaceView:Dispose()
	self.mChatButton:CloseView();
	self.mRestorePower:CloseView();
end

return MainInterfaceView;
