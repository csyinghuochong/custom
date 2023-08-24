local mLuaClass = require "Core/LuaClass"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local mEventEnum = require "Enum/EventEnum"
local mC2S = require "ProtolManager/C2S"
local mS2C = require "ProtolManager/S2C"
local mGameModelManager = require "Manager/GameModelManager"
local mSoundManager = require "Module/Sound/SoundManager"
local BaseController = mLuaClass("BaseController",mEventDispatcherInterface);

function BaseController:OnLuaNew()
	self.mEventEnum = mEventEnum;
	self.mC2S = mC2S;
	self.mS2C = mS2C;
	self.mGameModelManager = mGameModelManager;

	self:AddNetListeners();
	self:AddEventListeners();
end

--协议处理--
function BaseController:AddNetListeners()
	
end

--事件处理--
function BaseController:AddEventListeners()
	
end

function BaseController:PlaySoundName(soundName)
	mSoundManager:PlaySoundName(soundName);
end

return BaseController;