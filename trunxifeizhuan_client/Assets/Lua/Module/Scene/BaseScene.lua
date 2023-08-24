local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mSceneManager = require "Module/Scene/SceneManager"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local mEventEnum = require "Enum/EventEnum"
local BaseScene = mLuaClass("BaseScene",mEventDispatcherInterface);

function BaseScene:OnLuaNew(sceneID)
	self.mSceneID = sceneID;
end

function BaseScene:PrevSceneIsLoginScene()
	return mSceneManager:PrevSceneIsLoginScene();
end

function BaseScene:LoadScene()
	
end

function BaseScene:InternalLoadSceneCompleted()
	self:LoadSceneCompleted();
	mSceneManager:LoadSceneCompleted();
end

function BaseScene:LoadSceneCompleted()

end

function BaseScene:ChangePanelVisible()
	mUIManager:ChangePanelVisible(self.mSceneID);
end

function BaseScene:BeforeEnterScene()
	self:ChangePanelVisible();
	self:OnBeforeEnterScene();
end

--子类重载
function BaseScene:OnBeforeEnterScene()

end

function BaseScene:EnterScene()
	self:OnEnterScene();
	self:PlaySound();
	self:OnAfterPlaySound();
end

function BaseScene:PlaySound()
	local soundID = self:GetSoundID();
	if soundID~= nil then
		self:Dispatch(mEventEnum.PLAY_SOUND,soundID);
	end
end

--子类重载
function BaseScene:OnEnterScene()

end

function BaseScene:OnAfterPlaySound()
	
end

function BaseScene:BeforeExitScene()
	self:StopSound();
	self:OnBeforeExitScene();
end

function BaseScene:StopSound()
	local soundID = self:GetSoundID();
	if soundID~= nil then
		self:Dispatch(mEventEnum.STOP_SOUND,soundID);
	end
end

--子类重载
function BaseScene:OnBeforeExitScene()

end

function BaseScene:ExitScene()
	self:OnExitScene();
end

--子类重载
function BaseScene:OnExitScene()
	
end

function BaseScene:GetSoundID()
	return nil;
end

return BaseScene;