local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local CommonGoodsNeedItemView = require "Module/CommonUI/CommonGoodsNeedItemView"
local MansionComposeNeedItem = mLuaClass("MansionComposeNeedItem", CommonGoodsNeedItemView);
local mSuper = nil;

function MansionComposeNeedItem:Init( )
   mSuper = self:GetSuper(CommonGoodsNeedItemView.LuaClassName);
   mSuper.Init(self);
end

function MansionComposeNeedItem:GetGoodsCurrentNum( data )
    local bagModel = mGameModelManager.MansionModel;
    return bagModel:GetGoodsNumberGoodsId(data.mID);
end

return MansionComposeNeedItem