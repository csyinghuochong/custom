local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mEventEnum = require "Enum/EventEnum"
local mEventDispatcher = require "Events/EventDispatcher"
local mUIManager = require "Manager/UIManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local CameraMask = require"Battle/Camera/CameraMask"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mAssetManager = require "AssetManager/AssetManager"
local SceneMapView = require "Module/SceneMap/SceneMapView"
local CameraController = mLuaClass("CameraController",mBaseLua);
local UnityEngine = UnityEngine;
local mPlayMode = UnityEngine.PlayMode.StopAll;
local Vector3 = Vector3;
local Screen = UnityEngine.Screen;
local m3DBattlePanel = nil;
m3DBattleLayer = nil;
mSceneRoot = nil;
mMapRoot = nil;

function CameraController:OnLuaNew()
	self:AddEventListeners();
end

function CameraController:AddEventListeners()
	mEventDispatcher:AddEventListener(mEventEnum.TOGGLE_SCREEN_BLACK,function (value)
		self:ToggleScrennBlack(value);
	end);
	mEventDispatcher:AddEventListener(mEventEnum.SHAKE_CAMERA,function (value)
		self:Shake(value);
	end);
end

function CameraController:Init()
	if self.mUpdateShake then
		return;
	end
	
	self.mUpdateShake = function ()
		self:UpdateShake();
	end
	local loadSceneRoot = function( go )
	    self:LoadedSceneRoot(go);
	end
	mUIManager:LoadView("ui/view_root/","3d_view_root",loadSceneRoot);
end

function CameraController:LoadedSceneRoot(go)
	
	
	local camera = UnityEngine.Camera.main;
	local animTransform = camera.transform.parent or camera.transform;
	self.mAnimation = animTransform:GetComponent(typeof(UnityEngine.Animation));
	self.mCamera = camera;
	self.mCameraMask = CameraMask.LuaNew(camera:GetComponentInChildren(typeof(UnityEngine.Renderer)).material);
	self.mSceneRoot = go;
	mSceneRoot = go.transform;
	mMapRoot = mSceneRoot:Find("3DCanvas/MapRoot");
	mGameObjectUtil:RestRectTransform(mMapRoot);

	go:SetActive(false);
	go.DontDestroyOnLoad(go);
	--local canvas = mSceneRoot:Find("3DCanvas")
	m3DBattlePanel = mUIManager:CreateLayer(mMapRoot,"m3DBattlePanel");
	self:ResetLayer(m3DBattlePanel);
	m3DBattleLayer = mUIManager:AddCanvas(mUIManager:CreateLayer(m3DBattlePanel,"m3DBattleLayer"));
	self:ResetLayer(m3DBattleLayer);

	self.mSceneMap = SceneMapView.LuaNew(mMapRoot);
	--self:OnEnterBattleScene();
	self:SetParamsByScene();
end

function CameraController:ResetLayer(transform)
	transform.localPosition = Vector3.zero;
	transform.localEulerAngles = Vector3.zero;
	transform.localScale = Vector3.one;
	transform.gameObject.layer = 8;--3dUI
end

function CameraController:GetAnimation()
	return self.mAnimation;
end

function CameraController:GetCamera()
	return self.mCamera;
end

function CameraController:SetCameraRotation( angles )
	local camera = self:GetCamera();
	if camera == nil then
		return;
	end
	camera.transform.eulerAngles = angles;
end

function CameraController:SetParamsByScene()
	local camera = self:GetCamera();
	if camera == nil then
		return;
	end

	local transform = camera.transform;
	local position = Screen.width/Screen.height > 1.35 and Vector3.New(0,6.1,-0.7) or Vector3.New(0,7.2,-3.5);
	transform.position = position;--Vector3.New(0,6.15,-0.97);
	transform.eulerAngles = Vector3.New(24,0,0);
	camera.fieldOfView = 43;
end

function CameraController:ScreenPointToRay(mousePosition)
	local camera = self:GetCamera();
	return camera:ScreenPointToRay(mousePosition);
end

function CameraController:WorldToScreenPoint(position)
	local camera = self:GetCamera();
	return camera:WorldToScreenPoint(position);
end

function CameraController:ScreenToWorldPoint(screenPosition)
	local camera = self:GetCamera();
	return camera:ScreenToWorldPoint(screenPosition);
end

function CameraController:ToggleScrennBlack(value)
	if value then
		self.mCameraMask:CrossFadeAlpha(0.8,0.5,false);
	else
		self.mCameraMask:CrossFadeAlpha(0,0.5,false);
	end
end

--for test
function CameraController:TestShake()

	local animation = self:GetAnimation();
	if animation then
		if animation.clip then
			animation:CrossFade(animation.clip.name,0,mPlayMode);
			self:AddShakeUpdateBeat(animation.clip.name);
		end
	end

end

function CameraController:AddShakeUpdateBeat(shake)
	
	local lastSake = self.mShakeType;
	if not lastSake then
		self:RecordMapPosition();
		LateUpdateBeat:Add(self.mUpdateShake);
	end
	self.mShakeType = shake;
end

function CameraController:Shake(type)

	local animation = self:GetAnimation();
	if animation then
		if animation:get_Item(type) then
			animation:CrossFade(type,0,mPlayMode);
			self:AddShakeUpdateBeat(type);
		end
	end

end

function CameraController:RecordMapPosition()
	local transform = mMapRoot;
	local screenPosition = Vector3.zero;
	if transform then
		screenPosition = self.mCamera:WorldToScreenPoint(transform.position);
		self.mMapLocalPosition = transform.localPosition;
	end
	self.mMapScreenPoint = screenPosition;
end

function CameraController:ConvertMapPosition()
	local transform = mMapRoot;
	if transform then
		transform.position = self.mCamera:ScreenToWorldPoint(self.mMapScreenPoint);
	end
end

function CameraController:ResetMapPosition()
	local transform = mMapRoot;
	if transform then
		transform.localPosition = self.mMapLocalPosition or transform.localPosition;
	end
end

function CameraController:UpdateShake()
	local shake = self.mShakeType;
	local combat = self.mCombat;
	local animation = self.mAnimation;
	local isShaking = false;

	if animation and shake then
		isShaking = animation:IsPlaying(shake);
	end

	if isShaking then
		self:ConvertMapPosition();
	else
		self.mShakeType = nil;
		self:ResetMapPosition();
		LateUpdateBeat:Remove(self.mUpdateShake);
	end
end

function CameraController:OnEnterBattleScene(params)
	--self:SetParamsByScene(params);

	if self.mSceneRoot then
		self.mSceneRoot:SetActive(true);
	end
end

function CameraController:OnExitBattleScene()
	self.mSceneRoot:SetActive(false);
	self.mSceneMap:Dispose();
end

function CameraController:OnEnterMainScene()
	self:Init();
end

return CameraController.LuaNew();