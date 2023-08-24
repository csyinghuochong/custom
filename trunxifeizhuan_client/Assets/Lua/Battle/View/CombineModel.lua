local LuaClass = require "Core/LuaClass"
local CommonModel = require "Battle/View/CommonModel"
local CombineModel = LuaClass("CombineModel",CommonModel);
local UnityEngine = UnityEngine;
local TransformType = typeof(UnityEngine.Transform);
local CombineInstance = UnityEngine.CombineInstance;
local mFashionAssetManager = require"Module/Fashion/FashionAssetManager"
local mCombineAssets = require"Battle/Manager/CombineAssets"
local table = table;
local pairs = pairs;
local ipairs = ipairs;
local PoolManager = require "Common/PoolManager"
local mMaterialPool = PoolManager.mMaterialPool;
local mGameModelManager = require "Manager/GameModelManager"

function CombineModel:InitModel(model)
	self.mComponents = {};
	self.mSex = model.mSex;
	self.mFace = model.mFace;
	self.mFashions = model.mFashions;
end

function CombineModel:InitGameObject(go)
	
	local bonesMap = {};
	local transforms = go:GetComponentsInChildren(TransformType,true);

	local len = transforms.Length;
	local childTrans = nil;
	if len > 0 then
		for i = 0, len - 1 do
			childTrans = transforms[i];
	        bonesMap[childTrans.name] = childTrans;
	    end
	end

	self.mSkinnedMeshRenderer = self:FindSkinnedMeshRenderer(go);
	self.mBonesMap = bonesMap;
	self:ReplaceSuit(self.mFashions,self.mFace);
end

local mAlphaTexKey = "_MainTexA";
function CombineModel:Combine()

	local smr = self.mSkinnedMeshRenderer;
	if smr then
		local bones = {};
		local materials = {};
		local combineInstances = {};
		local uvsList = {};

		local components = self.mComponents;
		for k,v in pairs(components) do
			self:AddCombineInstances(v.mInfos,combineInstances,bones,materials,uvsList);
		end

		local mainTextures = {};
		local alphaTextures = {};
		local emptyAlphaTextures = {};
		local combineTexture = mCombineAssets:GetCombineTexture();

		local srcMaterial = materials[1];
		if not srcMaterial then
			return;
		end
		
		for i,v in ipairs(materials) do
			local mainTexture = v.mainTexture;
			table.insert(mainTextures,mainTexture);
			local alphaTexture = nil;
			if v:HasProperty(mAlphaTexKey) then
				srcMaterial = v;
				alphaTexture = v:GetTexture(mAlphaTexKey);
			end
			if not alphaTexture then
				alphaTexture = mCombineAssets:GetAlphaTexture(mainTexture.width,mainTexture.height);
				emptyAlphaTextures[alphaTexture] = alphaTexture;
			end
			table.insert(alphaTextures,alphaTexture);
		end

		local rects = combineTexture:PackTextures(mainTextures,0,1024);
		local combineUVs = self:CombineUV(uvsList,rects);
		local material = mCombineAssets:GetCombineMaterial(srcMaterial);
		material.mainTexture = combineTexture;
		if material:HasProperty(mAlphaTexKey) then
			local combineTextureA = mCombineAssets:GetCombineTexture();
			combineTextureA:PackTextures(alphaTextures,0,1024);
			material:SetTexture(mAlphaTexKey,combineTextureA);
		end
		for k,v in pairs(emptyAlphaTextures) do
			mCombineAssets:PutAlphaTexture(v);
		end

		local mesh = mCombineAssets:GetCombineMesh();
		mesh:Clear();
	    mesh:CombineMeshes(combineInstances, true, false);
	    mesh.uv = combineUVs;
	    mesh:RecalculateBounds();
	    mesh:RecalculateNormals();

	    smr.sharedMesh = mesh;
	    smr.bones = bones;
	    smr.material = material;	    

	    self:DisposeAssets();

	    self.mSrcMaterial = srcMaterial;
	    self.mMaterial = material;
	    self.mDefaultMaterial = material;
	    self.mCombineMaterial = material;
	    self.mCombineTexture = combineTexture;
	    self.mCombineTextureA = combineTextureA;
	    self.mCombineMesh = mesh;
	    
	    self.mHaveCombineAssets = true;
	end
end

function Clamp01(value)
	if value < 0 then
		return 0
	elseif value > 1 then
		return 1   
	end
	
	return value
end
function Lerp(from, to, t)
	return from + (to - from) * Clamp01(t)
end

function CombineModel:CombineUV(uvsList,rects)
	local result = {};
	for k,uvs in ipairs(uvsList) do
		local rect = rects[k-1];
		local len = uvs.Length;
		for i = 0,len-1 do
			uv = uvs[i];
			table.insert(result,Vector2.New(Lerp(rect.xMin, rect.xMax, uv.x),Lerp(rect.yMin, rect.yMax, uv.y))); 
		end
	end
	return result;
end

function CombineModel:AddCombineInstances(infos,combineInstances,bones,materials,uvs)

	local bonesMap = self.mBonesMap;
	for k,v in pairs(infos) do
		local mesh = v.mesh;
		local subMeshCombineInstances = v.subMeshCombineInstances;
		local subMeshCount = mesh.subMeshCount - 1;
		for subMeshIndex = 0,subMeshCount do
			local combineInstance = subMeshCombineInstances[subMeshIndex];
			if combineInstance == nil then
				combineInstance = CombineInstance.New();
				combineInstance.mesh = mesh;
				combineInstance.subMeshIndex = subMeshIndex;
				subMeshCombineInstances[subMeshIndex] = combineInstance;
			end
			table.insert(combineInstances,combineInstance);
		end
		table.insert(uvs,v.uv);
		self:AddBones(v,bones,bonesMap);
		self:AddMaterials(v,materials);
	end
end

function CombineModel:AddBones(item,bones,bonesMap)

	for k,v in pairs(item.bones) do
		local bone = bonesMap[v];
		if bone then
			table.insert(bones,bone);
		end
	end
end

function CombineModel:AddMaterials(item,materials)
	for k,v in pairs(item.materials) do
		table.insert(materials,v);
	end
end

function CombineModel:ReplaceSuit(fashions,face)

	
	if not fashions then
		return;
	end

	local components = self.mComponents;
	if components == nil then
		return;
	end

	local count = 4;
	local callback = function (component)
		components[component.mPosition] = component;
		count = count - 1;
		if count == 0 then
			self:Combine();
		end
	end

	if face then
		count = count + 1;
		mFashionAssetManager:LoadFashionAsset(face,callback);
	end

	local sex = self.mSex or 1;
	for i = 1,4 do
		local fashion = fashions[i] or mGameModelManager.FashionModel:GetDefaultFashion(sex,i);
		mFashionAssetManager:LoadFashionAsset(fashion.mConfig,callback);
	end

end

function CombineModel:Replace(fashion)
	local callback = function (component)
		self.mComponents[component.mPosition] = component;
		self:Combine();
	end
	mFashionAssetManager:LoadFashionAsset(fashion.mConfig,callback);
end

function CombineModel:DisposeAssets()
	if self.mHaveCombineAssets then
		mCombineAssets:PutCombineMaterial(self.mCombineMaterial,self.mSrcMaterial);
		mCombineAssets:PutCombineTexture(self.mCombineTexture);
		mCombineAssets:PutCombineTexture(self.mCombineTextureA);
		mCombineAssets:PutCombineMesh(self.mCombineMesh);

		self.mCombineMaterial = nil;
		self.mSrcMaterial = nil;
		self.mCombineTexture = nil;
		self.mCombineTextureA = nil;
		self.mCombineMesh = nil;
		self.mHaveCombineAssets = nil;
	end
end

return CombineModel;