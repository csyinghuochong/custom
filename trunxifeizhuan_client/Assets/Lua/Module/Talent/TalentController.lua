local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mConfigSysecode = require "ConfigFiles/ConfigSysecode"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysecodeConst = require "ConfigFiles/ConfigSysecodeConst"
local mErrorCodeController = require "Module/CommonErrorCode/ErrorCodeController"
local TalentController = mLuaClass("TalentController",mBaseController);

--协议处理--
function TalentController:AddNetListeners()
	local mS2C = self.mS2C;
	self.mEnumTalentType = { TalentEquip = 1, TalentXinDe = 2, TalentMiJue = 3 };

	mS2C:PLAYER_TALENT_LIST(function( pbTalentList )
		mGameModelManager.FollowerModel:OnRecvTalentInit( pbTalentList );
	end);

	mS2C:PLAYER_TALENT_REFRSH(function( pbTalentList )
		mGameModelManager.FollowerModel:OnRecvTalentUpdate( pbTalentList );
	end);

	mS2C:PLAYER_TALENT_SELL(function( pbResult )
		print ( '出售成功' );
	end);

	mS2C:PLAYER_TALENT_WEAR(function( pbTalent )
		mGameModelManager.FollowerModel:OnRecvTalentWear( self.mFollowerId, pbTalent );
	end);

	mS2C:PLAYER_TALENT_REMOVE(function( pbResult )
		mGameModelManager.FollowerModel:OnRecvTalentRemove( self.mFollowerId, self.mTalentPos  );
	end);

	mS2C:PLAYER_TALENT_STRENGTH(function( pbTalent )
		mGameModelManager.FollowerModel:OnRecvTalentStrength( self.mFollowerId, pbTalent );
	end);

	mS2C:PLAYER_TALENT_UP(function( pbTalentAttributeAdd )
		mGameModelManager.FollowerModel:OnRecvTalentStudy( self.mFollowerId, self.mTalentId, self.mSequence, pbTalentAttributeAdd );
	end);

	mS2C:PLAYER_TALENT_WASH(function( pbTalentAttributeAdd )
		mGameModelManager.FollowerModel:OnRecvTalentWash( self.mFollowerId, self.mTalentId, pbTalentAttributeAdd );
	end);

	mS2C:PLAYER_TALENT_WASH_SAVE(function( pbTalent )
		local FollowerModel = mGameModelManager.FollowerModel;
		if self.mWashOpType == 1 then
			FollowerModel:OnRecvTalentWashSave(self.mFollowerId, pbTalent );
		else
			FollowerModel:OnRecvTalentWashGiveUp(self.mFollowerId, pbTalent );
		end
	end);
end

--事件处理--
function TalentController:AddEventListeners()
	mErrorCodeController:RegisterErrorCodeAction(mConfigSysecodeConst.ERROR_STRENGTH_FAIL,function()
		self:Dispatch(self.mEventEnum.ON_UP_TALENT_FAILED );
	end);
end

--背包列表
function TalentController:SendGetTalentList(  )
	self.mC2S:PLAYER_TALENT_LIST( );
end

--才艺出售
function TalentController:SendSellTalent( pbTalentModels )
	self.mC2S:PLAYER_TALENT_SELL( pbTalentModels );
end

--才艺穿戴
function TalentController:SendTalentWear( partner_id, pos, id )
	self.mFollowerId = partner_id; 
	self.mC2S:PLAYER_TALENT_WEAR(tonumber(partner_id), pos, id );
end

--才艺卸下
function TalentController:SendTalentRemove( partner_id, pos )
	self.mFollowerId = partner_id;
	self.mTalentPos  = pos;
	self.mC2S:PLAYER_TALENT_REMOVE(tonumber(partner_id), pos );
end

--才艺强化
function TalentController:SendTalentStrength(partner_id, id, use_good_id)
	self.mFollowerId = partner_id;
	self.mTalentId = id;
	self.mC2S:PLAYER_TALENT_STRENGTH(tonumber(partner_id), id, use_good_id);
end

--才艺研习
function TalentController:SendTalentStudy(partner_id, id, seq, use_good_id)
	self.mFollowerId = partner_id;
	self.mTalentId = id;
	self.mSequence = seq;
	self.mC2S:PLAYER_TALENT_UP(tonumber(partner_id), id, seq, use_good_id);
end

--才艺精研
function TalentController:SendTalentWash(partner_id, id, use_good_id)
	self.mFollowerId = partner_id;
	self.mTalentId = id;
	self.mC2S:PLAYER_TALENT_WASH(tonumber(partner_id), id, use_good_id);
end

--精研保存/放弃
function TalentController:SendTalentWashSave(partner_id, id, op_type)
	self.mTalentId = id;
	self.mFollowerId = partner_id;
	self.mWashOpType = op_type;
	self.mC2S:PLAYER_TALENT_WASH_SAVE(tonumber(partner_id), id, op_type);
end

local mTalentControllerInstance = TalentController.LuaNew();
return mTalentControllerInstance;