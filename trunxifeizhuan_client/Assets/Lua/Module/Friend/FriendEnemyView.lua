local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mFriendVO = require "Module/Friend/FriendVO"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mAlertView = require "Module/CommonUI/AlertView"
local mGameModelManager = require "Manager/GameModelManager"
local mFriendController = require "Module/Friend/FriendController"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FriendEnemyView = mLuaClass("FriendEnemyView",mCommonTabBaseView);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgOK = mLanguageUtil.friend_info_delete_ok;

local mLgDeleteEnemyTitle = mLanguageUtil.friend_enemy_delete_title;
local mLgDeleteEnemyDesc1 = mLanguageUtil.friend_info_delete_desc1;
local mLgDeleteEnemyDesc2 = mLanguageUtil.friend_enemy_delete_desc2;

function FriendEnemyView:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_enemy_view",
	};
end

function FriendEnemyView:Init()
	local parent = self:Find('scrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Friend/FriendEnemyItem");
	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_RECIVE_ENEMYLIST,function(enemyList)self:OnUpdateUI(enemyList);end,true);
	self:RegisterEventListener(mEvent.ON_OPEN_ENEMY_DELETE_POPUP,function(data)self:OpenEnemyDeletePopup(data);end,true);
end

function FriendEnemyView:ReciveEnemyList(enemyList)
	local list = enemyList;
	if list ~= nil then
		local data_soure = mSortTable.LuaNew(nil,nil,true);
		for k,v in pairs(list) do
			if v.id ~= nil then
				local enemyData = mFriendVO.LuaNew(v,false);
				data_soure:AddOrUpdate(enemyData.id,enemyData);
			end
		end
		self.mGridEx:UpdateDataSource(data_soure);
		self.mDataSoure = data_soure;
	end
end

function FriendEnemyView:ReciveDeleteEnemy(result)
	local selectData = self.mSelectData;
	if selectData ~= nil then
		self.mDataSoure:RemoveKey(selectData.id);
	end
end

function FriendEnemyView:OpenEnemyDeletePopup(data)
	local model = mGameModelManager.FriendModel;
	model.mFriendData = data;
	mAlertView.Show({title=mLgDeleteEnemyTitle,desc1=mLgDeleteEnemyDesc1,desc2=data.name,btnName=mLgOK,CallBack=function(enemyData)self:DeleteEnemy(data);end});
end

function FriendEnemyView:DeleteEnemy(data)
	mFriendController:SendDeleteEnemyList(data.id);
end

function FriendEnemyView:OnUpdateUI(data)
	local model = mGameModelManager.FriendModel;
	if model.mIsEverGetEnemy then
		self.mGridEx:UpdateDataSource(model.mDataSoureEnemy);
	else
		model.mIsEverGetEnemy = true;
		mFriendController:SendGetEnemyList();
	end
end

function FriendEnemyView:Dispose( )
	self.mGridEx:Dispose();
end

return FriendEnemyView;