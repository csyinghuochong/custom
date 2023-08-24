local mLuaClass = require "Core/LuaClass"
local mBattleArrayView = require "Module/BattleArray/BattleArrayView"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mEndlessMeirenArrayListView = require "Module/EndlessDungeon/Meirenxinji/EndlessMeirenArrayListView"
local mEndlessXinjiBuffView = require "Module/EndlessDungeon/Meirenxinji/EndlessXinjiBuffView"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mLanguage = require "Utils/LanguageUtil"
local mTable = require 'table'
local mAlertView = require "Module/CommonUI/AlertView"
local mEndlessBattleActorItemView = require "Module/EndlessDungeon/Meirenxinji/EndlessBattleActorItemView"
local mViewBgEnum = require "Enum/ViewBgEnum"
local EndlessBattleArrayView = mLuaClass("EndlessBattleArrayView",mBattleArrayView);
local mString = string;

function EndlessBattleArrayView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_battle_array_view",
		["ParentLayer"] = mMainLayer1,
		--["cost"] = {"gold","energy"},
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function EndlessBattleArrayView:InitSelfItemList( )
	local selfArray = {};
	local canOpLead = self.mData.mCanOpLead or false;
	for i = 1, self.mTeamMaxNumber do
		selfArray[i] = mEndlessBattleActorItemView.LuaNew(1, self:Find(mString.format('self_%d', i)).gameObject, canOpLead); 
	end
	self.mSelfArray = selfArray;
end

function EndlessBattleArrayView:OnViewShow(logicParams)
    if logicParams ~= nil then
		self.mData = logicParams;
	end

	local data = self.mData;
	self.mTeamMaxNumber = data.mTeamMaxNumber;
	self.mEnemyMaxNumber = data.mEnemyMaxNumber;
	self:InitActorItemList(  );
	self:ShowBaseInfo( data );
	self:UpdateCostView( data );
	self:ShowSelfTeam( data.mSelfHeros );
	self:ShowEnemyTeam( data.mEnemyHeros );
	self:ShowSelectList( data.mSelfHeros);
	self.mEndlessMeirenArrayListView.mTeamMaxNumber = data.mTeamMaxNumber;
	self:Dispatch(self.mEventEnum.ON_BATTLE_ARRAY_SHOW_VIEW);
end

function EndlessBattleArrayView:OnSelectBattleFollower(uid,selected)
	self.mEndlessMeirenArrayListView:OnSelectBattleFollower(uid, selected);
end

function EndlessBattleArrayView:ShowSelectList(selfHeros)
	self.mEndlessMeirenArrayListView:ShowView(selfHeros);
	self.mEndlessMeirenArrayListView.mCallBack = function(state)
		self:SetCanvasState(state);
	end
end

function EndlessBattleArrayView:InitBattleFollowerList()
	local listView = mEndlessMeirenArrayListView.LuaNew();
	listView.mGoParent = self:Find('list_view');
    self.mEndlessMeirenArrayListView = listView;
end

function EndlessBattleArrayView:CheckBattleArray()
	local num = table.getn(self.mData.mSelfHeros)
	local IsSurplusFollower = self.mEndlessMeirenArrayListView:IsSurplusFollower(num);
	if num < self.mTeamMaxNumber and IsSurplusFollower then
		local  mDesc = mLanguage.follower_enter_battle_des;
		mAlertView.Show({title=nil, desc1=mDesc, desc2=nil, btnName= nil,CallBack = function()self:OnClickChallenge(); end, btnNumber = 2});
	else
		self:OnClickChallenge();
	end
end

function EndlessBattleArrayView:OnClickChallenge( )
	local data = self.mData;
	local canBattleHeros = data.mSelfHeros;
	if #canBattleHeros == 0 then
       mCommonTipsView.Show(mLanguage.endless_use_one_hero);
       return;
	end
	local cost = data.mCostStrength;
	local costType = data.mCostType;
	local roleModel = mGameModelManager.RoleModel;
	local playerBase = roleModel.mPlayerBase;

	if costType == roleModel.mTypeEnum.mEnumCostEnergy then
		if playerBase.energy < cost then
			mCommonTipsView.Show(mLanguage.common_energy_no_enough);
			return;
		end
	else 
		if playerBase.sp < cost then
			mCommonTipsView.Show(mLanguage.common_strength_no_enough);
			return;
		end
	end
	local callBack = data.mCallBack;
	if callBack ~= nil then
		callBack(data);
	end
	--self:ReturnPrevQueueWindow();
end

function EndlessBattleArrayView:OnViewHide(logicParams)
   self.mEndlessMeirenArrayListView:HideView();
   self:Dispatch(self.mEventEnum.ON_BATTLE_ARRAY_HIDE_VIEW);
end

function EndlessBattleArrayView:Dispose()
	self.mSelfArray = nil;
	self.mEnemyArray = nil;
	self.mEndlessMeirenArrayListView:CloseView();
end

return EndlessBattleArrayView;