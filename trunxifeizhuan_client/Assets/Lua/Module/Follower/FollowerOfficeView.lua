local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonGoodsVO = require"Module/CommonUI/CommonGoodsVO";
local mFollowerController = require "Module/Follower/FollowerController"
local mFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FollowerOfficeAttriView = require "Module/Follower/FollowerOfficeAttriView"
local CommonGoodsNeedItemView = require "Module/CommonUI/CommonGoodsNeedItemView"
local FollowerOfficeView = mLuaClass("FollowerOfficeView",mCommonTabBaseView);

function FollowerOfficeView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_office_view",
	};
end

function FollowerOfficeView:Init()
	self:SetParent(self.mGoParent);
	self.mView1 = FollowerOfficeAttriView.LuaNew(self:Find('view1').gameObject);
	self.mView2 = FollowerOfficeAttriView.LuaNew(self:Find('view2').gameObject);
	self.mView3 = FollowerOfficeAttriView.LuaNew(self:Find('view3').gameObject);
	self.mView1:HideView( );
	self.mView2:HideView( );
	self.mView3:HideView( );

	self.mTextCurOffice = self:FindComponent('Text_office1', 'Text');
	self.mTextNextOffice = self:FindComponent('Text_office2', 'Text');

	self.mFollowerItem1 = mFollowerItemView.LuaNew(self:Find('retinue_1').gameObject);
	self.mFollowerItem2 = mFollowerItemView.LuaNew(self:Find('retinue_2').gameObject);

	local goods_list = {};
	for i =1, 2 do
		goods_list[i] = CommonGoodsNeedItemView.LuaNew(self:Find('goodsGrid/goods_item'..i).gameObject);
	end
	self.mGoodsItemList = goods_list;

	self:FindAndAddClickListener("Button_1", function() self:OnClickUpOffice() end, nil, 0.5);
end

function FollowerOfficeView:OnUpdateUI(data)
	self.mData = data;
	
	self:UpdateCost(data);
	self:UpdateAttribute(data);
	self:UpdateOffice( data);
end

function FollowerOfficeView:OnOfficeUp( vo )
	
	self:OnUpdateUI( vo );
end 

function FollowerOfficeView:UpdateCost(data)
	local cost_list = data:GetOfficeVO().cost;
	local goods_list = self.mGoodsItemList;
	local goods_number = self.mGoodsNumberList;
	local bagModel = mGameModelManager.BagModel;

	for i = 1, 2 do
		local cost = cost_list[i];
		if cost ~= nil then
			goods_list[i]:ShowView();
			goods_list[i]:ExternalUpdate(mCommonGoodsVO.LuaNew(cost.goods_id, cost.goods_number));
		else
			goods_list[i]:HideView();
		end
	end
end

function FollowerOfficeView:UpdateAttribute(data)
	local vo1, vo2 = data:GetUpOfficeSkill( );

	local curView = self.mCurView;
	if curView then
		curView:HideView( );
	end
	if vo1 and vo2 then
		curView = self.mView3;
	elseif vo1 then
		curView = self.mView2;
	else
		curView = self.mView1;
	end

	curView:ShowView();
	curView:OnUpdateUI( data, vo1, vo2 );
	self.mCurView = curView;
end

function FollowerOfficeView:UpdateOffice( data )
	self.mTextCurOffice.text = data:GetOfficeVO( ).office_name;
	self.mTextNextOffice.text = data:GetNextOffice( ).office_name;

	self.mFollowerItem1:ExternalUpdateData(data);
	self.mFollowerItem2:ExternalUpdateData(data:GetNextOfficeClone( ));
end

function FollowerOfficeView:OnClickUpOffice()
	mFollowerController:SendFollowerOfficeUp(self.mData.mUID);
end

return FollowerOfficeView;