local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mGameTimer = require "Core/Timer/GameTimer"
local GameObject = UnityEngine.GameObject;
local AudioSource = typeof(UnityEngine.AudioSource)
local AudioGameObject = mLuaClass("AudioGameObject",mBaseLua);

function AudioGameObject:OnLuaNew()
	local go = GameObject.New("AudioGameObject");
	go.DontDestroyOnLoad(go);
	self.mGo = go;

	local audioSource = go:AddComponent(AudioSource);
	audioSource.playOnAwake = false

	self.mAudioSource = audioSource;
end

function AudioGameObject:PlaySound(soundConfig,audioClip,soundManager)
	self.mSoundID = soundConfig.s_id;
	self.mSoundConfig = soundConfig;
	self.mAudioClip = audioClip;
	self.mIsPlaying = true;

	local loop = soundConfig.loop ~= 0;
	self.mPlayLoop = loop;

	local audioSource = self.mAudioSource;
	self:SetVolume(soundManager);
	audioSource.clip = audioClip;
	audioSource.loop = loop;
	audioSource:Play();
	
	if loop then
		self:PlaySoundLoop();
	else
		self:PlaySoundOnce();
	end
end

function AudioGameObject:PlaySoundLoop()

end

function AudioGameObject:PlaySoundOnce()
	self.mGameTimer=mGameTimer.HandSetTimeout(self.mAudioClip.length,function()
		self.mIsPlaying = false;
	end);
end

function AudioGameObject:StopSound()
	local audioSource = self.mAudioSource;
	if audioSource then
		audioSource:Stop();
	end

	local gameTimer = self.mGameTimer;
	if gameTimer ~= nil then
		gameTimer:Dispose();
		self.mGameTimer = nil;
	end

	self.mIsPlaying = false;
end

function AudioGameObject:SetVolume(soundManager)
	if not self.mIsPlaying then
		return;
	end

	if self.mPlayLoop then
		self.mAudioSource.volume = soundManager.mMusicVolume * self.mSoundConfig.volume / 1000;
	else
		self.mAudioSource.volume = soundManager.mSoundEffectVolume * self.mSoundConfig.volume / 1000;
	end
end

return AudioGameObject;