local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mQueueWindow = require "Core/QueueWindow"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local DianfenggongdouController = require "Module/Dianfenggongdou/DianfenggongdouController"
local mDianfenggongdouEnemyVO = require "Module/Dianfenggongdou/DianfenggongdouEnemyVO"
local DianfenggongdouEnemyView = mLuaClass("DianfenggongdouEnemyView",mQueueWindow);
local GameObject = UnityEngine.GameObject;

function DianfenggongdouEnemyView:InitViewParam()
	return {
		["viewPath"] = "ui/dianfenggongdou/",
		["viewName"] = "dianfenggongdou_enemy_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function DianfenggongdouEnemyView:Init()
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow() end);

	local parent = self:Find('scrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Dianfenggongdou/DianfenggongdouEnemyItem");

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_PROMOTE_ENEMT, function(pbEnemyList)
		self:OnRecvEnemyList( pbEnemyList );
	end, true);
end

function DianfenggongdouEnemyView:OnViewShow(  )
	DianfenggongdouController:SendGetArenaEnemy();
end

function DianfenggongdouEnemyView:OnRecvEnemyList( pbEnemyList )
	local data = mSortTable.LuaNew(function(a, b) return a.mTime > b.mTime end, nil, true);

	for k, v in ipairs(pbEnemyList.enemy) do
		data:AddOrUpdate(k, mDianfenggongdouEnemyVO.LuaNew(v));
	end

	self.mGridEx:UpdateDataSource(data);
end

function DianfenggongdouEnemyView:DisPose(  )
	self.mGridEx:DisPose();
	self.mGridEx = nil;
end

return DianfenggongdouEnemyView;