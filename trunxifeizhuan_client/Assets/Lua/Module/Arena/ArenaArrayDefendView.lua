local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBattleArrayView = require "Module/BattleArray/BattleArrayView"
local ArenaArrayDefendView = mLuaClass("ArenaArrayDefendView", mBattleArrayView);

function ArenaArrayDefendView:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arena_array_defend_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function ArenaArrayDefendView:InitEnemyItemList( )
	--none
end

function ArenaArrayDefendView:InitSubComponent(  )
	self:FindAndAddClickListener('button_challenge', function() self:OnClickSaveTeam() end,'ty_0205');
end

function ArenaArrayDefendView:ShowBaseInfo( data )
	self.mTextTitle.text = data.mLevelName;	
end

function ArenaArrayDefendView:ShowEnemyTeam( enemyHeros )
	--none
end

return ArenaArrayDefendView;