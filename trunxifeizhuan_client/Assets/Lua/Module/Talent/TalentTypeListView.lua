local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local TalentTypeVO = require "Module/Talent/TalentTypeVO"
local mGameModelManager = require "Manager/GameModelManager"
local mLayoutController = require "Core/Layout/LayoutController"
local ConfigSystalent_type = require "ConfigFiles/ConfigSystalent_type"
local TalentTypeListView = mLuaClass("TalentTypeListView", mBaseView);
local mSuper = nil;

function TalentTypeListView:OnLuaNew(go, params)
	self.mGoodsType = params;
	
	mSuper = self:GetSuper(mBaseView.LuaClassName);
    mSuper.OnLuaNew(self, go);
end

function TalentTypeListView:Init()
	local parent = self:Find('scrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Talent/TalentTypeItemView");
end

function TalentTypeListView:OnViewShow( goods_type )
	if goods_type ~= nil then
		self.mGoodsType = goods_type;
	end
	self:UpdateTypeList(  );
end

function TalentTypeListView:UpdateTypeList(  )
	local data =  mSortTable.LuaNew(function(a, b) return self:Sort(a,b) end, nil, true);
	local goods_type = self.mGoodsType;
	for k, v in pairs( ConfigSystalent_type ) do
		local number = self:GetTalentTypeNum( goods_type, k );
		data:AddOrUpdate( k, TalentTypeVO.LuaNew( goods_type, k, v, number, nil ) )
	end

	self.mGridEx:UpdateDataSource( data );
end

function TalentTypeListView:GetTalentTypeNum( goods_type, talent_type )
	local sortTale = mGameModelManager.FollowerModel:GetTalentTable( goods_type, talent_type );
	return #sortTale.mSortTable;
end

function TalentTypeListView:Sort( a, b )
	return a.mTalentType < b.mTalentType;
end

function TalentTypeListView:OnViewHide(  )
	
end

function TalentTypeListView:Dispose( )
	self.mGridEx:Dispose();
end

return TalentTypeListView;