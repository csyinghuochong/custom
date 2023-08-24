local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mEventEnum = require "Enum/EventEnum"
local mEventDispatcher = require "Events/EventDispatcher"
local ArenaModel = mLuaClass("ArenaModel",mBaseModel);

function ArenaModel:OnLuaNew()
	
end

function ArenaModel:OnRecvArenaInfo(pbArena)
	self.mArenaInfo = pbArena;
	
	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_ARENA_INIT, pbArena);
end

function ArenaModel:OnRefreshArena(pbArena)
	self.mArenaInfo = pbArena;

	mEventDispatcher:Dispatch(mEventEnum.ON_RECV_ARENA_UPDATE, pbArena);
end

return ArenaModel;