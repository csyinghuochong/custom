local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mBaseModel = require "Core/BaseModel"
local mSortTable = require "Common/SortTable"
local mLeadVO = require "Module/Lead/LeadVO"
local mFollowerVO = require "Module/Follower/FollowerVO"
local mEventDispatcher = require "Events/EventDispatcher"
local TalentItemVO = require "Module/Talent/TalentItemVO"
local mGameModelManager = require "Manager/GameModelManager"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local FollowerSortFunction = require "Module/Follower/FollowerSortFunction"
local FollowerModel = mLuaClass("FollowerModel",mBaseModel);
local mTable = require "table"
local mIpairs = ipairs;

function FollowerModel:OnLuaNew()
	--排序函数
	local sortList = {
		function(a, b) return FollowerSortFunction.Sort1(a,b) end;
		function(a, b) return FollowerSortFunction.Sort2(a,b) end;
		function(a, b) return FollowerSortFunction.Sort3(a,b) end;
		function(a, b) return FollowerSortFunction.Sort4(a,b) end;
	}

	--没有主角
	self.mFolloweList1 =  mSortTable.LuaNew(sortList[ 4 ], nil, true);

	--有主角
	self.mFolloweList2 =  mSortTable.LuaNew(sortList[ 4 ], nil, true);

	self.mSortList = sortList;
	self.mTalentListByType = { };
	self.mTalentListByUID = { };
	self.mFollowerSortType = 1;
end

function FollowerModel:ChangeSort( sort_type )
	if sort_type == 4 then
		self:SetNearestUse();
	end
	self.mFollowerSortType = sort_type;
	local sortFunc = self.mSortList[sort_type];
	self.mFolloweList1:UpdateSortFunction(sortFunc);
	self.mFolloweList2:UpdateSortFunction(sortFunc);
end

function FollowerModel:GetFollowerSortType(  )
	return self.mFollowerSortType;
end
function FollowerModel:SetNearestUse( )
	local newTeam = mBattleArrayViewVO:GetNewestTeam();
	for k, v in pairs(self.mFolloweList2.mRawTable) do
		v.mNearestUse =  newTeam[k] ~= nil;
	end
end

function FollowerModel:GetDungeonBattleHero(  )
	local battleHeros = self.mDungeonBattleHeros;
	if battleHeros ~= nil then
		return battleHeros;
	end
	battleHeros = {};
	self.mDungeonBattleHeros = battleHeros;
	for k, v in pairs(self.mFolloweList2.mSortTable) do
		if k < 7 then
			battleHeros[k] = v;
		end
	end
	return battleHeros;
end

function FollowerModel:GetFollowerNumber(  )
	local data = self.mFolloweList1.mSortTable;
	return data and mTable.getn(data) or 0;
end

function FollowerModel:OnRecvFollowerList(pbPartnerList)
	local uid = nil;
	local followerVo = nil;
	local followerList1 = self.mFolloweList1;
	local followerList2 = self.mFolloweList2;

	for k, v in ipairs(pbPartnerList.partner_list) do
		uid = v.id;
		if v.main == 1 then
			self.mLeadID = uid;
			followerVo = mLeadVO.LuaNew();
		else
			followerVo = mFollowerVO.LuaNew();
		end
		followerVo:InitFollowerData(v, true);

		if v.main ~= 1 then
			followerList1:AddOrUpdate(uid, followerVo);
		end
		followerList2:AddOrUpdate(uid, followerVo);

		for k, v in ipairs( v.talents ) do
			if #v.temp_attribute > 1 then
				self.mWaitWashTalent = followerVo.mTalentListToID[ v.id ];
			end
		end
	end
	local model = mGameModelManager.ArchiveModel;
	model:CreateList(followerList1.mSortTable);

	if self.mLeadID == nil then
		print('<<<<<<<<<没有接收到主角信息----------------------')
	end
end

function FollowerModel:OnRecvAddFollower(pbPartnerAdd)
	local followerVo =  mFollowerVO.LuaNew();
	followerVo:InitAddFollowerData( pbPartnerAdd )
	self:OnAddOrUpdateFollower(pbPartnerAdd.id, followerVo);

	local model = mGameModelManager.ArchiveModel;
	model:AddFollower(followerVo);
end

function FollowerModel:OnAddOrUpdateFollower( id, vo )
	self.mFolloweList1:AddOrUpdate(id, vo);
	self.mFolloweList2:AddOrUpdate(id, vo);
end

------随从属性
function FollowerModel:GetLeadCombat()
	local leadVO = self:GetLeadVO();
	return leadVO and leadVO:GetCombat() or 0;
end

function FollowerModel:GetLeadVO(  )
	return self:GetFollowerByID(self.mLeadID);
end

function FollowerModel:GetOfficeName(  )
	return self:GetLeadVO( ):GetOfficeName( );
end

function FollowerModel:GetFollowerByID( follower_id )
	return self.mFolloweList2:GetValue(follower_id);
end

function FollowerModel:GetFollowerByActorID( actor_id )
	local actors;
	local followerList = self.mFolloweList2;
	for k, v in pairs(followerList.mSortTable) do
		if v:GetActorID() == actor_id then
			if actors == nil then
				actors = {};
			end

			mTable.insert(actors, v);
		end
	end
	return actors;
end

function FollowerModel:GetFollowerStateByActorID(actor_id)
	local followerList = self.mFolloweList2;
	for k, v in pairs(followerList.mSortTable) do
		if v:GetActorID() == actor_id then
			return true
		end
	end
	return false;
end

function FollowerModel:OnRecvFollowerUpLevel(follower_id, up_exp)
	local followerVo = self.mFolloweList2:GetValue(follower_id);
	followerVo:OnUpdateExp(up_exp);
	
	self:OnAddOrUpdateFollower(follower_id, followerVo);
	mEventDispatcher:Dispatch(mEventEnum.ON_FOLLOWER_UP_EXP, followerVo);
end

function FollowerModel:OnRecvFollowerModelChange(follower_id, model_id)
	local followerVo = self.mFolloweList2:GetValue(follower_id);
	followerVo:OnUpdateModel(model_id);
	self:OnAddOrUpdateFollower(follower_id, followerVo);
	mEventDispatcher:Dispatch(mEventEnum.ON_FOLLOWER_MODEL_CHANE, followerVo);
end

function FollowerModel:OnRecvFollowerSkillUpLevel(follower_id, skill_id)
	local followerVo = self.mFolloweList2:GetValue(follower_id);
	local skill_vo = followerVo:OnUpdateSkillLevel(skill_id);
	self:OnAddOrUpdateFollower(follower_id, followerVo);
	mEventDispatcher:Dispatch(mEventEnum.ON_FOLLOWER_SKILL_UP, skill_vo);
end

function FollowerModel:OnRecvFollowerOfficeUp(follower_id)
	local followerVo = self.mFolloweList2:GetValue(follower_id);
	followerVo:OnUpdateOffice();
	self:OnAddOrUpdateFollower(follower_id, followerVo);
	mEventDispatcher:Dispatch(mEventEnum.ON_FOLLOWER_OFFICE_UP, followerVo);
end

function FollowerModel:OnRecvLeadTrain(pbId32R)
	local followerVo = self:GetLeadVO();
	followerVo:OnRecvTrain(pbId32R.id);
	mEventDispatcher:Dispatch(mEventEnum.ON_LEAD_TRAIN, followerVo);
end

function FollowerModel:OnRecvTrainOperate( op_type )
	local followerVo = self:GetLeadVO();
	followerVo:OnRecvTrainOperate(op_type);
	mEventDispatcher:Dispatch(mEventEnum.ON_LEAD_TRAIN_OP, followerVo);
end

function FollowerModel:OnRecvRoleBreak(follower_id)
	local followerVo = self.mFolloweList2:GetValue(follower_id);
	followerVo:OnUpdateStar();
	self:OnAddOrUpdateFollower(follower_id, followerVo);
	mEventDispatcher:Dispatch(mEventEnum.ON_FOLLOWER_BREAK, followerVo);
end

function FollowerModel:OnRecvLeadSkillUpLevel(force_id, skill_id)
	local leadID = self.mLeadID;
	local followerVo = self.mFolloweList2:GetValue(leadID);
	local skillVo = followerVo:OnLeadUpdateSkill(force_id, skill_id);
	mEventDispatcher:Dispatch(mEventEnum.ON_LEAD_SKILL_UP, { lead_vo = followerVo , skill_vo = skillVo } );
end

function FollowerModel:OnRecvLeadSkillChange(force_id, line_index)
	local leadID = self.mLeadID;
	local followerVo = self.mFolloweList2:GetValue(leadID);
	followerVo:OnLeadUpdatePower(force_id, line_index);
	mEventDispatcher:Dispatch(mEventEnum.ON_LEAD_SKILL_CHANGE, followerVo);
end

function FollowerModel:OnFollowerPassBiography( follower_id, chapter_id )
	local followerVo = self.mFolloweList2:GetValue(follower_id);
	followerVo:OnPassBiography(chapter_id);
	mEventDispatcher:Dispatch(mEventEnum.ON_FOLLOWER_BIOGRAPHY, followerVo);
end

function FollowerModel:OnRecvAlterFollowerName( follower_id, name )
	local followerVo = self.mFolloweList2:GetValue(follower_id);
	followerVo:OnAlterName(name);
	mEventDispatcher:Dispatch(mEventEnum.ON_FOLLOWER_ALTER_NAME, followerVo);
end

function FollowerModel:OnRecvDeleteFollower( follower_id )
	self.mFolloweList1:RemoveKey(follower_id);
	self.mFolloweList2:RemoveKey(follower_id);

	mEventDispatcher:Dispatch(mEventEnum.ON_FOLLOWER_DELETE, follower_id);
end

function FollowerModel:OnRecvFollowerLock( follower_id, lock )
	local followerVo = self.mFolloweList2:GetValue(follower_id);
	followerVo:OnUpateLock(lock)
	self:OnAddOrUpdateFollower(follower_id, followerVo);
	mEventDispatcher:Dispatch(mEventEnum.ON_FOLLOWER_LOCK, followerVo);
end

------才艺属性
function FollowerModel:OnRecvTalentWear( followerId, pbTalent )
	local followerVo = self.mFolloweList2:GetValue(followerId);
	local equipVo = followerVo:OnWearTalent(pbTalent);
	mEventDispatcher:Dispatch(mEventEnum.ON_WEAR_TALENT, equipVo);
end

function FollowerModel:OnRecvTalentRemove( followerId, talentPos  )
	local followerVo = self.mFolloweList2:GetValue(followerId);
	followerVo:OnRecvTalentRemove( talentPos );
	mEventDispatcher:Dispatch(mEventEnum.ON_REMOVE_TALENT, talentPos);
end

function FollowerModel:OnRecvTalentStrength( followerId, pbTalent )
	local talentVo = self:GetTalentItemVO( followerId,  pbTalent.id );
	talentVo:OnStrengthTalent( pbTalent );
	self:AddOrUpdateTalentVO( followerId, talentVo );
	mEventDispatcher:Dispatch(mEventEnum.ON_UP_TALENT_SUCCEED, talentVo);
end

function FollowerModel:OnRecvTalentStudy( followerId, talentId, sequence, pbTalentAttributeAdd )
	local talentVo = self:GetTalentItemVO( followerId, talentId );
	talentVo:OnRecvTalentStudy( sequence,  pbTalentAttributeAdd);
	self:AddOrUpdateTalentVO( followerId, talentVo );
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_STUDY_TALENT, talentVo);
end

function FollowerModel:GetTalentItemVO( followerId, talentId )
	local talentVo = nil;
	if followerId == 0 then
		talentVo = self.mTalentListByUID[ talentId ];
	else
		talentVo = self.mFolloweList2:GetValue(followerId).mTalentListToID[ talentId ];
	end
	return talentVo;
end

function FollowerModel:AddOrUpdateTalentVO( followerId, talentVo )
	if followerId == 0 then
		local sortTable = self:GetTalentTable( talentVo:GetGoodsType(), talentVo:GetTalentType() );
		sortTable:AddOrUpdate( talentVo:GetUID(), talentVo );
	else
		local followerVo = self.mFolloweList2:GetValue(followerId);
		followerVo:UpdateFollowerAttribute( );
	end
end

function FollowerModel:OnRecvTalentWash( followerId, talentId, pbTalentAttributeAdd )
	local talentVo = self:GetTalentItemVO( followerId, talentId );
	talentVo:OnRecvTalentWash( pbTalentAttributeAdd );
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_WASH_TALENT, talentVo);
end

function FollowerModel:OnRecvTalentWashSave(followerId,  pbTalent )
	local talentVo = self:GetTalentItemVO( followerId,  pbTalent.id );
	talentVo:OnRecvTalentWashSave( pbTalent );
	self:AddOrUpdateTalentVO( followerId, talentVo );
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_WASH_TALENT_SAVE, talentVo);
	self.mWaitWashTalent = nil;
end

function FollowerModel:OnRecvTalentWashGiveUp(followerId,  pbTalent )
	local talentVo = self:GetTalentItemVO( followerId,  pbTalent.id );
	talentVo:OnRecvTalentWashGiveUp( pbTalent );
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_WASH_TALENT_GIVE, talentVo);
	self.mWaitWashTalent = nil;
end
--才艺背包
function FollowerModel:OnRecvTalentInit( pbTalentLists )
	local key = nil;
	local type_1 = nil;
	local type_2 = nil;
	local talentList = self.mTalentListByUID;
	for k, v in mIpairs( pbTalentLists.talent_list ) do
		type_1 = v.type;
		type_2 = v.talent_type;
		local sortTable = self:GetTalentTable( type_1, type_2 );
		local talentVO = TalentItemVO.LuaNew( v ) ;
		sortTable:AddOrUpdate( v.id, talentVO );
		talentList[ v.id ] = talentVO;

		if #v.temp_attribute > 1 then
			self.mWaitWashTalent = talentVO;
		end
	end
end

function FollowerModel:GetWaitWashTalent(  )
	local talentVO = self.mWaitWashTalent;
	if talentVO then
		return talentVO;
	else
		return nil;
	end
end

function FollowerModel:GetGoodsKeyByPos( goods_type, talent_type )
	return goods_type * 100 + talent_type;
end

function FollowerModel:GetTalentTable( goods_type, talent_type )
	local key = self:GetGoodsKeyByPos( goods_type, talent_type );
	local talentList = self.mTalentListByType;
	local table = talentList[ key ];
	if table == nil then
		table = mSortTable.LuaNew(function(a, b) return self:SortTalent(a,b) end, nil, true);
		talentList[ key ] = table;
	end
	return table;
end

function FollowerModel:GetTalentTableByPos( goods_type, talent_type, pos )
	local sortTable = self:GetTalentTable( goods_type, talent_type );
	if pos ==  0 then
		return sortTable;
	else
		local talenTable = mSortTable.LuaNew(function(a, b) return self:SortTalent(a,b) end, nil, true);
		for k, v in pairs ( sortTable.mSortTable ) do
			if v:GetPosition() == pos then
				talenTable:AddOrUpdate( v:GetUID(), v )
			end
		end
		return talenTable;
 	end 
end

function FollowerModel:SortTalent( a, b )
	local aID = a.mID;
	local bID = b.mID;
	local aStar = a:GetStar();
	local bStar = b:GetStar();
	local aColor = a:GetColor( );
	local bColor = b:GetColor( );
	local aLevel = a:GetLevel( );
	local bLevel = b:GetLevel( );
	
	if aStar == bStar then
		if aColor == bColor then
			if aLevel == bLevel then
				return aID < bID;
			else
				return aLevel > bLevel;
			end
		else
			return aColor > bColor;
		end
	else
		return aStar > bStar;
	end
end

function FollowerModel:OnRecvTalentUpdate( pbTalentLists )
	local talentList = self.mTalentListByUID;

	local uid = nil;
	local type_1 = nil;
	local type_2 = nil;
	for k, v in mIpairs( pbTalentLists.talent_list ) do

		uid = v.id;
		type_1 = v.type;
		type_2 = v.talent_type;
		local talentVO = talentList[ uid ];
		local sortTable = self:GetTalentTable( type_1, type_2 );

		if talentVO then
			if v.num ~= 0 then
				talentVO:OnUpdateTalent( talentVO );
			else
				talentList[ uid ] = nil;
				sortTable:RemoveKey( uid );

				local talentVO = self.mWaitWashTalent;
				if talentVO and  talentVO:GetUID() == uid then
					talentVO = nil;
				end
			end
		else
			talentVO = TalentItemVO.LuaNew( v ) ;
			sortTable:AddOrUpdate( uid, talentVO );
			talentList[ uid ] = talentVO;
		end
	end
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_TALENT_UPDATE);
end

return FollowerModel;