local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local mBattleFollowerListView = require "Module/BattleArray/BattleFollowerListView"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local EndlessMeirenArrayListView = mLuaClass("EndlessMeirenArrayListView",mBattleFollowerListView);
local mSuper;

function EndlessMeirenArrayListView:Init()
	self:SetParent(self.mGoParent);
	self.mSelectList = {};
	local parent = self:Find('scrollView/Guide_Array_Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/EndlessDungeon/Meirenxinji/EndlessMeirenArrayItemView");
	self.mGridEx:SetExternalDataToItems(parent:GetComponents(typeof(GameImage)));
	self:FindAndAddClickListener('Btn', function() self:OnClickTeam() end);
end

function EndlessMeirenArrayListView:UpdateFollowerList()
	local data = mGameModelManager.FollowerModel.mFolloweList2;
	data:SetDatasDirty();
	self.mGridEx:UpdateDataSource(data);
end

function EndlessMeirenArrayListView:OnClickTeam()
	local data = mGameModelManager.FollowerModel.mFolloweList1;
	mUIManager:HandleUI(mViewEnum.EndlessFollowerListArrayView,1,{data_souce = data,follower_list = self.mSelectFollower,TeamMaxNumber = self.mTeamMaxNumber,callBack = self.mCallBack});
	local callBack = self.mCallBack;
	if callBack ~= nil then
		callBack(false);
	end
end

function EndlessMeirenArrayListView:IsSurplusFollower(num)
	local FollowerNum = num;
	local count = self:GetAliveNum();
	local teamMax = self.mTeamMaxNumber;
	if FollowerNum < teamMax and count > FollowerNum then	
		return true;	
	end
	return false;
end

function EndlessMeirenArrayListView:GetAliveNum()
	local num = 0;
	local sortTable = self.mGridEx.mSortTable.mSortTable;
	for k,v in ipairs(sortTable) do
		if v:GetMeirenCurrentHp() > 0 then
			num = num + 1;
		end
	end
	return num;
end

function EndlessMeirenArrayListView:ShowSelectList()
	local follower_list = self.mSelectFollower;
	for k, v in pairs(follower_list) do
		local child = self.mGridEx:GetChild(v.mUID);
		if child ~= nil  and child.mData:GetMeirenCurrentHp() > 0 then
			child:ShowSelectedFlag(true);
		end
	end
end

function EndlessMeirenArrayListView:Dispose()
	self.mGridEx:Dispose();
end

return EndlessMeirenArrayListView;