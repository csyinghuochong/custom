local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local CampDungeonToggleItemView = mLuaClass("CampDungeonToggleItemView", mLayoutItem);
local mSuper = nil;

function CampDungeonToggleItemView:InitViewParam()
	return {
		["viewPath"] = "ui/camp_dungeon/",
		["viewName"] = "camp_dungeon_toggle_item_view",
	};
end

function CampDungeonToggleItemView:Init( )
	self.mTextName = self:FindComponent("Name","Text");
	self:FindAndAddClickListener("Back",function()self:OnClickItem()end)
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function CampDungeonToggleItemView:OnClickItem()
	self:Dispatch(self.mEventEnum.ON_SELECT_CAMP_TOGGLE,self.mData);
end

function CampDungeonToggleItemView:OnViewShow( )
	
end

function CampDungeonToggleItemView:OnUpdateData()
	self:ExternalUpdate(self.mData);
end

--外部调用
function CampDungeonToggleItemView:ExternalUpdate(data)
	if data ~= nil then
		local config = mConfigSysdungeon[data.id];
		self.mTextName.text = config.dungeon_name;
	end
end

return CampDungeonToggleItemView;