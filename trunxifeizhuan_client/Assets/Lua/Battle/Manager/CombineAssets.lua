local LuaClass = require "Core/LuaClass";
local CombineAssets = LuaClass("CombineAssets");
local ObjectPool = require "Common/ObjectPool";
local UnityEngine = UnityEngine;
local Texture2D = UnityEngine.Texture2D;
local Mesh = UnityEngine.Mesh;
local Material = UnityEngine.Material;
local Shader = UnityEngine.Shader;
local mWhite = Color.white;
local string = string;

local function CreateCombineTexture(config)
	return Texture2D.New(0,0);
end

local function CreateAlphaTexture(config)
	local size = string.split(config,"*");
	local tex = Texture2D.New(tonumber(size[1]),tonumber(size[2]));
	local colors = tex:GetPixels();
	local len = colors.Length;
	for i=0,len-1 do
		colors[i] = mWhite;
	end
	tex:SetPixels(colors);

	return tex;
end

local function CreateCombineMesh()
	return Mesh.New();
end

local function CreateCombineMaterial(src)
	return Material.New(src);
end

local function ClearMaterial(mtl)
	Material.DestroyImmediate(mtl,true);
end

local function ClearMesh(object)
	Mesh.DestroyImmediate(object,true);
end 

local function ClearTexture(object)
	Texture2D.DestroyImmediate(object,true);
end

local function CreateMaterial(shaderName)
	return Material.New(Shader.Find(shaderName));
end

function CombineAssets:OnLuaNew()
	self.mCombineTexturePool = ObjectPool.LuaNew(CreateCombineTexture,nil,ClearTexture);
	self.mAlphaTexturePool = ObjectPool.LuaNew(CreateAlphaTexture,nil,ClearTexture);
	self.mCombineMeshPool = ObjectPool.LuaNew(CreateCombineMesh,nil,ClearMesh);
	self.mCombineMaterialPool = ObjectPool.LuaNew(CreateCombineMaterial,nil,ClearMaterial);
	self.mMaterialPool = ObjectPool.LuaNew(CreateMaterial,nil,ClearMaterial);
end

function CombineAssets:GetCombineMesh()
	return self.mCombineMeshPool:Get();
end

function CombineAssets:PutCombineMesh(mesh)
	return self.mCombineMeshPool:Put(mesh);
end
function CombineAssets:GetCombineTexture()
	return self.mCombineTexturePool:Get();
end

function CombineAssets:PutCombineTexture(texture)
	self.mCombineTexturePool:Put(texture);
end

function CombineAssets:GetAlphaTexture(w,h)
	return self.mAlphaTexturePool:Get(w.."*"..h);
end

function CombineAssets:PutAlphaTexture(texture)
	self.mAlphaTexturePool:Put(texture,texture.width.."*"..texture.height);
end

function CombineAssets:GetCombineMaterial(src)
	return self.mCombineMaterialPool:Get(src);
end

function CombineAssets:PutCombineMaterial(material,src)
	self.mCombineMaterialPool:Put(material,src);
end

function CombineAssets:GetMaterial(shaderName)
	return self.mMaterialPool:Get(shaderName);
end

function CombineAssets:PutMaterial(material,shaderName)
	self.mMaterialPool:Put(material,shaderName);
end

function CombineAssets:Dispose()
	self.mCombineTexturePool:ClearPool();
	self.mAlphaTexturePool:ClearPool();
	self.mCombineMeshPool:ClearPool();
	self.mCombineMaterialPool:ClearPool();
	self.mMaterialPool:ClearPool();
end

return CombineAssets.LuaNew();