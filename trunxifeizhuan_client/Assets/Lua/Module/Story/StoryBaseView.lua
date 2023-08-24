local mBaseWindow = require "Core/BaseWindow"
local mLuaClass = require "Core/LuaClass"
local GameObject = UnityEngine.GameObject;
local mUIManager = require "Manager/UIManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local StoryBaseView = mLuaClass("StoryBaseView",mBaseWindow);
local mSoundManager = require "Module/Sound/SoundManager"

local mSuper = nil;

function StoryBaseView:OnLuaNew(go)
	mSuper = self:GetSuper(mBaseWindow.LuaClassName);
	mSuper.OnLuaNew(self,go);
end

function StoryBaseView:InternalOnViewShow()
	self.mCurLoopSoundID = mSoundManager.mCurLoopSoundID;

	mSuper.InternalOnViewShow(self);
end

function StoryBaseView:InternalOnViewHide()
	mSoundManager:PlaySound(self.mCurLoopSoundID);

	mSuper.InternalOnViewHide(self);
end

function StoryBaseView:PlaySoundName(value)
	local len = string.len(value);

	--value值“0”，代表重置为开始剧情前的背景音乐
	if len == 1 then
		mSoundManager:PlaySound(self.mCurLoopSoundID);
	elseif len > 1 then
		mSoundManager:PlaySoundName(value);
	end
end

return StoryBaseView;