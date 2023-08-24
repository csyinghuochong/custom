local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mBaseModel = require "Core/BaseModel"
local mDoFileUtil = require "Utils/DoFileUtil";
local mBagGoodsVO = require"Module/Bag/BagGoodsVO"
local mEventDispatcher = require "Events/EventDispatcher"
local mGameModelManager = require "Manager/GameModelManager"
local MansionModel = mLuaClass("MansionModel",mBaseModel);
local mipairs = ipairs
local mTable = table;

function MansionModel:OnLuaNew()

end

--MansionSelfVO  自己
--MansionVisitVO 拜访
--MansionAgentVO 代理

--进入自己府邸
function MansionModel:OnRecvEnterSelfMansion( pb_info )
	self.mData = mDoFileUtil:DoFile("Module/Mansion/MansionSelfVO").LuaNew( pb_info );
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_SELF_MANSION_DATA, self.mData);
end

function MansionModel:OnRecvMansionInfoUpdate( pbMansion )
	
end

--修改府邸名字
function MansionModel:OnRecvAlterMansionName( name )
	self.mData:OnAtlerMansionName( name );
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_ALTER_MANSION_NAME, self.mData);
end

--返回可串门的玩家列表
function MansionModel:OnRecvPlayerList( pbMansionVisitList )
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_CAN_VISIT_PLAYER_LIST, pbMansionVisitList);
end

--进入拜访玩家府邸
function MansionModel:OnRecvEnterVisitMansion(  pb_info )
	self.mData = mDoFileUtil:DoFile("Module/Mansion/MansionVisitVO").LuaNew( pb_info );
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_VISIT_MANSION_DATA, self.mData);
end

--返回府邸事件列表
function MansionModel:OnRecvMansionEventList( pb_list )
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_MANSION_EVENT_LIST, pb_list);
end

--府邸背包
function MansionModel:GetGoodsNumberGoodsId( goodid,goodsType )
	return mGameModelManager.BagModel:GetGoodsNumberGoodsId( goodid,goodsType );
end

function MansionModel:CheckGoodsIsEnough( goods_cost )
	return mGameModelManager.BagModel:CheckGoodsIsEnough( goods_cost );
end

function MansionModel:GetBagGoodsList( op_type )
	local bagModel = mGameModelManager.BagModel;
    return bagModel:GetGoodsListWithType( op_type );
end

function MansionModel:RecvGoodsListInit( pbItemList )
	mGameModelManager.BagModel:RecvMansionGoodsList(pbItemList);
end

--1 变化 2 删除 3 新增
function MansionModel:RecvGoodsListRefresh( pbItemList )
	local goodsListWithType = self:GetBagGoodsList( pbItemList.type );

	for k, v in mipairs(pbItemList.list) do
	   local uid = v.id;
	   goodsListWithType:AddOrUpdate( uid, mBagGoodsVO.LuaNew(uid,v.item_id, nil, v.count) );

	   local goods_data = goodsListWithType:GetValue(uid);
       local changeType = 0;

	   if goods_data ~= nil then
	   	  goodsType = goods_data.mSysVO.type;
          if v.count ~= 0 then
            goods_data.mNumber = v.count;
            goods_data.mColor = goods_data.mSysVO.quality;
            goods_data.mPbGoodVO = v;
            goodsListWithType:AddOrUpdate(uid,goods_data);
            changeType = 1;

          else
          	local goodid = goods_data.mID;
          	goodsListWithType:RemoveKey(uid);
            changeType = 2;
          end
	   else
          goods_data = mBagGoodsVO.LuaNew(uid,v.item_id,nil,v.count);
          goodsType = goods_data.mSysVO.type;

          goodsListWithType:AddOrUpdate(uid,goods_data);
	      changeType = 3;
	   end

	   local params = {mData = goods_data, mType = changeType};
	   self:Dispatch(mEventEnum.ON_BAG_GOODS_REFRESH,params);
	end 
end

--仆从
function MansionModel:OnRecvServantAlterName( pbMansionServantChangeName )
	local id, name = pbMansionServantChangeName.id, pbMansionServantChangeName.name;
	local data = self.mData.mServantList:GetValue(id);
	data:OnRecvServantAlterName( name );
	self:Dispatch(mEventEnum.ON_RECV_SERVANT_ALTER_NAME,data);
end

function MansionModel:OnRecvServantAwardMoney( id )
	local data = self.mData.mServantList:GetValue(id);
	data:OnRecvServantAwardMoney();
	self:Dispatch(mEventEnum.ON_RECV_SERVANT_AWARD_MONEY,data);
end

function MansionModel:OnRecvServantPayOffHire( id )
	local data = self.mData.mServantList:GetValue(id);
	data:OnRecvServantPayOffHire();
	self:Dispatch(mEventEnum.ON_RECV_SERVANT_PAYOFF_MONEY,data);
end

function MansionModel:OnRecvServantHire( id )
	local data = self.mData.mServantList:GetValue( id );
	data:OnRecvServantHire();
	self:Dispatch(mEventEnum.ON_RECV_SERVANT_HIRE_FIRST, data);
end

function MansionModel:OnRecvServantUpdate(pbMansionServant)
	local data = self.mData.mServantList:GetValue( pbMansionServant.id );
	data:OnRecvServantUpdate(pbMansionServant);
end

function MansionModel:OnRecvServantSkipAlterName( id )
	local data = self.mData.mServantList:GetValue(id);
	data:OnRecvAlterSkip(  );
	self:Dispatch(mEventEnum.ON_RECV_SERVANT_ALTER_NAME,data);
end
--end

--种植相关
function MansionModel:OnRecvBuyLand( land_id )
	local data = self.mData.mPlantInfoList[ land_id ];
	data:OnRecvBuyLand(  );
	self:Dispatch(mEventEnum.ON_RECV_MANSION_BUY_LAND,data);
end

function MansionModel:OnRecvPlantOperate( pbMansionPlantingResult, self_op )
	local data = self.mData:OnRecvPlantOperate( pbMansionPlantingResult );
	data.mSelfOperate = self_op;
	self:Dispatch(mEventEnum.ON_RECV_MANSION_PLANT_OP, data);
end
--end

--清洁
function MansionModel:RecvMansionClean( clean )
	local data = self.mData;
	data:OnRecvMansionClean( clean );
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_MANSION_CLEAN_UPDATE, data);
end
--end

--NPC事件
function MansionModel:OnRecvUpdateNPCEvent( id )
	local data = self.mData;
	data:OnRecvUpdateNPCEvent( id );
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_NPC_EVENT_UPDATE, data);
end

function MansionModel:OnRecvNPCEventReward(  )
	local data = self.mData;
	data:OnRecvNPCEventReward(  );
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_NPC_EVENT_REWARD, data);
end

function MansionModel:OnRecvNPCEventDelete( )
	local data = self.mData;
	data:OnRecvNPCEventDelete(  );
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_NPC_EVENT_DELETE, data);
end

--external
--府邸等级
function MansionModel:GetMansionLevel(  )
	return self.mData:GetMansionLevel( );
end
--end

return MansionModel;