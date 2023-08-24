local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mDoFileUtil = require "Utils/DoFileUtil";
local mSceneManager = require "Module/Scene/SceneManager"
local mGameModelManager = require "Manager/GameModelManager"
local mCombatModelBase = require "Module/Combat/CombatModelBase"
local CombatModelManager = mLuaClass("CombatModelManager",mBaseLua);

--[[1剧情副本
2挑战副本
3传记副本
4深宫魅影
5宫深似海
6美人心计
7竞技场，晋封
8巅峰宫斗
9精英副本--]]
function CombatModelManager:OnLuaNew()
	self.mPlayerLv = 0;
	self.mPlayerExp = 0;
	self.mEnumDungeonType = { StoryDungeon = 1, CampDungeon = 2, FollowerDungeon = 3, Shengongmeiying = 4, 
			Gongshensihai = 5, Meirenxinji = 6, ArenaDungeon = 7, Dianfenggongdou = 8, EliteDungeon = 9 };
end

--创建剧情副本战斗逻辑--
function CombatModelManager:CreateDungeonCombatModel(dungeon_id)
	self.mCurrentModel = mDoFileUtil:DoFile("Module/Dungeon/DungeonCombatModel").LuaNew(dungeon_id);
	self:AskForEnterScene(dungeon_id,  self.mEnumDungeonType.StoryDungeon);
	self:RecordPlayerLvAndExp( );
end

--创建竞技场战斗逻辑
function CombatModelManager:CreateArenaCombatModel(dungeon_id, teamVO)
	self.mCurrentModel = mDoFileUtil:DoFile("Module/Arena/Combat/ArenaCombatModel").LuaNew(dungeon_id, teamVO);
	self:AskForEnterScene(dungeon_id, self.mEnumDungeonType.ArenaDungeon);
	self:RecordPlayerLvAndExp( );
end

--创建晋升武斗战斗逻辑
function CombatModelManager:CreatePromotePVPCombatModel(dungeon_id, teamVO)
	self.mCurrentModel = mDoFileUtil:DoFile("Module/Promote/PromotePVPCombatModel").LuaNew(dungeon_id, teamVO);
	self:AskForEnterScene(dungeon_id , self.mEnumDungeonType.ArenaDungeon);
	self:RecordPlayerLvAndExp( );
end

function CombatModelManager:AskForEnterScene(dungeon_id, params )
	mSceneManager:AskForEnterScene(dungeon_id, params);
end

function CombatModelManager:RecordPlayerLvAndExp(  )
	local roleBase = mGameModelManager.RoleModel.mPlayerBase;
	self.mPlayerLv = roleBase.level;
	self.mPlayerExp= roleBase.exp;
end

--创建传记副本战斗逻辑
function CombatModelManager:CreateFollowerDungeonCombatModel(dungeon_id)
	self.mCurrentModel = mDoFileUtil:DoFile("Module/Follower/FollowerDungeonCombatModel").LuaNew(dungeon_id);
	self:AskForEnterScene(dungeon_id, self.mEnumDungeonType.FollowerDungeon);
	self:RecordPlayerLvAndExp( );
end

--创建玩法副本战斗逻辑
function CombatModelManager:CreateCampCombatModel(dungeon_id)
	self.mCurrentModel = mDoFileUtil:DoFile("Module/CampDungeon/CampDungeonCombatModel").LuaNew(dungeon_id);
	self:AskForEnterScene(dungeon_id, self.mEnumDungeonType.CampDungeon);
	self:RecordPlayerLvAndExp( );
end

--创建美人心计战斗逻辑
function CombatModelManager:CreateMeirenxinjiCombatModel(dungeon_id)
	self.mCurrentModel = mDoFileUtil:DoFile("Module/EndlessDungeon/Meirenxinji/EndlessMeirenxinjiCombatModel").LuaNew(dungeon_id);
	self:AskForEnterScene(dungeon_id, self.mEnumDungeonType.Meirenxinji );
	self:RecordPlayerLvAndExp( );
end

--创建宫深似海战斗逻辑
function CombatModelManager:CreateGongshensihaiCombatModel(dungeon_id)
	self.mCurrentModel = mDoFileUtil:DoFile("Module/EndlessDungeon/Gongshensihai/EndlessGongshensihaiCombatModel").LuaNew(dungeon_id);
	self:AskForEnterScene(dungeon_id, self.mEnumDungeonType.Gongshensihai );
	self:RecordPlayerLvAndExp( );
end

--创建深宫魅影战斗逻辑
function CombatModelManager:CreateShengongmeiyingCombatModel(dungeon_id)
	self.mCurrentModel = mDoFileUtil:DoFile("Module/EndlessDungeon/Shengongmeiying/EndlessShengongmeiyingCombatModel").LuaNew(dungeon_id);
	self:AskForEnterScene(dungeon_id, self.mEnumDungeonType.Shengongmeiying );
	self:RecordPlayerLvAndExp( );
end

--创建巅峰宫斗玩法
function CombatModelManager:CreateDianfenggongdouCombatModel(dungeon_id, teamVO)
	self.mCurrentModel = mDoFileUtil:DoFile("Module/Dianfenggongdou/DianfenggongdouCombatModel").LuaNew(dungeon_id, teamVO);
	self:AskForEnterScene(dungeon_id, self.mEnumDungeonType.Dianfenggongdou );
	self:RecordPlayerLvAndExp( );
end

--创建精英副本战斗逻辑
function CombatModelManager:CreateEliteDungeonCombatModel(dungeon_id)
	self.mCurrentModel = mDoFileUtil:DoFile("Module/EliteDungeon/EliteDungeonCombatModel").LuaNew(dungeon_id);
	self:AskForEnterScene(dungeon_id, self.mEnumDungeonType.EliteDungeon );
	self:RecordPlayerLvAndExp( );
end

local instance = CombatModelManager.LuaNew();
return instance;