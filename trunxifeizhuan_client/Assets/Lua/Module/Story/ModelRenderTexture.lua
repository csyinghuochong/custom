local mBaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mDoFileUtil = require "Utils/DoFileUtil";
local mPoolManager = require "Common/PoolManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local ModelRenderTexture = mLuaClass("ModelRenderTexture", mBaseLua);
local mEffectManager = require "Battle/Manager/EffectManager"
local mRenderTexturePool = mPoolManager.mRenderTexturePool;
local mCommonEffects = mEffectManager.mCommonEffects;
local mGameUIDragListener = GameUIDragListener;
local ImageType = typeof(UnityEngine.UI.Image);
local GameObject = UnityEngine.GameObject;
local Application = UnityEngine.Application;
local mIsEditor = Application.isEditor;
local Quaternion = Quaternion;
local mVector3 = Vector3;
local mVector2 = Vector2;
local mColor = Color;

function ModelRenderTexture:OnLuaNew(parent,rotate,touchSizeX,touchSizeY)
	self:InitTextureParams( parent,rotate,touchSizeX,touchSizeY );
	self:LoadTextureRoot(  );
end

function ModelRenderTexture:InitTextureParams( parent,rotate,touchSizeX,touchSizeY )
	self.mIsRotateModel = rotate;
	self.mParent = parent;
	self.mParentGameObject = parent.gameObject;
	self.mTouchSizeX = touchSizeX;
	self.mTouchSizeY = touchSizeY;

	self.mLadedModelComplete = function ( go )
		self:InternalLoadedModel ( go );
	end
	local image_textrue = parent:GetComponent( 'RawImage' )
	image_textrue.color = mColor.clear;
	self.mImageTexture = image_textrue;
end

function ModelRenderTexture:LoadTextureRoot(  )
	local loadTextureComplete = function ( go )
		self:LoadTextureComplete( go )
	end
	mUIManager:LoadView("ui/view_root/","render_texture_root", loadTextureComplete);
end

local offsetX = 0;
function ModelRenderTexture:LoadTextureComplete( go )
	self.mGameObject = go;
	go.DontDestroyOnLoad(go);
	local transform = go.transform;
	transform.localPosition = mVector3.New(offsetX,20,0);
	offsetX = offsetX + 20;
	self.mModelNode = transform:Find('model');
	self.mRootTrans = transform;
	self.mRotation = 0;

	local image = self.mImageTexture;
	image.color = mColor.white;

	self.mCamera = transform:Find('3DCamera'):GetComponent('Camera');
	self:UpdateCameraTargetTexture();

	self:RotateSetting();

	local rotate_y = self.mDirectionY;
	if rotate_y then
		self:SetDirectionY( rotate_y );
	end

	if self.mIsShow ~= nil then
		go:SetActive(self.mIsShow);
	end
end

function ModelRenderTexture:RotateSetting()
	if self.mIsRotateModel then

		local mTouchRegion = GameObject.New("Touch");
		local mTouchRegionTransform = mTouchRegion.transform;
		mTouchRegionTransform:SetParent(self.mParent.transform);
		mTouchRegionTransform.localPosition = mVector3.zero;
		mTouchRegionTransform.localScale = mVector3.one;

		local image = mTouchRegion:AddComponent(ImageType);
		image.raycastTarget = self.mIsRotateModel;
		image.color = mColor.New(1,1,1,0)

		if self.mTouchSizeX ~= nil and self.mTouchSizeY ~= nil then
			image.rectTransform.sizeDelta = mVector2.New(self.mTouchSizeX,self.mTouchSizeY);
		else
			image.rectTransform.sizeDelta = mVector2.New(300,600);
		end

		local listener = mGameUIDragListener.Get(mTouchRegion);
		listener.onDrag = function(arg1,arg2,arg3) self:RotateModelY(arg2);end	
	end
end

function ModelRenderTexture:SetColor( color )
	local image = self.mImageTexture;
	image.color = color;
end

function ModelRenderTexture:SetShadow( shadow )
	self.mShadow = shadow and mCommonEffects.mShadow or nil;
	local modelView = self.mModelView;
	if modelView and self.mShadow then
		modelView:AddModelEffect( self.mShadow )
	end
end

function ModelRenderTexture:UpdateNpcAction( state )
	local modelView = self.mModelView;
	if modelView ~= nil then
		modelView:PlayAnimation( state );
	end
end

function ModelRenderTexture:InternalLoadedModel( go )
	local transform = go.transform;
	mGameObjectUtil:SetParent( transform,  self.mModelNode);
	transform.localRotation = Quaternion.Euler(0, 0,0);
end
 
function ModelRenderTexture:OnUpdateUI( bustIcon)
	local model = {};
	model.mFile = bustIcon;
	self:TransformPath( model );
	self:OnUpdateModel( model, false);
end

function ModelRenderTexture:OnUpdateVO( vo )
	if vo:IsLead() then
		self:OnUpdateLead( vo:GetSex( ) , vo:GetEquipedFashions( ) );
	else
		self:OnUpdateFollower( vo );
	end
end

function ModelRenderTexture:OnUpdateFollower( vo )
	local model = vo:GetUIModelVO( );
	self:TransformPath( model );
	self:OnUpdateModel(model ,  false );
end

function ModelRenderTexture:OnUpdateLead(sex ,fashions)
	local modelVO = require "Module/Follower/Follower3DModelVO";
	local model = modelVO:GetLeadModelVO( sex == 1 and 'zj_nanxing' or 'zj_nvxing' , sex ,fashions)
	self:TransformPath( model );
	self:OnUpdateModel( model, true );
end

function ModelRenderTexture:TransformPath( model )
	local model_path = string.format( 'ui_%s', model.mFile );
	model.mFile = model_path;
	model.mUIRole = true;
end

function ModelRenderTexture:OnUpdateModel( model, lead )
	self.mModel = model;
	self.mLead = lead;

	self:CheckCreateModel();
end

function ModelRenderTexture:CheckCreateModel()
	if not self.mIsShow then
		return;
	end

	local model = self.mModel;
	if model and self.mCurModelFile ~= model.mFile then
		--print("CheckCreateModel:",model,self.mCurModelFile);
		self:DisposeModel();
		local modelView = mDoFileUtil:DoFile("Battle/View/UIModelView").LuaNew(model, self.mLadedModelComplete);
		modelView:ShowView();
		self.mModelView = modelView;
		self.mCurModelFile = model.mFile;
	end
	
	if self.mIsRotateModel then
		self:ResetRotate();
	end
end

function ModelRenderTexture:SetGoActive(visible)
	local go = self.mGameObject;
	if go then
		go:SetActive(visible);
	end

	self.mParentGameObject:SetActive(visible);
end

function ModelRenderTexture:ShowView()
	if self.mIsShow then
		return;
	end

	self.mIsShow = true;
	self:SetGoActive(true);
	self:CheckCreateModel();
	self:SetRenderTextureVisible(true);
end

function ModelRenderTexture:HideView()
	if self.mIsShow == false then
		return;
	end

	self.mIsShow = false;
	self:SetGoActive(false);
	self:SetRenderTextureVisible(false);
end

function ModelRenderTexture:Dispose()
	self:HideView();
	self:DisposeModel();

	self.mModel = nil;
	self.mCurModelFile = nil;

	GameObject.DestroyImmediate(self.mGameObject);
end

function ModelRenderTexture:DisposeModel()
	local modelView = self.mModelView;
	if modelView ~= nil then
		modelView:Dispose();
	end
	self.mModelView = nil;
end

function ModelRenderTexture:SetRenderTextureVisible(value)
	if value then
		if self.mRenderTexture then
			return;
		end

		self.mRenderTexture = mRenderTexturePool:Get();
		self:UpdateCameraTargetTexture();
	else
		local rt = self.mRenderTexture;
		if rt then
			mRenderTexturePool:Put(rt);
			self.mRenderTexture = nil;
			self:UpdateCameraTargetTexture();
		end
	end
end

function ModelRenderTexture:UpdateCameraTargetTexture()
	local rt = self.mRenderTexture;
	local camera = self.mCamera;

	if camera then
		camera.targetTexture = rt;
		self.mImageTexture.texture = rt;
	end
end

function ModelRenderTexture:Replace(fashion)
   self.mModelView:Replace(fashion);
end

function ModelRenderTexture:ReplaceSuit(fashions)
	self.mModelView:ReplaceSuit(fashions);
end

function ModelRenderTexture:ResetRotate()
	self.mRotation = 0;
	self:RotateModelY(0);
end

function ModelRenderTexture:SetDirectionY( rotate_y )
	self.mDirectionY = rotate_y;
	local transform = self.mModelNode;
	if transform ~= nil then
		transform.localRotation = Quaternion.Euler(0, rotate_y, 0)
	end
end

function ModelRenderTexture:RotateModelY(pos_y)
	local transform = self.mModelNode;
	if transform ~= nil and pos_y ~= nil then
		self.mRotation = self.mRotation-pos_y;
		transform.localRotation = Quaternion.Euler(0, self.mRotation, 0)
	end
end
return ModelRenderTexture;