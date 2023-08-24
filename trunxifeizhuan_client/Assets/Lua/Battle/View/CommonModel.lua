local LuaClass = require "Core/LuaClass"
local CommonModel = LuaClass("CommonModel");
local mGameObjectPool = require "AssetManager/GameObjectPool"
local mCombineAssets = require"Battle/Manager/CombineAssets"
local UnityEngine = UnityEngine;
local SkinnedMeshRendererType = typeof(UnityEngine.SkinnedMeshRenderer);

function CommonModel:OnLuaNew(model,path)
	self.mModelFile = model.mFile;
	self.mModelPath = path;
	self:InitModel(model);
end

function CommonModel:InitModel(model)
end

function CommonModel:InitGameObject(go)
	local renderer = self:FindSkinnedMeshRenderer(go);
	local material = renderer.material;
	self.mMaterial = material;
	self.mDefaultMaterial = material;
	self.mSkinnedMeshRenderer = renderer;
end

function CommonModel:GetRendererStateMaterial(rendererState)
	-- body
end

function CommonModel:SetRendererState(rendererState)
	-- body
	self.mRendererState = rendererState;
end

function CommonModel:FindSkinnedMeshRenderer(go)
	return go:GetComponentInChildren(SkinnedMeshRendererType);
end

function CommonModel:ReplaceSuit(fashions,face)
end

function CommonModel:Replace(fashion)
end

function CommonModel:DisposeAssets()
end

function CommonModel:Dispose()
	local go = self.mGameObject;
	if go then
		self:PutGameObject(go);
		self:SetRendererState(0);
		self.mGameObject = nil;
		self.mSkinnedMeshRenderer = nil;
	end

	self.mLoadRequest = nil;
	self.mMaterial = nil;
	self.mDefaultMaterial = nil;

	self:DisposeAssets();
end

function CommonModel:GetSkinnedMeshRender()
	return self.mSkinnedMeshRenderer;
end

function CommonModel:GetMaterial()
	return self.mMaterial;
end

function CommonModel:PutGameObject(go)
	go:SetActive(false);
	mGameObjectPool:PutExternal(self.mModelPath,self.mModelFile,go);
end

function CommonModel:OnLoadCompleted(go)
	if not self.mLoadRequest then
		self:PutGameObject(go);
		return;
	end
	self.mGameObject = go;
	self:InitGameObject(go);
	self:SetRendererState(self.mRendererState or 0);
	local loadCallback = self.mLoadCallback;
	if loadCallback then
		loadCallback(go);
		self.mLoadCallback = nil;
	end
end

function CommonModel:Load(loadCallback)
	local file = self.mModelFile;
	if not file or file == "" then
		return;
	end

	if not self.mLoadRequest then
		self.mLoadRequest = true;
		self.mLoadCallback = loadCallback;
		mGameObjectPool:GetExternal(self.mModelPath,file,function (go) self:OnLoadCompleted(go) end);
	end
end

return CommonModel;