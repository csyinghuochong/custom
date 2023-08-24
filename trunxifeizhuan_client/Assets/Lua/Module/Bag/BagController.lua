local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mBaseController = require "Core/BaseController"

local BagController = mLuaClass("BagController",mBaseController);

--协议处理--
function BagController:AddNetListeners()
    self.mS2C:PLAYER_BAG(function(pbGoodList)
		mGameModelManager.BagModel:RecvGoodsListResult(pbGoodList);
	end);

	self.mS2C:PLAYER_BAG_REFRESH(function(pbGoodList)
		mGameModelManager.BagModel:RecvGoodsListRefresh(pbGoodList);
		self:Dispatch(mEventEnum.ON_GOODS_UPDATE);
		mGameModelManager.DraftModel.mBagUpdate = true;
	end);
    
    self.mS2C:PLAYER_SELL_GOOD(function(pbResult)
		self:Dispatch(mEventEnum.ON_SELL_GOODS_RESULT);
	end);
    self.mS2C:PLAYER_USE_GOOD(function(pbResult)
    	
    end)
end

--事件处理--
function BagController:AddEventListeners()
	
end

function BagController:OpenSellView(data)
	mUIManager:HandleUI(mViewEnum.BagGoodsSellView,1,data);
end

function BagController:OpenGetView(data)
	mUIManager:HandleUI(mViewEnum.ItemGetView,1,data);
end

function BagController:SendGetBagGoodsList()
	self.mC2S:PLAYER_BAG();
end

--出售物品
function BagController:SendSellGoods(goodsType, ID, Num)
	if mGameModelManager.BagModel:IsMansionGoods ( goodsType ) then
		local MansionController = require "Module/Mansion/MansionController"
		MansionController:SendSellGoods(goodsType, ID, Num);
	else
		local tableSell = {};
		local data = {id=ID,num=Num};
		table.insert(tableSell,data)
		self.mC2S:PLAYER_SELL_GOOD(tableSell);
	end 
end

--批量出售
function BagController:SendSellBatchGoods(tableSell)
	self.mC2S:PLAYER_SELL_GOOD(tableSell);
end

function BagController:SendUseGoods(goodsID,num)
	self.mC2S:PLAYER_USE_GOOD(goodsID,num);
end

local mUseTable = {[1] = {},
                   [2] = {viewName = "FollowerView",params = {jumpParams = 2}},
                   [3] = {viewName = "FollowerView",params = {jumpParams = 3}},
                   [4] = {viewName = "FollowerView",params = {jumpParams = 4}},
                   [5] = {viewName = "BowlderView",params = {jumpParams = 1}},
                   [6] = {viewName = "BowlderView",params = {jumpParams = 2}},
                   [7] = {viewName = "BowlderView",params = {jumpParams = 3}},
                   [8] = {viewName = "BowlderView",params = {jumpParams = 4}},
                   [9] = {viewName = "KingView",params = {jumpParams = 1}},
                  [10] = {viewName = "DraftView"},
                  [11] = {viewName = "LeadView",params = {jumpParams = 2}},
                  [12] = {viewName = "LeadView",params = {jumpParams = 3}}
               }

function BagController:GoodsUse(useType,uid)
	if useType == 1 then
      self:SendUseGoods(uid,1);
	else
	  local viewName = mUseTable[useType].viewName;
	  local params = mUseTable[useType].params;
      mUIManager:HandleUI(mViewEnum[viewName],1,params);
	end
end

local mBagControllerInstance = BagController.LuaNew();
return mBagControllerInstance;