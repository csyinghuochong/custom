local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local EffectNode = require "Battle/Effect/EffectNode"
local mGameObjectPool = require "AssetManager/GameObjectPool"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mEffectConfigs = require"EffectConfigFile/EffectConfig"
local Effect = LuaClass("Effect",BaseLua);
local UnityEngine = UnityEngine;
local Time = UnityEngine.Time;
local Vector3 = Vector3;
local mVector3One = Vector3.one;
local TransformType = typeof(UnityEngine.Transform);
local TrailRendererType = typeof(UnityEngine.TrailRenderer);
local SkinnedMeshRendererType = typeof(UnityEngine.SkinnedMeshRenderer);
local MotionGhostType = typeof(MotionGhost);

local mEffectPath = mResourceUrl.GetFXPath("");

function Effect:OnLuaNew(config)
	local asset = config.asset;
	self.mConfig = config;
	self.mShow = false;
	self.mActived = false;
	self.mShowTime = 100000;
	self.mStartTime = 100000;
	self.mEffectFile = asset;
	self.mScale = mVector3One;
	self.mDelay = config.delay;
	self.mOnDelay = function ()
		self:OnDelay();
	end

	self.mOnActive = function ()
		self:OnActive();
	end
	self:InitExternalConfigs(mEffectConfigs[asset]);
end

function Effect:Assert(params)
	return true;
end

function Effect:InitExternalConfigs(effectConfig)

	if effectConfig then
		self.mDuration = effectConfig.duration;
		self.mMathNodes = effectConfig.matchNodes;
		self.mMirror = effectConfig.mirror;
		self:OnInitExternalConfigs(effectConfig);
	else
		self.mDuration = 3;
	end
end

function Effect:OnInitExternalConfigs(effectConfig)
end

function Effect:OnDispose()
end

function Effect:PutGameObject(go)
	if go then
		go:SetActive(false);
		mGameObjectPool:PutExternal(mEffectPath,self.mEffectFile,go);
	end
	self.mGameObject = nil;
end

function Effect:Dispose()

	self:PutGameObject(self.mGameObject);
	self.mTransform = nil;
	self.mTrailRenderers = nil;
	self.mNodes = nil;
	self.mLoadRequest = nil;
	self.mBindTransform = nil;
	self.mNeverExit = nil;
	self.mShow = false;
	self.mActived = false;
	self:OnDispose();
end

function Effect:LoadEffect()
	local file = self.mEffectFile;
	if not file or file == "" then
		return;
	end
	if not self.mLoadRequest then
		self.mLoadRequest = true;
		mGameObjectPool:GetExternal(mEffectPath,file,function(go) self:LoadEffectCompleted(go); end);
	end
end

function Effect:LoadEffectCompleted(go)
	if not self.mLoadRequest then
		self:PutGameObject(go);
		return;
	end
	local show = self.mShow;
	local transform = go.transform;
	transform.localScale = self.mScale;

	self.mGameObject = go;
	self.mTransform = transform;
	self:InitNodes(transform);
	self:InitTrails(transform);
	self:OnLoadEffectCompleted(go);
	go:SetActive(show);
	if show then
		self.mStatus = self.mOnActive;
		self:OnShow();
		self:ClearTrails();
	end
end

function Effect:InitMotionGhost()
	local bindTransform = self.mBindTransform;
	if not bindTransform then
		return;
	end
	local skinnedMeshRenderer = bindTransform:GetComponentInChildren(SkinnedMeshRendererType);
	local ghost = self.mGameObject:GetComponentInChildren(MotionGhostType);
	if ghost and skinnedMeshRenderer then
		ghost:SetRealTimeRenderer(skinnedMeshRenderer);
		ghost:SetTarget(bindTransform);
	end

	return ghost;
end

function Effect:InitTrails(transform)
	self.mTrailRenderers = transform:GetComponentsInChildren(TrailRendererType,true);
end

function Effect:ClearTrails()
	local trails = self.mTrailRenderers;
	if not trails then
		return;
	end

	local len = trails.Length;
	if len > 0 then
		for i = 0, len - 1 do
	        local trail = trails[i];
	        if trail then
	        	trail:Clear();
	        end
	    end
	end
end

function Effect:FindChild(transform,childName)

	if not transform or not childName then
		return nil;
	end
	local children = transform:GetComponentsInChildren(TransformType,true);
	local len = children.Length;
	if len > 0 then
		for i = 0, len - 1 do
	        local child = children[i];
	        if child.name == childName then
	        	return child;
	        end
	    end
	end

	return nil;
end

function Effect:InitNodes(transform)

	local mathNodes = self.mMathNodes;

	if not mathNodes then
		return;
	end

	local bindTransform = self.mBindTransform;
	if not bindTransform then
		return;
	end

	local nodes = {}
	for i,v in ipairs(mathNodes) do
		local child = self:FindChild(transform,v);
		local target = self:FindChild(bindTransform,v);
		if child then
			nodes[v] = EffectNode.LuaNew(child,target);
		end
	end

	self.mNodes = nodes;
end

function Effect:BindNodes()

	local bindTransform = self.mBindTransform;
	if not bindTransform then
		return;
	end

	local nodes = self.mNodes;
	if nodes then
		for k,v in pairs(nodes) do
			v:Bind(self:FindChild(bindTransform,v.mName));
		end
	end
end

function Effect:UpdateNodes()

	local nodes = self.mNodes;
	if nodes then
		for k,v in pairs(nodes) do
			v:Update();
		end
	end

end

function Effect:OnLoadEffectCompleted(go)
end

function Effect:OnShow()
	self:OnActive();
end

function Effect:CheckExit()
	return self.mActived and Time.time - self.mShowTime > self.mDuration;
end

function Effect:OnUpdate()
	local bindTransform = self.mBindTransform;
	if bindTransform then
		self:SetLocation(bindTransform.position,bindTransform.rotation);
	end
end

function Effect:SetLocation(position,rotation)
	self.mPosition = position;
	self.mRotation = rotation;
	local transform = self.mTransform;
	if transform then
		transform.position = position;
		transform.rotation = rotation;
	end
end

function Effect:OnDelay()
	if Time.time - self.mStartTime > self.mDelay then
		self.mActived = true;
		self.mStatus = self.mOnActive;
		self:ShowView();
	end
end

function Effect:OnActive()
	self:OnUpdate();
	self:UpdateNodes();
end

function Effect:Update()
	local status = self.mStatus;
	if status then
		status();
	end
end

function Effect:SetBindTransform(transform)
	self.mBindTransform = transform;
	self:BindNodes();
	self:OnUpdate();
end

function Effect:UpdateParams(logicParams)
	-- body
end

function Effect:Show(logicParams)
	self.mStartTime = Time.time;
	self.mActived = false;
	self.mStatus = self.mOnDelay;
	self:UpdateParams(logicParams);
	self:SetBindTransform(logicParams.mTransform);
end

function Effect:ShowView()
	self.mShowTime = Time.time;
	if self.mShow == false then
		self.mShow = true;
		local go = self.mGameObject;
		if go then
			go:SetActive(true);
			self:OnShow();
			self:ClearTrails();
		else
			self:LoadEffect();
		end
	end
end

return Effect;