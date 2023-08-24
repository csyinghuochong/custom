local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mLanguage = require "Utils/LanguageUtil"
local mAlertView = require "Module/CommonUI/AlertView"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mBattleActorItemView = require "Module/BattleArray/BattleActorItemView"
local mBattleFollowerListView = require "Module/BattleArray/BattleFollowerListView"
local BattleArrayView = mLuaClass("BattleArrayView", mQueueWindow);
local mString = require 'string'
local mTable = require 'table'
local mVector3 = Vector3;

function BattleArrayView:InitViewParam()
	return {
		["viewPath"] = "ui/battle_array/",
		["viewName"] = "battle_array_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
		["cost"] = {"strength"},
	};
end

function BattleArrayView:Init()
	self.mTextTitle = self:FindComponent('Text_title', 'Text');
	self.mCloseButton = self:Find('common_bg/Button_close').gameObject;
	self:AddBtnClickListener(self.mCloseButton, function() self:ReturnPrevQueueWindow() end);
	
	local selectFollowerBack = function( followerData )
		self:OnClickBattleFollower( followerData );
	end
	self:RegisterEventListener(mEventEnum.ON_SELECT_BATTLE_FOLLOWER, selectFollowerBack, true);
	self:RegisterEventListener(mEventEnum.SCENE_LOADING_SHOW, function()self:OnClickHideView()end, true);

	self:InitSubComponent( );
	self:InitBattleFollowerList();
	self.mCanvas = self:FindComponent(nil,"Canvas");
end

function BattleArrayView:InitActorItemList(  )
	if self.mSelfArray ~= nil then
		return;
	end
	
	self:InitSelfItemList();
	self:InitEnemyItemList();
end

function BattleArrayView:InitSelfItemList( )
	local selfArray = {};
	local canOpLead = self.mData.mCanOpLead or false;
	for i = 1, self.mTeamMaxNumber do
		selfArray[i] = mBattleActorItemView.LuaNew(1, self:Find(mString.format('self_%d', i)).gameObject, canOpLead); 
	end
	self.mSelfArray = selfArray;
end

function BattleArrayView:InitEnemyItemList( )
	local enemyArray = {};
	for i = 1, self.mEnemyMaxNumber do
		enemyArray[i] = mBattleActorItemView.LuaNew(2, self:Find(mString.format('enemy_%d', i)).gameObject);
	end
	self.mEnemyArray = enemyArray;
end

function BattleArrayView:InitSubComponent()
	self.mTextLabel = self:FindComponent('Text_label', 'Text');
	self.mTextStrength = self:FindComponent('Text_strength', 'Text');
	self.mTextCost = self:FindComponent('Guide_Array_Button_Challenge/Text_cost', 'Text');
	self.mImageCost2 = self:FindComponent('Guide_Array_Button_Challenge/Image_ss', 'Image');
	self:FindAndAddClickListener('Guide_Array_Button_Challenge', function() self:CheckBattleArray() end,'ty_0205', 0.5);
end

function BattleArrayView:InitBattleFollowerList()
	local listView = mBattleFollowerListView.LuaNew();
	listView.mGoParent = self:Find('list_view');
	self.mBattleFollowerListView = listView;
end

function BattleArrayView:OnClickBattleFollower( followerData )
	local followerVO = followerData.follower;
	local selected = followerData.state;
	local selfHeros = self.mData.mSelfHeros;
	if selected then
		if mTable.getn(selfHeros) < self.mTeamMaxNumber then
			self:InsertArrayFollower( selfHeros, followerVO );
		else
			self:ShowSelectFullAlert( );
			return;
		end
	else
		for k, v in pairs(selfHeros) do
			if v.mUID == followerVO.mUID then
				mTable.remove(selfHeros, k);
			end
		end
	end
	self:ShowSelfTeam( selfHeros );	
	self:Dispatch(mEventEnum.ON_REFRESH_FOLLOWER_SELECT, followerData);
	self:OnSelectBattleFollower(followerVO.mUID, selected);
end

function BattleArrayView:InsertArrayFollower(  selfHeros, followerVO )
	mTable.insert(selfHeros, followerVO);
end

function BattleArrayView:ShowSelectFullAlert(  )
	local  mDesc = mLanguage.follower_Selected_full;
	mCommonTipsView.Show(mDesc);
end

function BattleArrayView:OnSelectBattleFollower(uid,selected)
	self.mBattleFollowerListView:OnSelectBattleFollower(uid, selected);
end

function BattleArrayView:OnViewShow(logicParams)
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
	self.mBattleFollowerListView.mTeamMaxNumber = data.mTeamMaxNumber;
	self:Dispatch(self.mEventEnum.ON_BATTLE_ARRAY_SHOW_VIEW);
end

function BattleArrayView:UpdateCostView( data )
	local roleModel = mGameModelManager.RoleModel;
	local viewParams = self.mViewParams;
	if data.mCostType == roleModel.mTypeEnum.mEnumCostEnergy then
		viewParams.cost = {"energy"};
	else
		viewParams.cost = {"strength"};
	end

	self:HandleWindowCostUI(1,viewParams);
end

function BattleArrayView:OnViewHide(  )
	self.mBattleFollowerListView:HideView();
	self:Dispatch(mEventEnum.ON_BATTLE_ARRAY_HIDE_VIEW);
end

function BattleArrayView:GetLastResource( data )
	local roleModel = mGameModelManager.RoleModel;
	local playerBase = roleModel.mPlayerBase;
	if data.mCostType == roleModel.mTypeEnum.mEnumCostEnergy then
		return playerBase.energy, 'common_city_icon_10', mLanguage.battle_cost_energy;
	else
		return playerBase.sp, 'common_city_icon_9', mLanguage.battle_cost_strength;
	end
end

function BattleArrayView:ShowBaseInfo( data )
	self.mTextTitle.text = data.mLevelName;
	self.mTextCost.text = data.mCostStrength;

	local last_number, icon, cost_text =  self:GetLastResource(data);
	self.mTextLabel.text = cost_text;
	self.mTextStrength.text = last_number;
	self.mGameObjectUtil:SetImageSprite(self.mImageCost2, icon);
end

function BattleArrayView:ShowSelectList(selfHeros)
	self.mBattleFollowerListView:ShowView(selfHeros);
	self.mBattleFollowerListView.mCallBack = function(state)
		self:SetCanvasState(state);
	end
end

function BattleArrayView:SetCanvasState(state)
	self.mCanvas.enabled = state;
end

function BattleArrayView:ShowSelfTeam( selfHeros )
	for k, v in pairs(self.mSelfArray) do
		v:SetData(selfHeros[k]);
	end
end

function BattleArrayView:ShowEnemyTeam( enemyHeros )
	for k, v in pairs(self.mEnemyArray) do
		local vo = enemyHeros[k];
		if vo ~= nil then
			v:ShowView();
			v:SetData(vo);
		else
			v:HideView();
		end
	end
end

function BattleArrayView:CheckBattleArray()
	local num = table.getn(self.mData.mSelfHeros)
	local IsSurplusFollower = self.mBattleFollowerListView:IsSurplusFollower(num);
	if num < self.mTeamMaxNumber and IsSurplusFollower then
		local  mDesc = mLanguage.follower_enter_battle_des;
		mAlertView.Show({title=nil, desc1=mDesc, desc2=nil, btnName= nil,CallBack = function()self:OnClickChallenge(); end, btnNumber = 2});
	else
		self:OnClickChallenge();
	end
end

function BattleArrayView:OnClickChallenge( )
	local data = self.mData;
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

	self:CallBack();
end

function BattleArrayView:CallBack(  )
	local data = self.mData;
	local callBack = data.mCallBack;
	if callBack ~= nil then
		callBack(data);
	end
end

function BattleArrayView:OnClickSaveTeam(  )
	self:OnClickHideView();
	local data = self.mData;
	local callBack = data.mCallBack;
	if callBack ~= nil then
		callBack(data);
	end
end

function BattleArrayView:Dispose()
	self.mSelfArray = nil;
	self.mEnemyArray = nil;
	self.mBattleFollowerListView:CloseView();
end

return BattleArrayView;
