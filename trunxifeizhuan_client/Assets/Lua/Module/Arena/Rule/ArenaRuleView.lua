local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mSortTable = require "Common/SortTable"
local GameTimer = require "Core/Timer/GameTimer"
local ManualView = require "Module/CommonUI/ManualView"
local mLayoutController = require "Core/Layout/LayoutController"
local ArenaRuleAwardVO = require "Module/Arena/Rule/ArenaRuleAwardVO"
local mConfigSysmanualConst = require "ConfigFiles/ConfigSysmanualConst";
local ConfigSysarena_division = require "ConfigFiles/ConfigSysarena_division"
local ArenaRuleView = mLuaClass("ArenaRuleView", ManualView);
local mSuper = nil;

function ArenaRuleView:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arena_rule_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] =mViewBgEnum.gray_clickable,
	};
end

function ArenaRuleView:Init(  )
	local parent = self:Find('scrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Arena/Rule/ArenaRuleAwardItem");
	
	self.mTextTitle = self:FindComponent("TextTitle","Text");
	self.mTextDesc1 = self:FindComponent('scrollView/Grid/TextDesc', 'Text' );
	self.mTransformDesc = self:Find( 'scrollView/Grid/TextDesc' );
	self.mTransformAward = self:Find( 'scrollView/Grid/AwardDesc' );

	mSuper = self:GetSuper(ManualView.LuaClassName);
	mSuper.ShowManualDesc( self, mConfigSysmanualConst.ARENADUNGEON);
	self:ShowAwardList(  );
end

function ArenaRuleView:ShowAwardList(  )
	local data = mSortTable.LuaNew(function(a, b) return a.mID < b.mID end, nil, true);
	for k , v in pairs ( ConfigSysarena_division ) do
		data:AddOrUpdate(k, ArenaRuleAwardVO.LuaNew( k, v ));
	end
	self.mGridEx:UpdateDataSource( data, function()
		GameTimer.SetTimeout(0.1, function (  )
			self:RefreshPosition( );
		end );
	end );
end

function ArenaRuleView:RefreshPosition(  )
	self.mTransformDesc:SetSiblingIndex( 0 );
	self.mTransformAward:SetSiblingIndex( 1 );
end

function ArenaRuleView:Dispose(  )
	self.mGridEx:Dispose( );
	self.mGridEx = nil;
end

return ArenaRuleView;