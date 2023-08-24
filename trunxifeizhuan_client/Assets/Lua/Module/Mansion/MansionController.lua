local mViewEnum = require "Enum/ViewEnum"
local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local MansionController = mLuaClass("MansionController",mBaseController);

--协议处理--
function MansionController:AddNetListeners()
	local s2c = self.mS2C;
	local mEventEnum = self.mEventEnum;
	
	-- 种植操作类型 1种植 2铲除 3施肥 4浇水 5捣乱 6 偷取 7 收获
	self.mPlantTyepEnum = { PlantSeed = 1, Eradicate = 2, Fertilize = 3, Watering = 4 , Trouble = 5, Steal = 6, Harvest = 7 };
	
	s2c:MANSION_INFO(function(pbMansion)
		mGameModelManager.MansionModel:OnRecvEnterSelfMansion( pbMansion );
	end);

	s2c:MANSION_UPDATE_INFO(function(pbMansion)
		mGameModelManager.MansionModel:OnRecvMansionInfoUpdate( pbMansion );
	end);

	s2c:MANSION_CHNAGE_NAME(function(pbString)
		mGameModelManager.MansionModel:OnRecvAlterMansionName( pbString.id );
	end);

	s2c:MANSION_VISIT_LIST(function(pbMansionVisitList)
		mGameModelManager.MansionModel:OnRecvPlayerList( pbMansionVisitList );
	end);

	--府邸事件
	s2c:MANSION_EVENTS(function(pbMansionEvents)
		mGameModelManager.MansionModel:OnRecvMansionEventList( pbMansionEvents );
	end);

	--串门
	s2c:MANSION_VISIT_START(function(pbMansion)
		mGameModelManager.MansionModel:OnRecvEnterVisitMansion( pbMansion );
	end);

	--仆从
	s2c:MANSION_SERVANT_CHANGE_NAME(function(pbMansionServantChangeName)
		mGameModelManager.MansionModel:OnRecvServantAlterName( pbMansionServantChangeName );
	end);

	s2c:MANSION_SERVANT_REWARD(function(pbResult)
		mGameModelManager.MansionModel:OnRecvServantAwardMoney( self.mServantId );
	end);

	s2c:MANSION_SERVANT_REWARD_HOUSE_COIN(function(pbResult)
		mGameModelManager.MansionModel:OnRecvServantPayOffHire( self.mServantId );
	end);
	
	s2c:MANSION_SERVANT_CALL(function(pbResult)
		mGameModelManager.MansionModel:OnRecvServantHire( self.mServantId );
	end);

	--仆从信息更新，主动推送
	s2c:MANSION_SERVANT_UPDATE(function(pbMansionServant)
		mGameModelManager.MansionModel:OnRecvServantUpdate( pbMansionServant );
	end);

	--仓库
	--27000--27003
	s2c:MANSION_ITEM_LIST(function(pbItemList)
		mGameModelManager.MansionModel:RecvGoodsListInit( pbItemList );
	end);

	s2c:MANSION_ITEM_UPDATE(function(pbItemList)
		mGameModelManager.MansionModel:RecvGoodsListRefresh( pbItemList );
	end);

	s2c:MANSION_ITEM_SELL(function(pbResult)
		self:Dispatch(mEventEnum.ON_SELL_GOODS_RESULT);
	end);

	--打扫
	s2c:MANSION_SERVANT_CLEANUP(function(pbResult)
		print( '清洁度: ',  pbResult.result )
		mGameModelManager.MansionModel:RecvMansionClean( pbResult.result );
	end);

	--种植
	s2c:MANSION_OPEN_LAND(function(pbResult)
		mGameModelManager.MansionModel:OnRecvBuyLand( self.mLandId );
	end);

	s2c:MANSION_SEED_OPERATION(function(pbMansionPlantingResult)
		local self_op = self.mSelfOperate;
		mGameModelManager.MansionModel:OnRecvPlantOperate( pbMansionPlantingResult, self_op );
		self.mSelfOperate = false;
	end);
	
	s2c:MANSION_SEED_ORDER_REQUEST(function(pbMansionPlantPlanlist)
		self:Dispatch(mEventEnum.ON_RECV_MANSION_PLANT_QUEUE, pbMansionPlantPlanlist);
	end);
	s2c:MANSION_SEED_ORDER_UPDATE(function(pbMansionPlantPlanlist)
		
	end);

	--NPC事件
	s2c:MANSION_NPC_EVENT_UPDATE(function(pbResult)
		mGameModelManager.MansionModel:OnRecvUpdateNPCEvent( pbResult.result );
	end);

	s2c:MANSION_NPC_EVENT_REWARD(function(pbResult)
		mGameModelManager.MansionModel:OnRecvNPCEventReward(  );
	end);

	s2c:MANSION_NPC_EVENT_DEL(function(pbResult)
		mGameModelManager.MansionModel:OnRecvNPCEventDelete(  );
	end);

	--材料合成
	s2c:MANSION_ITEM_COMPOSITION(function(pbResult)
		self:Dispatch(mEventEnum.ON_RECV_COMPOSE_MATERIAL);
	end);

	--宴会
	s2c:MANSION_FEAST_OPEN_WINDOWS(function(pbMansionFeastInfo)
		self:Dispatch(mEventEnum.ON_RECV_MANSION_FEAST_INFO, pbMansionFeastInfo);
	end);

	s2c:MANSION_FEAST_OPEN(function(result)
		self:SendGetFeastInfo( );
	end);

	s2c:MANSION_FEAST_DETAIL(function(pbMansionFeastDetail)
		self:Dispatch(mEventEnum.ON_RECV_MANSION_FEAST_DETAIL, pbMansionFeastDetail);
	end);

	s2c:MANSION_FESAT_LIST(function(pbMansionFeastList)
		self:Dispatch(mEventEnum.ON_RECV_MANSION_FEAST_LIST, pbMansionFeastList);
	end);

	s2c:MANSION_FEAST_ADD(function(pbResult)
		self:Dispatch(mEventEnum.ON_RECV_MANSION_FEAST_JOIN, self.mMainId);
	end);

	s2c:MANSION_FEAST_INVITE(function(pbResult)
		print ( '发送邀请成功:', pbResult.result )
	end);
end

--事件处理--
function MansionController:AddEventListeners()
	
end

--主界面相关[繁荣度，排行榜]
--1 打开府邸界面
function MansionController:SendEnterSelfMansion(  )
	self.mIsInMansion = true;
	self.mC2S:MANSION_INFO();

	--请求背包
	local op_type = mGameModelManager.BagModel.mTypeEnum.Seed;
	self:SendGetBagGoodsList( op_type );
	self:SendGetBagGoodsList( op_type + 1 );
end

--关闭界面
function MansionController:SendHideMansionView(  )
	self.mIsInMansion = false;
	self.mC2S:MANSION_CLOSE();
end

--2 修改府邸名字
function MansionController:SendAlterMansionName( name )
	self.mC2S:MANSION_CHNAGE_NAME( name );
end

--3 获取玩家列表
function MansionController:RequestPlayerList( op_type )
	self.mC2S:MANSION_VISIT_LIST(op_type, true);
end
--串门
function MansionController:SendVisitPlayer( id )
	self.mC2S:MANSION_VISIT_START( id );
end
--end

--仆从
--2 仆从改名
function MansionController:SendServantAlterName( id, name )
	self.mC2S:MANSION_SERVANT_CHANGE_NAME( id, name );
end

--3 打赏仆从
function MansionController:SendServantAwardMoney( id )
	self.mServantId = id;
	self.mC2S:MANSION_SERVANT_REWARD( id );
end

--4 发送列银
function MansionController:SendServantPayOffHire( id )
	self.mServantId = id;
	self.mC2S:MANSION_SERVANT_REWARD_HOUSE_COIN( id );
end

-- 雇佣仆从
function MansionController:SendServantHire( id )
	self.mServantId = id;
	self.mC2S:MANSION_SERVANT_CALL( id );
end

function MansionController:SendServantSkipAlterName( id )
	mGameModelManager.MansionModel:OnRecvServantSkipAlterName( id );
end
--end

--清洁
function MansionController:SendCleanMansion(  )
	self.mC2S:MANSION_SERVANT_CLEANUP( );
end

--拜访

--种植
--购买土地
function MansionController:SendBuyLand( land_id )
	self.mLandId = land_id;
	self.mC2S:MANSION_OPEN_LAND( land_id );
end

-- 种子操作
function MansionController:SendPlantOperate( type, land_id, item_id, target_id )
	self.mSelfOperate = true;
	self.mC2S:MANSION_SEED_OPERATION(type, land_id, item_id, target_id);
end

-- 请求种植队列
function MansionController:RequestPlantQueue(  )
	self.mC2S:MANSION_SEED_ORDER_REQUEST();
end
-- 设置种植队列
function MansionController:SendSetPlantQueue( plant_list )
	self.mC2S:MANSION_SEED_ORDER_UPDATE(plant_list);
end

--仓库
--27000--请求府邸背包列表
function MansionController:SendGetBagGoodsList( op_type )
	self.mC2S:MANSION_ITEM_LIST( op_type );
end

--27002--出售物品
function MansionController:SendSellGoods( op_type, goodsID, num )
	self.mC2S:MANSION_ITEM_SELL( op_type, goodsID,num );
end

--勤务房[包括装扮物品，菜肴，刺绣和丹药]
function MansionController:SendComposeMaterial( id )
	self.mC2S:MANSION_ITEM_COMPOSITION( id );
end

--装饰先行版

--装饰完整版(10/11同步开发)

--商城

--伴侣代管

--宴会
function MansionController:SendGetFeastInfo(  )
	self.mC2S:MANSION_FEAST_OPEN_WINDOWS( true );
end

function MansionController:SendOpenFeast( id )
	self.mC2S:MANSION_FEAST_OPEN( id );
end

function MansionController:SendGetFeastDetail( id )
	self.mC2S:MANSION_FEAST_DETAIL( id );
end

function MansionController:SendGetFeastList(  )
	self.mC2S:MANSION_FESAT_LIST( );
end

function MansionController:SendJoinFeast( main_id, gift_id )
	self.mMainId = main_id;
	self.mGiftId = gift_id;
	self.mC2S:MANSION_FEAST_ADD( main_id, gift_id );
end

function MansionController:SendInviteGuest(  )
	self.mC2S:MANSION_FEAST_INVITE( );
end

function MansionController:OnClickJoinFeast( player_id, feast_id )
	if self.mIsInMansion ~= true then
		mUIManager:HandleUI(mViewEnum.MansionMainView, 1);
	end
	mUIManager:HandleUI(mViewEnum.MansionFeastListView, 1, player_id);
end

--NPC事件
function MansionController:SendGetNpcEventReward( id )
	self.mC2S:MANSION_NPC_EVENT_REWARD( id );
end

function MansionController:SendDeleteNpcEvent( id )
	self.mC2S:MANSION_NPC_EVENT_DEL( id );
end

--随从居所

--皇子培养

--府邸事件
function MansionController:RequstMansionEvents( op_type )
	self.mC2S:MANSION_EVENTS( op_type );
end

local mMansionControllerInstance = MansionController.LuaNew();
return mMansionControllerInstance;