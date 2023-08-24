local mViewEnum = require "Enum/ViewEnum"
local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local mFollowerModel= require "Module/Follower/FollowerModel"
local mCommonRewardVO = require "Module/CommonUI/CommonRewardVO"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local FollowerController = mLuaClass("FollowerController",mBaseController);

--协议处理--
function FollowerController:AddNetListeners()
	local mC2S = self.mS2C;
	local mEventEnum = self.mEventEnum;
	
	mC2S:PARTNER_LIST(function(pbPartnerList)
		mGameModelManager.FollowerModel:OnRecvFollowerList(pbPartnerList);
	end);

	mC2S:PARTNER_LV_UP(function(pbResult)
		mGameModelManager.FollowerModel:OnRecvFollowerUpLevel(self.mFollowerId, self.mCostYueli);
	end);

	mC2S:PARTNER_MODEL_CHANGE(function(pbResult)
		mGameModelManager.FollowerModel:OnRecvFollowerModelChange(self.mFollowerId, self.mModelId);
	end);

	mC2S:PARTNER_SKILL_UP(function(pbPartnerSkillUp)
		if self.mCostType ==  2 then
			mGameModelManager.FollowerModel:OnRecvDeleteFollower(self.mCostID);
		end
		mGameModelManager.FollowerModel:OnRecvFollowerSkillUpLevel(self.mFollowerId, pbPartnerSkillUp.skill_id);
	end);

	mC2S:PARTNER_POSITION_UP(function(pbResult)
		mGameModelManager.FollowerModel:OnRecvFollowerOfficeUp(self.mFollowerId);
	end);

	mC2S:PARTNER_IN_CAMP(function(pbId64R)
		self:Dispatch(mEventEnum.ON_RECV_IN_CAMP_FOLLOWER, pbId64R.ids);
	end);

	mC2S:PARTNER_TRAIN(function(pbId32R)
		mGameModelManager.FollowerModel:OnRecvLeadTrain(pbId32R);
	end);
	
	mC2S:PARTNER_BREAK_OUT(function(pbResult)
		local FollowerModel = mGameModelManager.FollowerModel;

		local costIds = self.mBreakCostIds;
		for k, v in pairs(costIds) do
			FollowerModel:OnRecvDeleteFollower(tostring(v));
		end
		FollowerModel:OnRecvRoleBreak(self.mFollowerId);
	end);

	mC2S:PARTNER_MAIN_SKILL_UP(function(pbPartnerSkillUp)
		mGameModelManager.FollowerModel:OnRecvLeadSkillUpLevel(self.mForceId, pbPartnerSkillUp.skill_id);
	end);

	mC2S:PARTNER_MAIN_SKILL_USE(function(pbResult)
		mGameModelManager.FollowerModel:OnRecvLeadSkillChange(self.mForceId, self.mSkillLine);
	end);

	mC2S:PARTNER_ADD(function(pbPartnerAdd)
		mGameModelManager.FollowerModel:OnRecvAddFollower(pbPartnerAdd);
	end);
	
	mC2S:PARTNER_CHANGE_NAME(function(pbResult)
		mGameModelManager.FollowerModel:OnRecvAlterFollowerName(self.mFollowerId, self.mFollowerName);
	end);

	mC2S:PARTNER_DELETE(function(pbResult)
		mGameModelManager.FollowerModel:OnRecvDeleteFollower(self.mFollowerId);
	end);

	mC2S:PARTNER_LOCK(function(pbResult)
		mGameModelManager.FollowerModel:OnRecvFollowerLock(self.mFollowerId, self.mLockFlag);
	end);

	mC2S:PARTNER_COMMENT_LIST(function(pbPartnerCommentList)
		self:Dispatch(mEventEnum.ON_RECV_COMMENT_LIST, pbPartnerCommentList);	
	end);
	
	mC2S:PARTNER_COMMENT_VOTE(function(pbResult)
		self:Dispatch(mEventEnum.ON_RECV_COMMENT_PRAISE, self.mCommentId);	
	end);

	mC2S:PARTNER_COMMENT_ADD(function(pbResult)
		self.mC2S:PARTNER_COMMENT_LIST( self.mFollowerId, true );
	end);

	mC2S:PARTNER_COMMENT_LOOK(function(pbPartner)
		self:Dispatch(mEventEnum.ON_RECV_LOOK_FOLLOWER, pbPartner);	
	end);
end

function FollowerController:GetDungeonWinReward(  )
	local reward = mCommonRewardVO.LuaNew();
	reward:InitConfigReward(mConfigSysdungeon[self.mDungeonId].drop_fragments);
	return reward;
end

--事件处理--
function FollowerController:AddEventListeners()
	local mEventEnum = self.mEventEnum;
	self:AddEventListener(mEventEnum.ON_PLAYER_UPDATE_OFFICE,function(value)
		mGameModelManager.FollowerModel:GetLeadVO():OnUpdateOffice(value);
	end);

	self:AddEventListener(mEventEnum.ON_PLAYER_UPDATE_LEVEL,function(value)
		mGameModelManager.FollowerModel:GetLeadVO():OnUpdateLevel(value);
	end);

	self:AddEventListener(mEventEnum.ON_PLAYER_UPDATE_EXP,function(value)
		mGameModelManager.FollowerModel:GetLeadVO():OnUpdateExp(value);
	end);
	
	self:AddEventListener(mEventEnum.ON_UPDATE_EQUIPED_FASHIONS, function(fashions) 
		mGameModelManager.FollowerModel:GetLeadVO():CalculateAttri( );
	end);
end

function FollowerController:OnClickChallengeDungeon(dungeon_id, follower_id)
	self.mDungeonId = dungeon_id;
	self.mFollowerId = follower_id;
	mCombatModelManager:CreateFollowerDungeonCombatModel(dungeon_id);
end

function FollowerController:OnOpenCombatView()
	mUIManager:HandleUI(mViewEnum.CombatView,1);
end

function FollowerController:OnCombatOpenDungeon()
	mUIManager:HandleUI(mViewEnum.FollowerMainView,1);
end

--随从列表
function FollowerController:SendGetFollowerList(  )
	self.mC2S:PARTNER_LIST();
end

--随从升级
function FollowerController:SendFollowerUpLevel(follower_id, cost_exp)
	self.mFollowerId = follower_id;
	self.mCostYueli = cost_exp;
	self.mC2S:PARTNER_LV_UP(tonumber(follower_id));
end

--随从切换形象
function FollowerController:SendFollowerModelChange(follower_id, model_id)
	self.mFollowerId = follower_id;
	self.mModelId = model_id;
	self.mC2S:PARTNER_MODEL_CHANGE(tonumber(follower_id), model_id);
end

--随从技能升级
function FollowerController:SendFollowerSkillUpLevel( follower_id, cost_type, cost_id)
	self.mFollowerId = follower_id;
	self.mCostType = cost_type;
	self.mCostID = cost_id;

	self.mC2S:PARTNER_SKILL_UP(tonumber(follower_id), cost_type, tonumber(cost_id));
end

--随从晋封
function FollowerController:SendFollowerOfficeUp( follower_id )
	self.mC2S:PARTNER_POSITION_UP(tonumber(follower_id));
	self.mFollowerId = follower_id;
end

--随从上阵列表
function FollowerController:SendGetInCampFollower(  )
	self.mC2S:PARTNER_IN_CAMP( );
end

--随从突破
function FollowerController:SendFollowerBreak( follower_id, cost_ids )
	self.mFollowerId = follower_id;
	self.mBreakCostIds = cost_ids;

	self.mC2S:PARTNER_BREAK_OUT(tonumber(follower_id), cost_ids);
end

--随从通关传记
function FollowerController:SendFollowerPassBiography(  )
	local follower_id = self.mFollowerId;
	local chapter_id = self.mDungeonId;
	mGameModelManager.FollowerModel:OnFollowerPassBiography( follower_id, chapter_id );
	self.mC2S:PARTNER_PASS_MEMOIR(tonumber(follower_id), chapter_id);   
end

--主角技能激活/升级
function FollowerController:SendLeadSkillOpen( force_id, skill_id )
	self.mForceId = force_id;
	self.mSkillId = skill_id;
	self.mC2S:PARTNER_MAIN_SKILL_UP(force_id);
end

--主角培养放弃/保存 0放弃1保存	
function FollowerController:SendTrainOperation( train_type, op_type )
	mGameModelManager.FollowerModel:OnRecvTrainOperate(op_type);
	if train_type == 1 then
		self.mC2S:PARTNER_TRAIN_OP(op_type);
	end
end

--主角技能分支
function FollowerController:SendLeadSkillChange( force_id, line )
	self.mForceId = force_id;
	self.mSkillLine = line;
	self.mC2S:PARTNER_MAIN_SKILL_USE(force_id, line);
end

--修改随从昵称
function FollowerController:SendAlterFollowerName( follower_id, name )
	self.mFollowerId = follower_id;
	self.mFollowerName = name;
	self.mC2S:PARTNER_CHANGE_NAME(tonumber(follower_id), name);
end

--删除随从
function FollowerController:SendDeleteFollower( follower_id )
	self.mFollowerId = follower_id;
	self.mC2S:PARTNER_DELETE(tonumber(follower_id));
end

--锁定/解锁随从
function FollowerController:SendLockFollower( follower_id, lock )
	self.mFollowerId = follower_id;
	self.mLockFlag = lock;
	self.mC2S:PARTNER_LOCK(tonumber(follower_id), lock);
end

--主角培养
function FollowerController:SendRoleTrain(train_type)
	self.mTrainType = train_type;
	self.mC2S:PARTNER_TRAIN(train_type);
end

--请求随从评价
function FollowerController:ReqCommentList( id )
	self.mC2S:PARTNER_COMMENT_LIST( id, true );
end

--随从评价点赞
function FollowerController:SendCommentPraise(  id )
	self.mCommentId = id;
	self.mC2S:PARTNER_COMMENT_VOTE( id );
end

--新增随从评价
function FollowerController:SendAddComment( id, content)
	self.mFollowerId = id;
	self.mC2S:PARTNER_COMMENT_ADD( id, content );
end

--查看随从
function FollowerController:SendLookFollower( player_id, follower_id )
	self.mC2S:PARTNER_COMMENT_LOOK( player_id, follower_id );
end

local mFollowerControllerInstance = FollowerController.LuaNew();
return mFollowerControllerInstance;