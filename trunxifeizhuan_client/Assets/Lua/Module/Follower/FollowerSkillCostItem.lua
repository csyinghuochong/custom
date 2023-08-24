local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
local CommonGoodsItemView = require "Module/CommonUI/CommonGoodsItemView"
local CommonFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local FollowerSkillCostItem = mLuaClass("FollowerSkillCostItem", mLayoutItem);
local mSuper = nil;

function FollowerSkillCostItem:InitViewParam()
    return {
      ["viewPath"] = "ui/follower/",
      ["viewName"] = "follower_skill_cost_item",
    };
end

function FollowerSkillCostItem:Init( )
    self.mGoodsItem = CommonGoodsItemView.LuaNew( self:Find( 'goods' ).gameObject );
    self.mFollowerItem = CommonFollowerItemView.LuaNew( self:Find( 'follower' ).gameObject );

    local callBack = function (  )
      self:OnClickIcon( );
    end
    local button1 = self:FindComponent('goods/icon', 'Button');
    if button1 ~= nil then
        self:FindAndAddClickListener('goods/icon', callBack,"ty_0204");
    end
    local button2 = self:FindComponent('follower/icon', 'Button');
    if button2 ~= nil then
        self:FindAndAddClickListener('follower/icon', callBack,"ty_0204");
    end

    mSuper = self:GetSuper(mLayoutItem.LuaClassName);
    mSuper.Init(self);
end

--1消耗道具2消耗随从
function FollowerSkillCostItem:OnUpdateData()
    self:ExternalUpdate( self.mData );
end

function FollowerSkillCostItem:ExternalUpdate( data )
    if data == nil then
      return;
    end
    local cost_type = data.mCostType;
    local cost_vo = data.mCostVo;
    local goodsItem = self.mGoodsItem;
    local followerItem = self.mFollowerItem;
    if cost_type == 1 then
        goodsItem:ShowView( );
        followerItem:HideView( );
        goodsItem:ExternalUpdate( cost_vo )
    else
        goodsItem:HideView( );
        followerItem:ShowView( );
        followerItem:ExternalUpdateData( cost_vo )
    end
end

function FollowerSkillCostItem:UpdateGoodsNumber( number )
    self.mGoodsItem:ShowGoodsNumber( number );
end

function FollowerSkillCostItem:OnClickIcon()
    self:Dispatch(self.mEventEnum.ON_SELECT_UP_SKILL_COST, self.mData);
end

return FollowerSkillCostItem