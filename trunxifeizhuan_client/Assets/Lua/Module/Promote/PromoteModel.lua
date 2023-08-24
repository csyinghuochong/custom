local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mEventDispatcher = require "Events/EventDispatcher"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local PromoteModel = mLuaClass("PromoteModel",mBaseModel);
local mTable = require 'table'
local mMath = require "math"

function PromoteModel:OnLuaNew()
	
end

local mExamTypeVO = {
	"Module/Promote/PromoteExamLetterVO",
	"Module/Promote/PromoteExamArtVO",
	"Module/Promote/PromoteExamFashionVO",
	"Module/Promote/PromoteExamPVPVO",
};
function PromoteModel:InitExamListVO(  )
	local examList = {};
	local exam_content = self:GetCurPromoteVO( ).exam__content;
	if exam_content then
		local exam_number = mTable.getn(exam_content);
		for k, v in pairs(exam_content) do
			examList[k] = require(mExamTypeVO[v.type]).LuaNew(v, k, exam_number);
		end
	end
	self.mExamVOList = examList;
end

function PromoteModel:GetCurPromoteVO(  )
	local role_office = mGameModelManager.RoleModel:GetOffice();
	return mConfigSyspromote[role_office];
end

function PromoteModel:OnUpdateExamInfo( pbSignInfo)
	--[[print('0未报考，1已报考 2评分完--------', pbSignInfo.status)
	print('第几阶段考试--------------------', pbSignInfo.phase)
	print('0未开始，1考试中，2考完结果-----', pbSignInfo.phase_status)
	print('开始时间戳----------------------', pbSignInfo.left_time)
	print('当前第几题----------------------', pbSignInfo.current_num)
	print('总题数--------------------------', pbSignInfo.total_num)
	print('题目id--------------------------', pbSignInfo.qustion_id)
	print('(答对题数/分数/死亡数)----------', pbSignInfo.result)--]]
	if self.mExamVOList == nil then
		self:InitExamListVO(  );
	end
	self.mPbSignInfo = pbSignInfo;
	self:UpdateExamInfo(pbSignInfo);
	if pbSignInfo.phase_status == 2 then
		mEventDispatcher:Dispatch(mEventEnum.ON_BEGIN_NEXT_EXAM, self:GetCurrentExamVO());
	end
end

function PromoteModel:OnRecvJoinExam(  )
	self:InitExamListVO(  );
	mUIManager:HandleUI(mViewEnum.PromoteExamView,1,self:GetCurrentExamVO());
end

function PromoteModel:OnRecvExamBegin(  )
	local vo = self:GetCurrentExamVO();
	local exam_type = vo.mSysVO.type;
	if exam_type == 1 or exam_type == 2 then
		mEventDispatcher:Dispatch(mEventEnum.ON_BEGIN_NEXT_EXAM, vo);
	end
end

function PromoteModel:OnRecvExamRestart()
	mEventDispatcher:Dispatch(mEventEnum.ON_BEGIN_NEXT_EXAM, self:GetCurrentExamVO());
end

function PromoteModel:OnRecvNextExam()
	mEventDispatcher:Dispatch(mEventEnum.ON_BEGIN_NEXT_EXAM, self:GetCurrentExamVO());
end

function PromoteModel:OnRecvExamAnswer( )
	local vo = self:GetCurrentExamVO();
	if self.mPbSignInfo.phase_status ~= 2 then
		mEventDispatcher:Dispatch(mEventEnum.ON_UPDATE_EXAM_VIEW,  vo);
	end
end

function PromoteModel:OnFashionReturn(  )

end

function PromoteModel:OnPVPReturn(  )
	
end

function PromoteModel:OnRecvNpcResult( pbNpcResultList )
	self.mPbNpcResultList = pbNpcResultList;
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_NPC_RESULT, pbNpcResultList);
end

function PromoteModel:OnRecvArenaInfo(pbPromoteArena)
	self.mPromoteArenaInfo = pbPromoteArena;
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_PROMOTE_ARENA, pbPromoteArena);
end

function PromoteModel:OnRecvBattleResult(player_id, result)
	if result == 1 then
		local vsList = self.mPromoteArenaInfo.vs_list;
		for k, v in ipairs(vsList) do
			if v.player_id == player_id then
				v.defeated = 1;
			end
		end
	end

	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_PROMOTE_ARENA, self.mPromoteArenaInfo);
end

function PromoteModel:OnRecvArenaRefresh(pbPromoteArena)
	self.mPromoteArenaInfo = pbPromoteArena;

	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_PROMOTE_ARENA, pbPromoteArena);
end

function PromoteModel:OnRecvBuyArenaTime()
	self.mPromoteArenaInfo.total_times = self.mPromoteArenaInfo.total_times + 5;
end

function PromoteModel:GetCurrentExamVO(  )
	return self.mExamVOList[self.mPbSignInfo.phase];
end

function PromoteModel:GetPVPRobot( )
	local office = mGameModelManager.RoleModel:GetOffice();
	local robot_list = mConfigSyspromote[office].robot_list;
	local robot_number = #robot_list;
	return robot_list[mMath.random(1, robot_number)];
end

function PromoteModel:IsExamFinish(  )
	local pbSignInfo = self.mPbSignInfo;
	return pbSignInfo ~= nil and pbSignInfo.status == 2;
end

function PromoteModel:UpdateExamInfo( pbSignInfo )
	local pahse = pbSignInfo.phase;
	if pahse ~= 0 then
		self.mExamVOList[pahse]:UpdateExamInfo(pbSignInfo);
	end
end

return PromoteModel;