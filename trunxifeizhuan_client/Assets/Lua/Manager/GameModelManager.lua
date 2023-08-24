local mDoFileUtil = require "Utils/DoFileUtil"
local mEventEnum = require "Enum/EventEnum"

local GameModelDefine = {
	GmModel = "Module/Gm/GmModel",
	BagModel = "Module/Bag/BagModel",
	MailModel = "Module/Mail/MailModel",
	ChatModel = "Module/Chat/ChatModel",
	RoleModel = "Module/Role/RoleModel",
	KingModel = "Module/King/KingModel",
	StoreModel = "Module/Store/StoreModel",
	LoginModel = "Module/Login/LoginModel",
	ArenaModel = "Module/Arena/ArenaModel",
	FriendModel = "Module/Friend/FriendModel",
	BowlderMode1 = "Module/Talent/TalentModel",
	DungeonModel = "Module/Dungeon/DungeonModel",
	PromoteModel = "Module/Promote/PromoteModel",
	FollowerModel = "Module/Follower/FollowerModel",
	DraftModel = "Module/Draft/DraftModel",
	TaskModel = "Module/Task/TaskModel",
	RankModel = "Module/Rank/RankModel",
	GuideModel = "Module/Guide/GuideModel",
	CheckModel = "Module/Check/CheckModel",
	MansionModel = "Module/Mansion/MansionModel",
	EliteDungeonModel = "Module/EliteDungeon/EliteDungeonModel",
	WorshipQueenModel = "Module/WorshipQueen/WorshipQueenModel",
	CampDungeonModel = "Module/CampDungeon/CampDungeonModel",
	EndlessDungeonModel = "Module/EndlessDungeon/EndlessDungeonModel",
	WorshipAncestorModel = "Module/WorshipAncestor/WorshipAncestorModel",
	ChildModel = "Module/Child/ChildModel",
	MysteryModel = "Module/Mystery/MysteryModel",
	ReceivePowerModel = "Module/ReceivePower/ReceivePowerModel",
	FashionModel = "Module/Fashion/FashionModel",
	ArchiveModel = "Module/Archive/ArchiveModel",
};

local GameModelManager = setmetatable({},{
	 __index = function ( t,k )
	 	local modelPath = GameModelDefine[k];
	 	if not modelPath then
	 		error("GameModelDefine key is nil:" .. k);
	 		return nil;
	 	end

	 	--print("GameModelManager get value:" .. k);

	 	local cls = mDoFileUtil:DoFile(modelPath);
		local instance = cls.LuaNew();
		instance.mEventEnum = mEventEnum;
		t[k] = instance;
		return instance;
	 end
	})

local mFirstClear = true;

GameModelManager.ClearModels = function()
	print("ClearModels");

	for k,v in pairs(GameModelManager) do
		if k ~= "ClearModels" then

			if mFirstClear then
				print(k,"获取方式错误===========================");
			end

			v:OnDispose();

			GameModelManager[k] = nil;
		end
	end

	mFirstClear = false;
end

return GameModelManager;
