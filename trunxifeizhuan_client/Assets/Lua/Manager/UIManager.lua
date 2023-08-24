local mLuaClass = require "Core/LuaClass"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local mEventEnum = require "Enum/EventEnum"
local mViewEnum = require "Enum/ViewEnum";
local mDoFileUtil = require "Utils/DoFileUtil";
local mQueue = require "Common/Queue";
local mLinkedList = require "Common/LinkedList"
local GameObject = UnityEngine.GameObject;
local RectTransformType = typeof(UnityEngine.RectTransform);
local CanvasType = typeof(UnityEngine.Canvas);
local GraphicRaycasterType = typeof(UnityEngine.UI.GraphicRaycaster);
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mAssetManager = require "AssetManager/AssetManager"
local mVector3 = Vector3;
local mVector2 = Vector2;
local Screen = UnityEngine.Screen;
local ImageType = typeof(UnityEngine.UI.Image);
local mColor = Color;
local UIManager = mLuaClass("UIManager",mEventDispatcherInterface);
local mResourceManager = ResourceManager;
local mViewIndex = 0;
local mRegisterViewInstances = {};
local mCostViewInstances = {};
local mQueueWindowList = mLinkedList.LuaNew();
local Application = UnityEngine.Application;
local mIsEditor = Application.isEditor;

local mLoadFunc = mResourceManager.LoadPrefab;
if mIsEditor == false or GameDebugConfig.loadUIAssetBundle then
	mLoadFunc = mAssetManager.LoadUI;
end

mUICamera = nil;

mViewRootTrans = nil;

local mLoginPanel = nil;
mLoginLayer = nil;
mLoginLayer1 = nil;

local mMainPanel = nil;
mMainSceneLayer = nil;
mMansionLayer = nil;
local mMainSceneLayerGameObject = nil;

mMainLayer = nil;
mFollowerSelectLayer = nil;--只能是随从形象选择界面占用这个层级
mMainLayer1 = nil;
mMainLayer2 = nil;
mMainPop = nil;

local mCommonPanel = nil;--主要用于主界面和战斗界面共用的层级
mCommonChatLayer = nil;
mCommonChatLayer1 = nil;
mCommonStoryLayer = nil;
mCommonPopLayer1 = nil;
mCommonPopLayer2 = nil;

local mBattlePanel = nil;
mBattleLayer = nil;
mBattleLayer1 = nil;
mBattleChatLayer = nil;
mBattlePop = nil;

local mGlobalPanel = nil;
mPopLayer = nil;
mLoadingLayer = nil;
mSceneLoadingLayer = nil;
local mInteractiveLayer = nil;

function UIManager:LoadView(viewPath,viewName,callBack)
	if mIsEditor == true then
		if viewName ~= string.lower(viewName) then
			error(viewName .. " 名字不能包含大写字母")
		end
	end

	mLoadFunc(viewPath,viewName,callBack);
end

function UIManager:Init(initCallBack)
	local callBack = function( go )
		self:LoadViewRootComplete(go);
		initCallBack();
	end
	
	self:LoadView("ui/view_root/","view_root",callBack);
end

function UIManager:GetDeviceHeight()
	local value = self.mDeviceHeight2;

	if value == nil then
		local recv_transform = self.mCanvasTrans:GetComponent('RectTransform');
		self.mDeviceWidth2 = recv_transform.sizeDelta.x;
		self.mDeviceHeight2 = recv_transform.sizeDelta.y;

		value = self.mDeviceHeight2;
	end

	return value
end

function UIManager:GetDeviceWidth()
	local value = self.mDeviceWidth2;

	if value == nil then
		local recv_transform = self.mCanvasTrans:GetComponent('RectTransform');
		self.mDeviceWidth2 = recv_transform.sizeDelta.x;
		self.mDeviceHeight2 = recv_transform.sizeDelta.y;

		value = self.mDeviceWidth2;
	end

	return value
end

function UIManager:LoadViewRootComplete(go)
	go.DontDestroyOnLoad(go);
	local transform = go.transform;
	mViewRootTrans = transform;
	local canvasTrans = transform:Find('Canvas');
	self.mCanvasTrans = canvasTrans;

	local canvasScaler = canvasTrans:GetComponent('CanvasScaler');
	local referenceResolution = canvasScaler.referenceResolution;
	local rate = Screen.width/Screen.height;
	local canvasWidth = referenceResolution.y*rate;
	--2048x1536
	if canvasWidth < referenceResolution.x then
		--canvasScaler.referenceResolution = mVector2.New(referenceResolution.x,referenceResolution.x / rate);
		canvasScaler.matchWidthOrHeight = 0;
		
		self.mScaleFactor = Screen.width / referenceResolution.x;
	else
		self.mScaleFactor = Screen.height / referenceResolution.y;
	end

	local recv_transform = self.mCanvasTrans:GetComponent('RectTransform');
	self.mDeviceWidth = recv_transform.sizeDelta.x;
	self.mDeviceHeight = recv_transform.sizeDelta.y;
	
	self.mLayerSortingOrderList = {};
	self.mLayerSortingOrder = 1;
	self.mLayerPosZ = 0;

	self.mUILayerStatus = {};

	mLoginPanel = self:CreateLayer(canvasTrans,"mLoginPanel");
	mLoginLayer = self:CreateLayer(mLoginPanel,"mLoginLayer",1);
	mLoginLayer1 = self:CreateLayer(mLoginPanel,"mLoginLayer1",1);

	mMainPanel = self:CreateLayer(canvasTrans,"mMainPanel");
	mMainSceneLayer = self:CreateLayer(mMainPanel,"mMainSceneLayer",2);
	mMainSceneLayerGameObject = mMainSceneLayer.gameObject;
	mMansionLayer = self:CreateLayer(mMainPanel,"mMansionLayer",2);

	mMainLayer = self:AddCanvas(self:CreateLayer(mMainPanel,"mMainLayer",2));
	mFollowerSelectLayer = self:AddCanvas(self:MovePosZ(self:CreateLayer(mMainPanel,"mFollowerSelectLayer",2)));
	mMainLayer1 = self:AddCanvas(self:CreateLayer(mMainPanel,"mMainLayer1",2));
	mMainLayer2 = self:AddCanvas(self:CreateLayer(mMainPanel,"mMainLayer2",2));
	mMainPop = self:AddCanvas(self:CreateLayer(mMainPanel,"mMainPop",2));

	mBattlePanel = self:CreateLayer(canvasTrans,"mBattlePanel");
	mBattleLayer = self:AddCanvas(self:CreateLayer(mBattlePanel,"mBattleLayer",1));
	mBattleLayer1 = self:AddCanvas(self:CreateLayer(mBattlePanel,"mBattleLayer1",1));
	mBattleChatLayer = self:AddCanvas(self:CreateLayer(mBattlePanel,"mBattleChatLayer",1));
	-- mBattleChatLayer = self:CreateLayer(mBattlePanel,"mBattleChatLayer",1);
	mBattlePop = self:AddCanvas(self:CreateLayer(mBattlePanel,"mBattlePop",1));

	mCommonPanel = self:CreateLayer(canvasTrans,"mCommonPanel");
	mCommonChatLayer = self:AddCanvas(self:CreateLayer(mCommonPanel,"mCommonChatLayer",1));
	mCommonChatLayer1 = self:AddCanvas(self:CreateLayer(mCommonPanel,"mCommonChatLayer1",1));
	mCommonStoryLayer = self:AddCanvas(self:CreateLayer(mCommonPanel,"mCommonStoryLayer",1));
	mCommonPopLayer1 = self:AddCanvas(self:CreateLayer(mCommonPanel,"mCommonPopLayer1",1));
	mCommonPopLayer2 = self:AddCanvas(self:CreateLayer(mCommonPanel,"mCommonPopLayer2",1));

	mGlobalPanel = self:CreateLayer(canvasTrans,"mGlobalPanel");
	mPopLayer = self:AddCanvas(self:CreateLayer(mGlobalPanel,"mPopLayer"));
	mLoadingLayer = self:AddCanvas(self:CreateLayer(mGlobalPanel,"mLoadingLayer"));
	mSceneLoadingLayer = self:AddCanvas(self:CreateLayer(mGlobalPanel,"mSceneLoadingLayer"));

	self:CreateInteractiveLayer();
	mUICamera = transform:Find("UICamera"):GetComponent(typeof(UnityEngine.Camera));

	self.mShowWindowList = {};
end

function UIManager:CreateInteractiveLayer()
	local layer = self:AddCanvas(self:CreateLayer(mGlobalPanel,"mInteractiveLayer"));
	mInteractiveLayer = layer.gameObject;
	local rectTransform = mInteractiveLayer:GetComponent('RectTransform');
	local image = mInteractiveLayer:AddComponent(ImageType);
	rectTransform.sizeDelta = mVector3.zero;
	image.color = mColor.New(1,1,1,0);
	self:SetGlobalClickEnable(true);
end

function UIManager:SetGlobalClickEnable(value)
	if value == self.mGlobalClickEnable then
		return;
	end

	mInteractiveLayer:SetActive(not value);
	self.mGlobalClickEnable = value;
end

--disposeStatus 0:不释放 1:销毁界面，释放资源 2：不释放，会调用界面的OnChangeScene函数
function UIManager:CreateLayer( transform,panelName,disposeStatus )
	local layer = GameObject.New(panelName);
	layer.layer = 5;--UI
	
	local rectTransfrom = layer:AddComponent(RectTransformType);
	mGameObjectUtil:SetParent(rectTransfrom,transform);
	rectTransfrom.anchorMin = mVector3.zero;
	rectTransfrom.anchorMax = mVector3.one;
	rectTransfrom.sizeDelta = mVector3.zero;

	self.mUILayerStatus[rectTransfrom] = disposeStatus or 0;

	return rectTransfrom;
end

function UIManager:AddCanvas(layer,additionalCanvasShaderChannels)
	local go = layer.gameObject;
	local canvas = go:AddComponent(CanvasType);
	local graphicRayCaster = go:AddComponent(GraphicRaycasterType);

	canvas.overrideSorting = true;
	self.mLayerSortingOrder = self.mLayerSortingOrder + 10;
	canvas.sortingOrder = self.mLayerSortingOrder;

	self.mLayerSortingOrderList[layer] = self.mLayerSortingOrder;

	if additionalCanvasShaderChannels then
		canvas.additionalShaderChannels = additionalCanvasShaderChannels;
	end
	
	return self:MovePosZ(layer);
end

function UIManager:MovePosZ(layer)
	--self.mLayerPosZ = self.mLayerPosZ - 100;
	--layer.localPosition = mVector3.New(0,0,self.mLayerPosZ);
	return layer;
end

function UIManager:GetLayerSortingOrder(layer)
	return self.mLayerSortingOrderList[layer] or 0;
end

function UIManager:HandleMainSceneViewVisible(status)
	self:HandleUI(mViewEnum.MainSceneView,status);
	self:HandleUI(mViewEnum.MainInterfaceView,status,true);
end

function UIManager:ChangePanelVisible(sceneID)
	mLoginPanel.gameObject:SetActive(sceneID == 0);
	mMainPanel.gameObject:SetActive(sceneID == 1);
	mBattlePanel.gameObject:SetActive(sceneID > 1);
end

function UIManager:HandleUIWithParent(parentLayer,viewModule,handleStatus,params)
	local instance = mRegisterViewInstances[viewModule];

	if instance == nil then
		local cls = mDoFileUtil:DoFile(viewModule);
		instance = cls.LuaNew();
		mRegisterViewInstances[viewModule] = instance;

		if not instance.mCheckBaseWindow then
			error(viewModule.."没有继承BaseWindow");
		end
	end

	if handleStatus == 0 then
		if instance.mIsShow then
			instance:HideView(params);
		end
		return;
	elseif handleStatus == 1 then
		if instance.mIsShow then
			return;
		end
	elseif handleStatus == 2 then
		if instance.mIsShow then
			instance:HideView(params);
			return;
		end
	end

	if instance:CheckShow() == false then
		return;
	end

	if parentLayer then
		params = params or {};
		params["changeParentLayer"] = parentLayer;
	else
		parentLayer = instance:GetViewParent();
	end

	local otherShowWindow = nil;
	local sohwWindowList = self.mShowWindowList;
	for window,windowParent in pairs(sohwWindowList) do
		if windowParent == parentLayer then
			otherShowWindow = window;
			break;
		end
	end

	if instance.mGameObject then
		if otherShowWindow then
			otherShowWindow:ExternalForceHideView();
		end
	else
		instance:StartPreloadAsset();
		
		if otherShowWindow then
			instance:InjectParams(nil,{OnLoadViewComplete = function()otherShowWindow:ExternalForceHideView()end});
		end
	end

	instance:ShowView(params);
end

--viewModule:要打开的界面
--handleStatus：0关闭，1打开，2自动（打开的情况下关闭，关闭的情况下打开）
--params：传递给界面的参数，打开界面会调用OnViewShow（params），关闭界面会调用OnViewHide（params）
function UIManager:HandleUI(viewModule,handleStatus,params)
	self:HandleUIWithParent(nil,viewModule,handleStatus,params);
end

--全屏消耗界面
local mMainFullCostViewPath = "Module/MainInterface/MainFullCostView";
function UIManager:HandleFullCostUI(handleStatus,params)
	local viewModule = mMainFullCostViewPath;
	self.mFullCostUIStatus = handleStatus;
	self:HandleCostUI(viewModule,handleStatus,params);
end

--窗口消耗界面
local mMainCostViewPath = "Module/MainInterface/MainCostView";
function UIManager:HandleWindowCostUI(handleStatus,params)
	local viewModule = mMainCostViewPath;

	if self.mFullCostUIStatus == 1 then
		self:Dispatch(mEventEnum.SET_FULL_COST_VIEW_VISIBLE,handleStatus);
	end

	self:HandleCostUI(viewModule,handleStatus,params);
end

function UIManager:HandleCostUI(viewModule,handleStatus,params)
	local instance = mCostViewInstances[viewModule];
	local parentLayer = nil;
	local windows = nil;

	if instance == nil then
		local cls = mDoFileUtil:DoFile(viewModule);
		instance = cls.LuaNew();
		mCostViewInstances[viewModule] = instance;
	end

	if handleStatus == 0 then
		if instance.mIsShow then
			instance:HideView(params);
		end
		return;
	elseif handleStatus == 1 then
		if instance.mIsShow then
			instance:HandleCostParams(params.cost);
			return;
		end
	elseif handleStatus == 2 then
		if instance.mIsShow then
			instance:HideView(params);
			return;
		end
	end

	instance:ShowView(params);
end

function UIManager:DisposeCostUI()
	local viewModule = mMainCostViewPath;
	local instance = mCostViewInstances[viewModule];
	if instance then
		instance:CloseView();
	end

	viewModule = mMainFullCostViewPath;
	instance = mCostViewInstances[viewModule];
	if instance then
		instance:CloseView();
	end
end

function UIManager:CheckDisposeCostUI(isMainCostView,window)
	local viewModule = isMainCostView and mMainCostViewPath or mMainFullCostViewPath;
	instance = mCostViewInstances[viewModule];
	if instance then
		instance:CheckDisposeCostUI(window);
	end
end

function UIManager:OnLayerShow(baseWindow)
	--print("OnLayerShow");

	local curParent = baseWindow:GetViewCurParent();

	self.mShowWindowList[baseWindow] = curParent;

	if curParent == mMainLayer then
		local enum = baseWindow.mViewParams.viewBgEnum;

		mMainSceneLayerGameObject:SetActive(enum ~= nil);
		
	end
end

function UIManager:OnLayerHide(baseWindow)
	--print("OnLayerHide");

	self.mShowWindowList[baseWindow] = nil;

	if baseWindow:GetViewCurParent() == mMainLayer then
		mMainSceneLayerGameObject:SetActive(true);
	end
end

function UIManager:AddQueueWindow(queueWindow)
	--print("AddQueueWindow:",queueWindow.LuaClassName);

	if mQueueWindowList:Contains(queueWindow) then
		while mQueueWindowList.mLast ~= queueWindow do
			mQueueWindowList:RemoveLast();
		end

		return
	end

	mQueueWindowList:AddLast(queueWindow);
end

function UIManager:RemoveQueueWindow(queueWindow)
	--print("RemoveQueueWindow:",queueWindow.LuaClassName);

	mQueueWindowList:Remove(queueWindow);
end

function UIManager:ReturnPrevQueueWindow()
	local lastWindow = mQueueWindowList:RemoveLast();

	if lastWindow then
		--print("ReturnPrevQueueWindow hide:",lastWindow.LuaClassName);

		lastWindow:HideView();
	end

	lastWindow = mQueueWindowList:RemoveLast();
	if lastWindow then
		--print("ReturnPrevQueueWindow show:",lastWindow.LuaClassName);

		if lastWindow.mIsShow then
			self:AddQueueWindow(lastWindow);
		else
			lastWindow:ExternalForceShowView();
		end
		
	end
end

function UIManager:SetCameraClearFlags( flag )
	mUICamera.clearFlags = flag;
end

function UIManager:DisposeUI(forceClose)
	if forceClose then
		self:DisposeCostUI();
	end

	local UILayerStatus = self.mUILayerStatus;

	for k,v in pairs(mRegisterViewInstances) do
		--print("DisposeUI:",k);
		if v.mIsDestory == false  then
			local layerStatus = UILayerStatus[v.mTransform.parent];
			if layerStatus == 1 or forceClose or v:CheckChangeSceneDispose() then
				v:CloseView();
			elseif layerStatus == 2 then
				v:OnChangeScene();
			end
		end
	end
end

local instance = UIManager.LuaNew();
return instance;