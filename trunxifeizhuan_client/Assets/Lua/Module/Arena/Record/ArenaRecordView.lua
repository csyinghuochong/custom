local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local mSortTable = require "Common/SortTable"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local mArenaController = require "Module/Arena/ArenaController"
local mArenaRecordVO = require "Module/Arena/Record/ArenaRecordVO"
local ArenaRecordView = mLuaClass("ArenaRecordView",mQueueWindow);
local GameObject = UnityEngine.GameObject;
local mIpairs = ipairs;

function ArenaRecordView:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arena_record_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function ArenaRecordView:Init()
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow() end);

	local parent = self:Find('scrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Arena/Record/ArenaRecordItemView");
	self.mDataSource = mSortTable.LuaNew(function(a, b) return a.mTime > b.mTime end, nil, true);

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_ARENA_ENEMT, function(pbEnemyList)
		self:OnRecvEnemyList( pbEnemyList );
	end, true);
end

function ArenaRecordView:OnViewShow(  )
	mArenaController:SendGetArenaEnemy();
end

function ArenaRecordView:OnRecvEnemyList( pbEnemyList )
	local data = self.mDataSource;
	data:ClearDatas(true);
	
	for k, v in mIpairs(pbEnemyList.enemy) do
		data:AddOrUpdate(k, mArenaRecordVO.LuaNew(v));
	end

	self.mGridEx:UpdateDataSource(data);
end

function ArenaRecordView:DisPose(  )
	self.mGridEx:DisPose();
	self.mGridEx = nil;
end

return ArenaRecordView;