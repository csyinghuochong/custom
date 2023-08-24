local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local ArenaController = require 'Module/Arena/ArenaController'
local ArenaRecordItemView = mLuaClass("ArenaRecordItemView",mLayoutItem);
local mSuper = nil;

function ArenaRecordItemView:InitViewParam()
	return {
		["viewPath"] = "ui/arena/",
		["viewName"] = "arena_record_item_view",
	};
end

function ArenaRecordItemView:Init( )
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mTextContext = self:FindComponent('Text_content', 'Text');

	self:FindAndAddClickListener('button_1', function() self:OnClickRevenge() end);
	self.mButtonRevenge = self:Find('button_1').gameObject;
	self.mRevengeWin = self:Find('button_2').gameObject;
	self.mRevengeFail = self:Find('button_3').gameObject;

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function ArenaRecordItemView:OnViewShow( )
	
end

--复仇结果，0未复仇，1复仇成功，2复仇失败
function ArenaRecordItemView:OnUpdateData()
	local data = self.mData;

	self.mTextName.text = data.mName;
	self.mTextContext.text = data:GetContent();
	local result = data.mRevengeResult;
	self.mButtonRevenge:SetActive(result == 0);
	self.mRevengeWin:SetActive(result == 1);
	self.mRevengeFail:SetActive(result == 2);
end

function ArenaRecordItemView:OnClickRevenge(  )
	ArenaController:SendPrepareArenaRevengeBattle(self.mData.mPlayerId);
end

return ArenaRecordItemView;