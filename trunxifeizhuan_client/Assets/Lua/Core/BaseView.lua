local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mResourceUrl = require("AssetManager/ResourceUrl")
local mAssetManager = require "AssetManager/AssetManager"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local mQueue = require "Common/Queue"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mEventEnum = require "Enum/EventEnum"
local BaseView = mLuaClass("BaseView",mEventDispatcherInterface);
local GameObject = UnityEngine.GameObject;
local ImageType = typeof(UnityEngine.UI.Image);
local mColor = Color;
local mVector3 = Vector3;
local ButtonType = typeof(UnityEngine.UI.Button);
local mSoundManager = require "Module/Sound/SoundManager"
local mButtonStr = "Button";
local mOnLoadViewCompleteStr = "OnLoadViewComplete"
local mRectTransformStr = "RectTransform"
local mOnViewShowStr = "OnViewShow"
local mOnViewHideStr = "OnViewHide"
local mBgStr = "bg"
local mTime = UnityEngine.Time;


function BaseView:OnLuaNew(go)
	self.mEventEnum = mEventEnum;
	self.mGameObjectUtil = mGameObjectUtil;
	self.mIsLoadView = false;
	self.mIsDestory = nil;
	self.mViewParams = self:InitViewParam();
	self:InjectGameObject(go);
end

local mChangeSceneDispose = "ChangeSceneDispose";
--有些界面切换场景就可以释放，节省内存
function BaseView:CheckChangeSceneDispose()
	local selfViewParams = self.mViewParams;
	return selfViewParams and selfViewParams[mChangeSceneDispose];
end

function BaseView:HandleWindowCostUI(handleStatus,params)
	mUIManager:HandleWindowCostUI(handleStatus,params);
end

function BaseView:Find( name )
	return self.mTransform:Find(name);
end

function BaseView:FindComponent(name, component)
	if name == nil or name == "" then
		return self.mTransform:GetComponent(component);
	else
		return self:Find(name):GetComponent(component);
	end
end

function BaseView:AddBtnClickListener(btn,listener,soundName,intervalTime)
	local button = btn:GetComponent(mButtonStr);

	if soundName ~= nil or intervalTime ~= nil then
		local time = 0;
		button.onClick:AddListener(function()

			if soundName ~= nil then
				self:PlaySoundName(soundName);
			end

			if intervalTime ~= nil then
				local curTime = mTime.realtimeSinceStartup;
				if curTime - time >= intervalTime then
					time = curTime;
					listener();
				end
			else
				listener();
			end
			
		end)
	else
		button.onClick:AddListener(listener);
	end
end

function BaseView:PlaySoundName(soundName)
	mSoundManager:PlaySoundName(soundName);
end

function BaseView:FindAndAddClickListener(name,listener,soundName,intervalTime)
	self:AddBtnClickListener(self:Find(name),listener,soundName,intervalTime);
end

function BaseView:FindAndAddClickListenerReturnTrance(name,listener,soundName,intervalTime)
	local trance = self:Find(name);
	self:AddBtnClickListener(trance,listener,soundName,intervalTime);
	return trance;
end

function BaseView:InitViewParam()
	return nil;
end

function BaseView:GetViewParent()
	return self.mViewParams.ParentLayer;
end

function BaseView:SetViewParent(parent)
	self.mViewParams.ParentLayer = parent;
end

--获取界面当前父对象
function BaseView:GetViewCurParent()
	if self.mTransform ~= nil then
		return self.mTransform.parent;
	end

	return nil;
end

function BaseView:LoadView()
	if self.mIsLoadView then
		return;
	end
	self.mIsLoadView = true;
	self.mIsDestory = nil;

	local selfViewParams = self.mViewParams;
	if not selfViewParams then
		selfViewParams = self:InitViewParam();
		self.mViewParams = selfViewParams;
	end
	
	mUIManager:LoadView(selfViewParams.viewPath, selfViewParams.viewName,function(go) 
		if self.mIsDestory  then
			return;
		end

		self:OnLoadViewCompleteInit(go);
		self:OnLoadViewComplete(go);
	end);
end

function BaseView:OnLoadViewCompleteInit(go)
	
end

function BaseView:OnLoadViewComplete(go)
	self.mIsLoadView = false;
	self:InjectGameObject(go, self:GetViewParent());

	local callBacks = self.mCallBacks;
	if callBacks then
		local callBack = callBacks[mOnLoadViewCompleteStr];
		if callBack then
			callBack();
		end
	end
	
	if self.mIsShow then
		self:OnShow();
	else
		self:OnHide();
	end
end

function BaseView:SetParent(goParent)
	if goParent then
		mGameObjectUtil:SetParent(self.mTransform, goParent);
	end
end

function BaseView:InjectGameObject(go,goParent)
	if go then
		self.mGameObject = go;
		self.mTransform = go.transform;

		if self.mIsShow == nil then
			self.mIsShow = go.activeSelf;
		end

		self:InitGameObjectParent(go,goParent);

		self.mIsDestory = false;
		self:SetBackground();
		self:InternalInit();
	end
end

function BaseView:InitGameObjectParent(go,goParent)
	if goParent then
		mGameObjectUtil:SetParent(self.mTransform,goParent);
		mGameObjectUtil:RestRectTransform(go);
	end
end

function BaseView:InternalInit()
	self:Init();
end

local mTransparentColor = mColor.New(1,1,1,0);
local mGrayColor = mColor.New(0,0,0,0.6);
function BaseView:SetBackground()
	local viewParams = self.mViewParams;
	if viewParams == nil then
		return;
	end
	
	local viewBgEnum = viewParams.viewBgEnum;
	if viewBgEnum == nil or viewBgEnum < mViewBgEnum.transparent then
		return;
	end

	local bgLayer = mUIManager:CreateLayer(self.mTransform,mBgStr);
	self.mBgLayer = bgLayer;
	local bgGo = bgLayer.gameObject;
	local image = bgGo:AddComponent(ImageType);
	bgLayer:SetAsFirstSibling();

	if viewBgEnum == mViewBgEnum.transparent then
		image.color = mTransparentColor;
	elseif viewBgEnum == mViewBgEnum.transparent_clickable then
		image.color = mTransparentColor;
		self:AddButtonListener(bgGo);
	elseif viewBgEnum == mViewBgEnum.gray then
		image.color = mGrayColor;
	elseif viewBgEnum == mViewBgEnum.gray_clickable then
		image.color = mGrayColor;
		self:AddButtonListener(bgGo);
	end
end

function BaseView:AddButtonListener( bgGo  )
	local button = bgGo:AddComponent(ButtonType);
	local mSelf = self;
	button.onClick:AddListener(function()
		mSelf:OnClickHideView();
	end);
end

function BaseView:OnClickHideView()
	self:HideView();
end

function BaseView:SetGlobalClickEnable(value)
	mUIManager:SetGlobalClickEnable(value);
end

function BaseView:AddUIEffect( effect, goParent ,layer )
	local UIEffectList = self.mUIEffectList or {};
	self.mUIEffectList = UIEffectList;

	local callBack = function ( obj )
		UIEffectList[ #UIEffectList + 1 ] = obj;
		local order = mUIManager:GetLayerSortingOrder(layer);
		local Renderers = obj:GetComponentsInChildren(typeof(UnityEngine.Renderer))
		for i = 0 , Renderers.Length - 1  do
			Renderers[i].sortingOrder = order + 1;
		end
		mGameObjectUtil:SetParent(obj.transform,  goParent); 
	end
	mAssetManager.LoadUIFXExternal(effect, callBack);
end

--界面初始化
function BaseView:Init()

end

--viewParams:界面参数
--callBacks:加载完成（OnLoadViewComplete），显示（OnViewShow），隐藏（OnViewHide）的回调
function BaseView:InjectParams( viewParams,callBacks )
	if viewParams and not self.mViewParams then
		self.mViewParams = viewParams;
	end

	if callBacks then
		self.mCallBacks = callBacks;
	end
end

function BaseView:InternalSetGameObjectActive(active)
	self.mGameObject:SetActive(active);
end

--隐藏状态下跟ShowView逻辑一致，打开状态下会强制调用OnViewShow函数
function BaseView:ForceShowView(logicParams)
	if self.mIsShow then
		self.mLogicParams = logicParams;
		self:OnViewShow(self.mLogicParams);
	else
		self:ShowView(logicParams);
	end
end

--显示界面
function BaseView:ShowView(logicParams)
	if self.mIsShow then
		return;
	end

	self.mLogicParams = logicParams;
	self.mIsShow = true;
	self:OnShow();
end

function BaseView:OnShow()
	local selfGo = self.mGameObject;
	
	if selfGo then
		self:InternalSetGameObjectActive(self.mIsShow);
		self:InternalOnViewShow();
	else
		self:LoadView();
	end
end

function BaseView:InternalOnViewShow()
	local callBacks = self.mCallBacks;
	if callBacks then
		local callBack = callBacks[mOnViewShowStr];
		if callBack then
			callBack();
		end
	end

	self:InternalToggleListener(true);
	self:OnViewShow(self.mLogicParams);
end

function BaseView:OnViewShow(logicParams)

end

--隐藏界面
function BaseView:HideView(logicParams)
	if self.mIsShow == false then
		return;
	end
	
	self.mLogicParams = logicParams;
	self.mIsShow = false;
	self:OnHide();
end

function BaseView:OnHide()
	local selfGo = self.mGameObject;

	if selfGo then
		self:InternalOnViewHide();

		if not self.mDoCloseView then
			self:InternalSetGameObjectActive(false);
		end
	end
end

function BaseView:InternalOnViewHide()
	local callBacks = self.mCallBacks;
	if callBacks then
		local callBack = callBacks[mOnViewHideStr];
		if callBack then
			callBack();
		end
	end

	self:InternalToggleListener(false);
	self:OnViewHide(self.mLogicParams);
end

function BaseView:OnViewHide(logicParams)

end

--场景切换，没有释放的界面会调用此函数
function BaseView:OnChangeScene()
	
end

function BaseView:DestroyImmediate(go)
	GameObject.DestroyImmediate(go);
end

--关闭界面，释放掉GameObject
function BaseView:CloseView()
	self.mDoCloseView = true;
	self:HideView();
	self.mDoCloseView = nil;
	
	local gameObject = self.mGameObject;
	if gameObject then
		self:InternalDispose();
		self:DestroyImmediate(gameObject);
		self.mTransform = nil;
		self.mGameObject = nil;
	end

	--self.mViewParams = nil;
	self.mCallBacks = nil;
	self.mLogicParams = nil;
	self.mIsDestory = true;
	self.mIsLoadView = false;

	self:InternalToggleListener(false,true);
end

function BaseView:InternalDispose()
	self:Dispose();
end

function BaseView:Dispose()

end

--toggle: true为界面打开时侦听事件，隐藏时移除事件。false：一直侦听事件，界面关闭才移除
function BaseView:RegisterEventListener(eventType,eventListener,toggle)
	local selfRegisterListener = self.mRegisterListener;
	if not selfRegisterListener then
		selfRegisterListener = mQueue:New();
		self.mRegisterListener = selfRegisterListener;
	end

	selfRegisterListener:Enqueue({eventType,eventListener,toggle});

	if toggle == false then
		self:AddEventListener(eventType,eventListener);
	end
end

function BaseView:InternalToggleListener(show,force)
	local selfRegisterListener = self.mRegisterListener;
	if not selfRegisterListener then
		return;
	end

	local queueData = selfRegisterListener.mData;

	local toggle = nil;
	local eventType = nil;
	local eventListener = nil;

	for _,data in ipairs(queueData) do
		toggle = data[3];

		if force then

			if toggle == false then
				eventType = data[1];
				eventListener = data[2];
				self:RemoveEventListener(eventType,eventListener);
			end

		elseif toggle then

			eventType = data[1];
			eventListener = data[2];
			if show then
				self:AddEventListener(eventType,eventListener);
			else
				self:RemoveEventListener(eventType,eventListener);
			end

		end
		
	end

	if force then
		selfRegisterListener:Clear();
	end
end

return BaseView;