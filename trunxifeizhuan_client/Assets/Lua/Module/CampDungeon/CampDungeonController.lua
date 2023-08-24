local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mCommonRewardVO = require "Module/CommonUI/CommonRewardVO"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local CampDungeonController = mLuaClass("CampDungeonController",mBaseController);

function CampDungeonController:OnLuaNew()
	local super = self:GetSuper(mBaseController.LuaClassName);
	super.OnLuaNew(self);
end

function CampDungeonController:AddNetListeners()
    self.mS2C:DUNGEON_INFO(function(pbDungeonList)
		mGameModelManager.CampDungeonModel:RecvCampToDungeonData(pbDungeonList);
		self:Dispatch(mEventEnum.ON_GET_CAMPDUNGEON_DATA,mGameModelManager.CampDungeonModel.mCampList);
	end);
	self.mS2C:DUNGEON_REBORN_BATTLE(function(pbResult)
		-- 复活
        mCombatModelManager.mCurrentModel:RecvReliveResult();
	end);
    self.mS2C:DUNGEON_START_BATTLE(function (pbDungeonBattleResult)
    	self.mCampID = pbDungeonBattleResult.dungeon_id;
	    self.mLevelID = pbDungeonBattleResult.past_id;
    	mCombatModelManager:CreateCampCombatModel(pbDungeonBattleResult.past_id);
    	self.mDungeonReward = pbDungeonBattleResult.reward;
    end);
    self.mS2C:DUNGEON_BATTLE_RESULT(function(pbDungeonBattleResult)
         if self.mWin == 1 then
            mGameModelManager.CampDungeonModel:RefreshPassLevel(pbDungeonBattleResult.dungeon_id,pbDungeonBattleResult.past_id);
         end
         self.mDungeonReward = pbDungeonBattleResult.reward;
         self.mDungeonRewardTalents = pbDungeonBattleResult.talent_reward;
	end);
	self.mS2C:DUNGEON_PARTNER_INFO(function(pbDungeonPartnerInfo)
		mGameModelManager.CampDungeonModel:RecvFollower(pbDungeonPartnerInfo);
	end);
end

function CampDungeonController:AddEventListeners()

end

function CampDungeonController:GetDungeonWinReward(  )
	local reward = mCommonRewardVO.LuaNew();
	reward:InitDungeonReward(self.mDungeonReward);
	reward:InitDungeonRewardTalents(self.mDungeonRewardTalents);
	return reward;
end

function CampDungeonController:OpenLevelDetial(data)
	mUIManager:HandleUI(mViewEnum.CampDungeonDetialView,1,data);
end

function CampDungeonController:SendGetCampDungeonList()
	self.mC2S:DUNGEON_INFO(true)
end
                               
function CampDungeonController:OnOpenCombatView( )
	mUIManager:HandleUI(mViewEnum.CombatView,1);
end

function CampDungeonController:OpenResurgenceView(callBack)
	mUIManager:HandleUI(mViewEnum.CampDungeonResurgenceView,1,callBack);
end

function CampDungeonController:SendChallengeCampDungeon(camp_id,level_id)
	self.mC2S:DUNGEON_START_BATTLE(camp_id,level_id,true);
end

function CampDungeonController:SendResurgence()
	self.mC2S:DUNGEON_REBORN_BATTLE(self.mCampID,self.mLevelID,true);
end

function CampDungeonController:SendBattleOver(win)
    self.mWin = win;
    local list = mCombatModelManager.mCurrentModel:GetDungeonBattleHero();
    local followers = self:GetFollowerTable(list);
	self.mC2S:DUNGEON_BATTLE_RESULT(self.mCampID,self.mLevelID,win,self.mDungeonReward,followers,true);
end

function CampDungeonController:SendGetDungeonFollower(id)
	self.mC2S:DUNGEON_PARTNER_INFO(id,true);
end

function CampDungeonController:GetFollowerTable(list)
	local tableFollower = {};
	for k,v in pairs(list) do
		if not v:IsLead() then
			tableFollower[v.mID] = v.mID;
		end
	end
	local tableSingleFollower = {};
	for k,v in pairs(tableFollower) do
		table.insert(tableSingleFollower,v)
	end
	return tableSingleFollower;
end

return CampDungeonController.LuaNew();