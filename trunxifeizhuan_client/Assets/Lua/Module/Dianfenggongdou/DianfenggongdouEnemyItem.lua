local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local DianfenggongdouController = require 'Module/Dianfenggongdou/DianfenggongdouController'
local DianfenggongdouEnemyItem = mLuaClass("DianfenggongdouEnemyItem",mLayoutItem);
local mSuper = nil;

function DianfenggongdouEnemyItem:InitViewParam()
	return {
		["viewPath"] = "ui/dianfenggongdou/",
		["viewName"] = "dianfenggongdou_enemy_item",
	};
end

function DianfenggongdouEnemyItem:Init( )
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mTextContext = self:FindComponent('Text_content', 'Text');

	self:FindAndAddClickListener('button_1', function() self:OnClickRevenge() end);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function DianfenggongdouEnemyItem:OnViewShow( )
	
end

function DianfenggongdouEnemyItem:OnUpdateData()
	local data = self.mData;

	self.mTextName.text = data.mName;
	self.mTextContext.text = data:GetContent();
end

function DianfenggongdouEnemyItem:OnClickRevenge(  )
	DianfenggongdouController:SendPrepareArenaRevengeBattle(self.mData.mPlayerId);
end

return DianfenggongdouEnemyItem;