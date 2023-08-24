local mLuaClass = require "Core/LuaClass"
local GameTimer = require "Core/Timer/GameTimer"
local ActionGameObject = System.Action_UnityEngine_GameObject
local mUIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local UIEffectManager = Com.Game.Manager.CSharpToLuaInterface.GetUIEffectManager();
local mBaseViewFunction = require "Core/BaseViewFunction"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local BaseView = mLuaClass("BaseView",mBaseViewFunction);
local GameObject = UnityEngine.GameObject;

function BaseView:OnLuaNew(go)
	self.mIsShow = false;
	self.mIsLoadView = false;
	self.mIsDestory = true;
	self.mViewParams = self:InitViewParam();
	self:InjectGameObject(go);
end

function BaseView:InitViewParam()
	return nil;
end

function BaseView:GetViewParent()
	return self.mViewParams.ParentLayer;
end

function BaseView:LoadView()
	if self.mIsLoadView then
		return;
	end
	self.mIsLoadView = true;

	local selfViewParams = self.mViewParams;
	if not selfViewParams then
		selfViewParams = self:InitViewParam();
		self.mViewParams = selfViewParams;
	end
	mUIManager:LoadViewFromLua(selfViewParams.viewPath, selfViewParams.viewName,function(go) self:OnLoadViewComplete(go) end);
end

function BaseView:OnLoadViewComplete(go)
	self.mIsLoadView = false;
	self:InjectGameObject(go, self:GetViewParent());

	local callBacks = self.mCallBacks;
	if callBacks then
		local callBack = callBacks["OnLoadViewComplete"];
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

function BaseView:InjectGameObject(go,goParent)
	if go then
		self.mGameObject = go;
		self.mTransform = go.transform;
		self.mIsShow = go.activeSelf;
		
		if goParent then
			mGameObjectUtil:SetParent(self.mTransform,goParent);
		end
		
		self:InternalInit();
	end
end

function BaseView:InternalInit()
	self.mIsDestory = false;
	self:Init();
end

function BaseView:OnClickHideView()
	self:HideView();
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
		selfGo:SetActive(self.mIsShow);
		self:InternalOnViewShow();
	else
		self:LoadView();
	end
end

function BaseView:InternalOnViewShow()
	local callBacks = self.mCallBacks;
	if callBacks then
		local callBack = callBacks["OnViewShow"];
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
		selfGo:SetActive(false);
	end
end

function BaseView:InternalOnViewHide()
	local callBacks = self.mCallBacks;
	if callBacks then
		local callBack = callBacks["OnViewHide"];
		if callBack then
			callBack();
		end
	end

	self:InternalToggleListener(false);
	self:OnViewHide(self.mLogicParams);
end

function BaseView:OnViewHide(logicParams)

end

--关闭界面，释放掉GameObject
function BaseView:CloseView()
	self:HideView();
	
	local gameObject = self.mGameObject;
	if gameObject then
		self:InternalDispose();
		GameObject.DestroyImmediate(gameObject);
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

function BaseView:AddUIEffect(delayFrameShow, effectLayerEnum, effectParent, effectName, callBack, resetScale, layerTop, dontDestoryAssetUnit)
    GameTimer.ExecuteTotalFrames(delayFrameShow, nil, function()
        if self.mIsDestory == true then
            return;
        end

        callBack = callBack ~= nil and callBack or nil;
        resetScale = resetScale ~= nil and resetScale or true;
        layerTop = layerTop ~= nil and layerTop or true;
        dontDestoryAssetUnit = dontDestoryAssetUnit ~= nil and dontDestoryAssetUnit or false;

        local c_callBack = ActionGameObject(callBack);
        UIEffectManager:AddUIEffect(effectLayerEnum, effectParent, effectName, c_callBack, resetScale, layerTop, dontDestoryAssetUnit);
    end, true, true);
end

return BaseView;