local LuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local LerpRotation = require "Battle/LerpRotation"
local mResourceUrl = require "AssetManager/ResourceUrl"
local ModelView = LuaClass("ModelView",BaseLua);
local mEffectManager = require "Battle/Manager/EffectManager"
local UnityEngine = UnityEngine;
local Vector3 = Vector3;
local Quaternion = Quaternion;
local mUpAxis = Vector3.up;
local mVector3One = Vector3.one;
local mZeroRotation = Quaternion.identity;
local AnimatorType = typeof(UnityEngine.Animator);
local TransformType = typeof(UnityEngine.Transform)
local ColliderType = typeof(UnityEngine.CapsuleCollider);
local Color = Color;
local mDoFileUtil = require "Utils/DoFileUtil";

function ModelView:OnLuaNew(model,loadCallback)
	self.mbShow = false;
	self.mLoadCallback = loadCallback;
	self:SetModel(model);
end

function ModelView:SetModel(model)
	self.mModelRotation = model.mRotation;
	self.mScaleFactor = model.mScale or 1;
	self:CreateModel(model);
end

function ModelView:CreateModel(model)
	if model.mIsCombineModel then
		self.mModel = mDoFileUtil:DoFile("Battle/View/CombineModel").LuaNew(model,self:GetModelPath());
	else
		self.mModel = mDoFileUtil:DoFile("Battle/View/CommonModel").LuaNew(model,self:GetModelPath());
	end
end

function ModelView:GetModelPath()
	return mResourceUrl.GetRolePath("");
end

function ModelView:SetRendererState(rendererState)
	self.mModel:SetRendererState(rendererState);
end

function ModelView:AddModelEffect(config)

	if not config then
		return;
	end

	local effects = self.mModelEffectConfigs;
	if not effects then
		effects = {};
		self.mModelEffectConfigs = effects;
	end

	effects[config] = config;

	if self.mbShow and self.mGameObject then
		self:ShowModelEffect(config);
	end
end

function ModelView:GetSkinnedMeshRender()
	return self.mSkinnedMeshRenderer
end

function ModelView:GetMaterial()
	return self.mModel:GetMaterial();
end

function ModelView:LoadModle()
	self.mModel:Load(function (go)
		self:OnLoadModel(go);
	end);
end

function ModelView:AttachCollider()
	local animator = self.mAnimator;
	if animator then
		local collider = animator:GetComponent(ColliderType);
		if not collider then
			collider = animator.gameObject:AddComponent(ColliderType);
			collider.height = 2;
			collider.radius = 0.5;
			collider.center = mUpAxis*1;
		end
		return collider;
	end
end

function ModelView:OnLoadModel(go)

	local transform = go.transform;
	local animator = go:GetComponentInChildren(AnimatorType);
	local bShow = self.mbShow;
	go:SetActive(bShow);

	self.mGameObject = go;
	self.mTransform = transform;
	self.mAnimator = animator;
	self.mNodesRoot = transform:Find("Nodes");

	self:SetPosition(self.mPosition or transform.position);
	self:SetRotation(self.mRotation or transform.rotation);
	self:SetScale(self.mScale or mVector3One*self.mScaleFactor);
	self:SetModelRotation(self.mModelRotation or mZeroRotation);
	self:SetModelScale(self.mModelScale or mVector3One);
	self.mNodes = {};
	
	if bShow then
		self:ShowModelEffects();
	end

	self:SetSortingOrder(self.mSortingOrder or 0);
	self:SetLayer(self.mLayer or 0);
	self:SetColor(self.mColor);

	local loadCallback = self.mLoadCallback;
	if loadCallback then
		loadCallback(go);
	end
end

function ModelView:ShowModelEffect(config)

	local effects = self.mModelEffects;
	if not effects then
		effects = {};
		self.mModelEffects = effects;
	end

	local effect = effects[config];
	if not effect then
		effect = mEffectManager:GetEffect(config);
		effect.mNeverExit = true;
		effects[config] = effect;
	end

	mEffectManager:ShowEffect(effect,self);

end

function ModelView:ShowModelEffects()
	local effects = self.mModelEffectConfigs;
	if effects then
		for k,v in pairs(effects) do
			self:ShowModelEffect(v);
		end
	end
end

function ModelView:DisposeModelEffects()
	local effects = self.mModelEffects;
	if effects then
		for k,v in pairs(effects) do
			mEffectManager:HideEffect(v);
		end
		self.mModelEffects = nil;
	end
end

function ModelView:ResetGameObject(go)
end

function ModelView:DisposeModel()
	self:ResetGameObject(self.mGameObject);
	self.mGameObject = nil;
	self.mTransform = nil;
	self.mAnimator = nil;
	self.mNodes = nil;
	self.mModel:Dispose();
end

function ModelView:Dispose()
	self:DisposeModel();
	self:DisposeModelEffects();
	self:ClearData( );
end

function ModelView:ClearData()
	self.mbShow = false;
	self.mColor = nil;
	self.mSortingOrder = nil;
	self.mLayer = nil;
	self.mModelEffects = nil;
	self.mModelEffectConfigs = nil;
end

function ModelView:ShowView()
	if self.mbShow == false then
		self.mbShow = true;
		local go = self.mGameObject;
		if go then
			go:SetActive(true);
			self:ShowModelEffects();
		else
			self:LoadModle();
		end
	end
end


function ModelView:HideView()
	if self.mbShow then
		self.mbShow = false;
		local go = self.mGameObject;
		if go then
			go:SetActive(false);
		end
		self:DisposeModelEffects();
	end
end

function ModelView:PlayAnimation(state)
	local animator = self.mAnimator;
	if animator and state and state ~= "" and state ~= "0" then
		animator:CrossFade(state,0,0,0);
	end
end

function ModelView:SetPosition(position)

	self.mPosition = position;
	local transform = self.mTransform;
	if transform then
		transform.position = position;
	end
end

function ModelView:SetRotation(rotation)
	self.mRotation = rotation;
	local transform = self.mTransform;
	if transform then
		transform.rotation = rotation;
	end
end

function ModelView:SetModelRotation(rotation)
	local animator = self.mAnimator;
	if animator then
		animator.transform.localRotation = rotation;
	end
	local nodesRoot = self.mNodesRoot;
	if nodesRoot then
		nodesRoot.localRotation = rotation;
	end
	self.mModelRotation = rotation;
end

function ModelView:SetModelScale(scale)
	local animator = self.mAnimator;
	if animator then
		animator.transform.localScale = scale;
	end
	local nodesRoot = self.mNodesRoot;
	if nodesRoot then
		nodesRoot.localScale = scale;
	end
	self.mModelScale = scale;
end

local mColorKey = "_Color";
function ModelView:SetColor(col)
	col = col or Color.white;
	self.mColor = col;
	local material = self:GetMaterial();
	if material then
		if material:HasProperty(mColorKey) then
			material:SetColor(mColorKey,col);
		end
	end
end

function ModelView:SetLayer(layer)
	self.mLayer = layer;
	local smr = self:GetSkinnedMeshRender();
	if smr then
		smr.gameObject.layer = layer;
	end
end
function ModelView:SetSortingOrder(sortingOrder)
	self.mSortingOrder = sortingOrder;
	local smr = self:GetSkinnedMeshRender();
	if smr then
		smr.sortingOrder = sortingOrder;
	end
end

function ModelView:SetScale(scale)
	self.mScale = scale;
	local transform = self.mTransform;
	if transform then
		transform.localScale = scale;
	end
end
local mHpPoint = "Bip001 Head";
local mHpPointOffset = mUpAxis * 0.8;

function ModelView:GetHPPoint()
	local point = self:FindNode(mHpPoint);
	if point then
		return point.position + mHpPointOffset;
	end

	return self.mPosition + mUpAxis*2;
end

function ModelView:Find(childName)
	local transform = self.mTransform;
	if not transform then
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

function ModelView:FindNode(childName)
	local nodes = self.mNodes;
	if not nodes then
		return nil;
	end

	local node = nodes[childName];
	if not node then
		node = self:Find(childName);
		nodes[childName] = node;
	end
	return node;
end

function ModelView:LerpToRotation(rotation,duration)

	local lerpRotation = self.mLerpRotation;
	if not lerpRotation then
		lerpRotation = LerpRotation.LuaNew();
		self.mLerpRotation = lerpRotation;
	end
	local transform = self.mTransform;
	if transform then
		lerpRotation:LerpTo(transform,rotation,duration);
	end
end

function ModelView:ToogleSwimState(flag)
	local animator = self.mAnimator;
	if animator then
		animator:SetBool("Swim",flag);
	end
end

function ModelView:ReplaceSuit(fashions)
	self.mModel:ReplaceSuit(fashions);
end

function ModelView:Replace(fashion)
	self.mModel:Replace(fashion);
end

return ModelView;