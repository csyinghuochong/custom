local mLuaClass = require "Core/LuaClass"
local mPlayerPrefs = UnityEngine.PlayerPrefs;
local mMonsterVO = require "Module/Follower/MonsterVO"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local FollowerVOControl = require "Module/Follower/FollowerVOControl"
local mConfigSysEndlessdungeon = require "ConfigFiles/ConfigSysendless_dungeon"
local BattleArrayViewVO = mLuaClass("BattleArrayViewVO");
local mString = require 'string'
local mTable = require 'table'
local mIpairs = ipairs;
local mPairs = pairs;

function BattleArrayViewVO:OnLuaNew()

end

--*********************
--战斗阵容，需要统一保存在本地。
--get/set team
local mNewTeamPlayId = 100;
function BattleArrayViewVO:GetPlayerName(play_type)
	local playId = mGameModelManager.RoleModel:GetPlayerID();
	return mString.format('%d_CombatTeam02_%d', playId, play_type);
end

function BattleArrayViewVO:SetPlayTeam(play_type, selfHeros)
	local team = "";
	local newTeam = '';
	local number = mTable.getn(selfHeros);
	for i = 1, number do
		team = mString.format('%s%s_%s_%s', i == 1 and '' or team..'_', selfHeros[i].mUID,  selfHeros[i].mWave or 1, selfHeros[i].mPos or 1);
		newTeam = mString.format('%s%s', i == 1 and '' or newTeam..'_', selfHeros[i].mUID);
	end
	mPlayerPrefs.SetString(self:GetPlayerName(play_type), team);
	mPlayerPrefs.SetString(self:GetPlayerName(mNewTeamPlayId), newTeam);
end

function BattleArrayViewVO:GetNewestTeam(  )
	local newTeam = mPlayerPrefs.GetString(self:GetPlayerName(mNewTeamPlayId));
	local actorList = {};
	for actor_id in mString.gmatch(newTeam, "(%d+)_*") do
		actorList[actor_id] = true;
	end
	return actorList;
end

function BattleArrayViewVO:GetPlayTeam(play_type) 
	local selfHeros= {};
	local arenaTeam = mPlayerPrefs.GetString(self:GetPlayerName(play_type));
	local FollowerModel = mGameModelManager.FollowerModel;
	if arenaTeam ~= "" then

		local index = 1;
		local follower_id;
		local follower_wave;
		local follower_pos;
		for pos in mString.gmatch(arenaTeam, "(%d+)_*") do
			if index == 1 then
				follower_id = pos;
				index = index + 1;
			elseif index == 2 then
				follower_wave = tonumber(pos);
				index = index + 1;
			elseif index == 3 then
				follower_pos = tonumber(pos);
				index = 1;

				local actor = FollowerModel:GetFollowerByID(follower_id);
				if actor ~= nil then
					actor.mWave = follower_wave;
					actor.mPos = follower_pos;
					if play_type ~= 6 then 
                       mTable.insert(selfHeros, actor);
					else
					   if actor:GetMeirenCurrentHp() > 0 then
                          mTable.insert(selfHeros, actor);
					   end
				    end
				end
			end
		end
	else
		if play_type == 6 then
           selfHeros[1] = mGameModelManager.EndlessDungeonModel:GetMeirenBattleHero();
		else
		   selfHeros[1] = FollowerModel:GetLeadVO();
		end
	end

	return selfHeros;
end

--*********************
--以下为战斗整容，统一保存在本地。
--普通pve副本
function BattleArrayViewVO:InitPVETeam(dungeon_id, call_back , team_number, enemy_number)
	self.mDungeonId = dungeon_id;   --dungeon_id. 不能为空  
	local config = mConfigSysdungeon[dungeon_id];  
	if config == nil then
		config = mGameModelManager.DungeonModel.mConfigSysdungeon[ dungeon_id ];
	end  
	self.mLevelName = config.dungeon_name;
	local combat_cost = config.strength_w;
	self.mCostType = combat_cost[1];
	self.mCostStrength = combat_cost[2];
	self.mTeamMaxNumber = team_number and team_number or 5;
	self.mEnemyMaxNumber = enemy_number and enemy_number or 5;
	self.mSelfHeros = self:GetPlayTeam(config.play_type);   

	self.mCallBack = function ( data )
		self:SetPlayTeam(config.play_type, data.mSelfHeros);
		call_back(data);
	end;
	self:InitPveData(config.monster_node);
end

function BattleArrayViewVO:InitPveData(monsterGroup)
	--野怪数据为空，读取ConfigSysdungeon表
	--以最后一波怪为准
	local enemyVO = {};
	if self.mEnemyHeros == nil then
		local monsterWave = mTable.getn(monsterGroup);
		local lastMonster = monsterGroup[monsterWave];

		local bossVO = lastMonster.boss_id;
		local monsterVO = lastMonster.monster_id;
		local monsterNum = lastMonster.monster_number;

		if bossVO ~= nil then
			for k, v in mPairs(bossVO) do
				mTable.insert(enemyVO, mMonsterVO.LuaNew(v.monster_id,v.lv,v.type));
			end
		end

		if monsterVO ~= nil then
			for k, v in mPairs(monsterVO) do
				if v ~= 0 and k <= monsterNum then
					mTable.insert(enemyVO, mMonsterVO.LuaNew(v.monster_id,v.lv,v.type));
				end
			end
		end
		
		self.mEnemyHeros = enemyVO;
	end
end

--初始深宫魅影野怪VO
function BattleArrayViewVO:InitShengongmeiyingTeam(dungeon_id,call_back )
	self.mDungeonId = dungeon_id;   --dungeon_id. 不能为空  
	local config = mConfigSysEndlessdungeon[dungeon_id];    
	self.mLevelName = config.dungeon_name;
	local combat_cost = config.strength_w;
	self.mCostType = combat_cost[1];
	self.mCostStrength = combat_cost[2];    
	self.mTeamMaxNumber = 5;
	self.mEnemyMaxNumber = 5;
	self.mSelfHeros = self:GetPlayTeam(config.play_type);   

	self.mCallBack = function ( data )
		self:SetPlayTeam(config.play_type, data.mSelfHeros);
		call_back(data);
	end;
    self:InitShengongmeiyingMonsterData(dungeon_id);
end

function BattleArrayViewVO:InitShengongmeiyingMonsterData(dungeon_id)
	local shengongmeiyingMonsters = mGameModelManager.EndlessDungeonModel.mShengongmeiyingData.mClimbTowerMonsters
	--显示最后一波怪
	local monsterWave = mTable.getn(shengongmeiyingMonsters.list);
	local lastMonster = shengongmeiyingMonsters.list[monsterWave];
	local enemyVO = {};
	for i,v in mIpairs(lastMonster.list) do
		mTable.insert(enemyVO, mMonsterVO.LuaNew(v.id,v.level,v.type));
	end
	self.mEnemyHeros = enemyVO;
end

--初始宫深似海野怪VO
function BattleArrayViewVO:InitGongshensihaiTeam(dungeon_id,call_back )
	self.mDungeonId = dungeon_id;   --dungeon_id. 不能为空  
	local config = mConfigSysEndlessdungeon[dungeon_id];    
	self.mLevelName = config.dungeon_name;
	local combat_cost = config.strength_w;
	self.mCostType = combat_cost[1];
	self.mCostStrength = combat_cost[2];     
	self.mTeamMaxNumber = 5;
	self.mEnemyMaxNumber = 5;
	self.mSelfHeros = self:GetPlayTeam(config.play_type);   

	self.mCallBack = function ( data )
		self:SetPlayTeam(config.play_type, data.mSelfHeros);
		call_back(data);
	end;

    self:InitPveData(config.monster_node);
end

--初始美人心计战队VO
function BattleArrayViewVO:InitMeirenxinjiTeam(dungeon_id,call_back )
	self.mDungeonId = dungeon_id;   --dungeon_id. 不能为空  
	local config = mConfigSysEndlessdungeon[dungeon_id];    
	self.mLevelName = config.dungeon_name;
	local combat_cost = config.strength_w;
	self.mCostType = combat_cost[1];
	self.mCostStrength = combat_cost[2]; 
	self.mTeamMaxNumber = 5;
	self.mEnemyMaxNumber = 5;
	self.mSelfHeros = self:GetPlayTeam(config.play_type);
	self.mCanOpLead = true;

	self.mCallBack = function (data,buffs)
		self:SetPlayTeam(config.play_type, data.mSelfHeros);
		call_back(data.mEnemyHeros,buffs);
	end;

	self:InitMeirenxinjiData();
end

function BattleArrayViewVO:InitMeirenxinjiData()
	local mEndlessDungeonModel = mGameModelManager.EndlessDungeonModel;
	local enemyHeros = {};
	local partnerList = mEndlessDungeonModel.mMeirenxinjiData.mDefense;
	if partnerList == nil then
       self.mEnemyHeros = FollowerVOControl:CreateRobotVO(mEndlessDungeonModel.mMeirenxinjiData.mRobotId);
	else
       	for i,v in mIpairs(partnerList.vs_partner) do
			if v.hero_id ~= nil then
		    	local item = FollowerVOControl:CreatePromoteArenaActor(v, partnerList.fashion_list);
				mTable.insert(enemyHeros, item);
			end
		end
		self.mEnemyHeros = enemyHeros;
	end
end

--竞技场/晋升武斗攻击整容
local mGlobalUtil = require "Utils/GlobalUtil"
function BattleArrayViewVO:InitArenaBattleTeam(player_id, dungeon_id,pbArenaVsPlayerDefense, callBack)
	local enemyHeros = {};
	local player_id = tonumber(player_id);
	if player_id <  mGlobalUtil.RobotMaxId then
		enemyHeros = FollowerVOControl:CreateRobotVO(player_id);
	else
		for k, v in mIpairs(pbArenaVsPlayerDefense.vs_partner) do
			local item = FollowerVOControl:CreatePromoteArenaActor(v, pbArenaVsPlayerDefense.fashion_list);
			mTable.insert(enemyHeros, item);
		end
	end

	local dungeon_vo = mConfigSysdungeon[dungeon_id];
	self.mLevelName = dungeon_vo.dungeon_name;
	self.mSelfHeros = self:GetPlayTeam(dungeon_vo.play_type);
	self.mEnemyHeros  = enemyHeros;
	self.mTeamMaxNumber = 5;
	self.mEnemyMaxNumber = 5;
	local combat_cost = dungeon_vo.strength_w;
	self.mCostType = combat_cost[1];
	self.mCostStrength = combat_cost[2];
	self.mCallBack = function ( data )
		self:SetPlayTeam(dungeon_vo.play_type, data.mSelfHeros);
		callBack(data);
	end;
end

--巅峰宫斗攻击整容
function BattleArrayViewVO:InitPromoteArenaBattleTeam(dungeon_id, pbVsPlayerDefense, call_back)
	local selfHeros = {};
	local enemyHeros = {};

	local dungeon_vo = mConfigSysdungeon[dungeon_id];
	local combat_cost = dungeon_vo.strength_w;

 	local selfList = self:GetPlayTeam(dungeon_vo.play_type);
 	for k, v in mPairs(selfList) do
 		local wave = v.mWave or 1;
 		local pos = v.mPos or 1;
		v.mWave = wave;
		v.mPos = pos
		mTable.insert(selfHeros, v);
 	end

	for k, v in mIpairs(pbVsPlayerDefense.vs_partner) do
		local wave = v.team == 0 and 1 or v.team;
		local pos = v.pos == 0 and 1 or v.pos;
	
		local item = FollowerVOControl:CreatePromoteArenaActor(v,  pbVsPlayerDefense.fashion_list);
		item.mWave = wave;
		item.mPos = pos;

		mTable.insert(enemyHeros, item);
	end

	self.mSelfHeros = selfHeros;
	self.mEnemyHeros  = enemyHeros;
	self.mTeamMaxNumber = 9;
	self.mEnemyMaxNumber = 9;
	self.mCostType = combat_cost[1];
	self.mCostStrength = combat_cost[2];
	self.mLevelName = dungeon_vo.dungeon_name;

	self.mCallBack = function ( data )
		self:SetPlayTeam(dungeon_vo.play_type, data.mSelfHeros);
		call_back(data);
	end;
end

--*********************
--以下为防守整容，需要保存在服务器。
--竞技场防守整容
function BattleArrayViewVO:InitArenaDefendTeam( dungeon_id, pbArenaDefensePos, call_back )
	local selfHeros = {};

	local FollowerModel = mGameModelManager.FollowerModel;
	selfHeros[1] = FollowerModel:GetLeadVO();
	for k, v in mIpairs(pbArenaDefensePos.partner_pos_list) do
		local actor =  FollowerModel:GetFollowerByID(tostring(v.partner_id));
		if actor ~= nil then
			mTable.insert(selfHeros, actor);
		end
	end

	self.mLevelName = mConfigSysdungeon[dungeon_id].dungeon_name;
	self.mSelfHeros = selfHeros;
	self.mCallBack = call_back;
	self.mTeamMaxNumber = 5;
end

--巅峰宫斗防守整容
function BattleArrayViewVO:InitPromoteArenaDefendTeam(pbDefensePos, call_back)
	local selfHeros = {};

	local FollowerModel = mGameModelManager.FollowerModel;
	self:AddTeamHero(selfHeros, FollowerModel.mLeadID,1, 1);

	for k,v in mIpairs(pbDefensePos.partner_pos_list) do
		local team = v.team;
		self:AddTeamHero(selfHeros, v.partner_id,team, v.pos);
	end

	self.mSelfHeros = selfHeros;
	self.mCallBack = call_back;
	self.mTeamMaxNumber = 9;
end

function BattleArrayViewVO:AddTeamHero( heroList, id, team, pos )
	local teamer = mGameModelManager.FollowerModel:GetFollowerByID(tostring(id));
	if teamer ~= nil then
		teamer.mWave = team;
		teamer.mPos = pos;
		mTable.insert(heroList, teamer);
	end
end

return BattleArrayViewVO;