local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local PoolManager = require "Common/PoolManager"
local mBaseViewPool = PoolManager.mBaseViewPool;
local mBaseObjectPool = PoolManager.mBaseObjectPool;
local CombatWordManager = mLuaClass("CombatWordManager",mBaseLua);
local mGameTimer = require "Core/Timer/GameTimer"

local mEventEnum = require "Enum/EventEnum"
local mEventDispatcher = require "Events/EventDispatcher"

local Time = UnityEngine.Time;
local mInterval = 0.15;

function CombatWordManager:OnLuaNew()
	self.mParams = {};
	self.mUpdate = function ()
		self:Update();
	end
	self.mViews = {};
	self:AddEventListeners();
end

function CombatWordManager:AddEventListeners()
	mEventDispatcher:AddEventListener(mEventEnum.SHOW_SKILL_NAME,function (skill)
		self:ShowSkillName(skill);
	end);
end

function CombatWordManager:ShowCombatArtTextWord(type,word,actor)
	local params = self.mParams;
	params.actor = actor;
	params.word = word;
	params.type = type;
	self:ShowCombatWordView(params,"Module/Combat/CombatArtTextWordView");
end

function CombatWordManager:ShowCombatTextWord(type,word,actor)
	local params = self.mParams;
	params.actor = actor;
	params.word = word;
	params.type = type;
	self:ShowCombatWordView(params,"Module/Combat/CombatTextWordView");
end

function CombatWordManager:ShowCombatImageWord(word,actor)
	local params = self.mParams;
	params.actor = actor;
	params.word = word;
	self:ShowCombatWordView(params,"Module/Combat/CombatImageWordView");
end

function CombatWordManager:ShowCombatWordView(params,cls)
	local view = mBaseViewPool:Get(cls);
	view:SetData(params);
	view["cls"] = cls;
	local actor = params.actor;
	local showQueues = self.mQueues;
	if not showQueues then
		showQueues = {};
		self.mQueues = showQueues;
		UpdateBeat:Add(self.mUpdate);
	end

	local showQueue = showQueues[actor];
	if not showQueue then
		showQueue = mBaseObjectPool:Get("Common/Queue");
		showQueue.mLastShowTime = 0;
		showQueues[actor] = showQueue;
	end

	showQueue:Enqueue(view);
end

function CombatWordManager:ShowView(view)
	local views = self.mViews;
	views[view] = view;
	view:ShowView();
	mGameTimer.SetTimeout(2, function ()
		views[view] = nil;
		view:HideView();
		mBaseViewPool:Put(view,view["cls"]);
	end);
end

function CombatWordManager:PutView(views,view)
	views[view] = nil;
	view:HideView();
	mBaseViewPool:Put(view,view["cls"]);
end

function CombatWordManager:ShowNext(showQueue,time)

    if time - showQueue.mLastShowTime > mInterval then
    	local view = showQueue:Dequeue();
    	if view then
    		self:ShowView(view);
    		showQueue.mLastShowTime = time;
    	else
    		return true;
    	end
    end
end

function CombatWordManager:Update()
	local showQueues = self.mQueues;
	local time = Time.time;
	local hasQueues = nil;
	if showQueues then
	    for k,v in pairs(showQueues) do
	    	if self:ShowNext(v,time) then
	    		showQueues[k] = nil;
	    		mBaseObjectPool:Put(v,"Common/Queue");
	    	end
	    	hasQueues = true;
	    end	
	end
	
    if not hasQueues then
    	UpdateBeat:Remove(self.mUpdate);
    	self.mQueues = nil;
    end
end

function CombatWordManager:Clear()
	if self.mQueues then
		UpdateBeat:Remove(self.mUpdate);
		self.mQueues = nil;
	end

	local views = self.mViews;
	for k,v in pairs(views) do
		v:HideView();
	end
end

function CombatWordManager:ShowSkillName(skill)
	self:ShowCombatTextWord(0,skill.mName,skill.mOwner);
end

return CombatWordManager.LuaNew();