local mLuaClass = require "Core/LuaClass"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local mEventEnum = require "Enum/EventEnum"
local mSoundConfig = require "ConfigFiles/ConfigSyssound"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mAssetManager = require "AssetManager/AssetManager"
local mAudioGameObject = require "Module/Sound/AudioGameObject"
local mTableInsert = table.insert;
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"
local mPlayerPrefs = UnityEngine.PlayerPrefs;
local SoundManager = mLuaClass("SoundManager",mEventDispatcherInterface);
local mipairs = ipairs;
local MUSIC = 100;
local EFFECT = 100;
function SoundManager:OnLuaNew()
	local GameObject = UnityEngine.GameObject;
	local go = GameObject.New("AudioListener");
	go.DontDestroyOnLoad(go);
	local audioListener = go:AddComponent(typeof(UnityEngine.AudioListener));
	self.mGo = go;

	self.mAudioClips =  {};
	self.mAudioGameObjects = {};

	self:SetSound();
	self.mMusicVolume = mPlayerPrefs.GetInt('Music')/MUSIC;
	self.mSoundEffectVolume = mPlayerPrefs.GetInt('Effect')/EFFECT;

	self:AddEventListener(mEventEnum.PLAY_SOUND,function(soundID)
		self:PlaySound(soundID);
	end);

	self:AddEventListener(mEventEnum.STOP_SOUND,function(soundID)
		self:StopSound(soundID);
	end)

	self:AddEventListener(mEventEnum.ON_ACTOR_DEAD,function(actor)
		--男死亡
		if actor.mActorVo.mSex == 1 then
			self:PlaySound(mSoundConst.js_0004);
		else
			self:PlaySound(mSoundConst.js_0005);
		end
	end)

	self:AddEventListener(mEventEnum.SET_MUSIC,function(value)
		self:SetMusicVolume(value);
	end);

	self:AddEventListener(mEventEnum.SET_SOUND_EFFECT,function(value)
		self:SetSoundEffectVolume(value);
	end);
end

function SoundManager:SetSound()
	if mPlayerPrefs.GetString('IsEverGetSound') == "" then
		mPlayerPrefs.SetInt('Music',MUSIC);
		mPlayerPrefs.SetInt('Effect',EFFECT);
		mPlayerPrefs.SetString('IsEverGetSound','Yes');
	end
end

function SoundManager:SetMusicVolume(value)
	self.mMusicVolume = value;
	self:SetVolume();
end

function SoundManager:SetSoundEffectVolume(value)
	self.mSoundEffectVolume = value;
	self:SetVolume();
end

function SoundManager:SetVolume()
	local audioGameObjects = self.mAudioGameObjects;
	for i,v in mipairs(audioGameObjects) do
		v:SetVolume(self);
	end
end

--关闭音乐
function SoundManager:StopSound(id)
	if id == nil then
		return;
	end
	
	local soundGo = self:GetSoundGameObject(id);

	if soundGo ~= nil then
		soundGo:StopSound();
	end
end

function SoundManager:GetSoundGameObject(id)
	local audioGameObjects = self.mAudioGameObjects;

	for i,v in mipairs(audioGameObjects) do
		if v.mIsPlaying and v.mSoundID == id then
			return v;
		end
	end

	return nil;
end

function SoundManager:PlaySound(id)
	local soundConfig = mSoundConfig[id];

	if soundConfig == nil then
		error("PlaySound error:" ,id);
		return;
	end
	
	if soundConfig.loop ~= 0 then
		--循环音乐不重复播放
		if self:GetSoundGameObject(id) ~= nil then
			return;
		else
			self:StopSound(self.mCurLoopSoundID);
			self.mCurLoopSoundID = id;
		end
	end

	--print(debug.traceback("===============PlaySound:" .. soundConfig.name));

	local audioClips = self.mAudioClips;
	local audioClip = audioClips[id]
	if audioClip then
		self:PlayAudioClip(soundConfig,audioClip);
	else
		mAssetManager.LoadAudioClip(mResourceUrl.GetSoundPath(), soundConfig.name,function(audioClipAsset)
			if audioClips[id] == nil then
				audioClips[id] = audioClipAsset;
				self:PlayAudioClip(soundConfig,audioClipAsset);
			end
		end);
	end
end

function SoundManager:PlaySoundName(string)
	self:PlaySound(mSoundConst[string]);
end

--hitInfo.hit = true(普通) false(偏差)
--hitInfo.crit = ture(暴击) 
--hitInfo.restrain = true(强击)
function SoundManager:PlayHitEffectSound(hitInfo)
	if hitInfo.crit then
		self:PlaySound(mSoundConst.js_0003);
		return;
	end

	if hitInfo.restrain then
		self:PlaySound(mSoundConst.js_0002);
		return;
	end

	if hitInfo.hit then
		self:PlaySound(mSoundConst.js_0001);
	else
		self:PlaySound(mSoundConst.js_0000);
	end
end

function SoundManager:PlayAudioClip(soundConfig,audioClip)
	local audioGameObject = self:GetAudioGameObject();
	audioGameObject:PlaySound(soundConfig,audioClip,self);
end

function SoundManager:GetAudioGameObject()
	local audioGameObjects = self.mAudioGameObjects;

	for i,v in mipairs(audioGameObjects) do
		if v.mIsPlaying == false then
			return v;
		end
	end

	local obj = mAudioGameObject.LuaNew();
	mTableInsert(audioGameObjects,obj);
	return obj;
end

return SoundManager.LuaNew();