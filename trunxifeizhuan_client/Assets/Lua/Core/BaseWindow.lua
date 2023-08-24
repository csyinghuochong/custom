local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mUIManager = require "Manager/UIManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mUIAnimationUtil = require "Utils/UIAnimationUtil"
local mResourceUrl = require("AssetManager/ResourceUrl")
local mAssetManager = require "AssetManager/AssetManager"
local mSoundConst = require "ConfigFiles/ConfigSyssoundConst"
local BaseWindow = mLuaClass("BaseWindow",mBaseView);
local mSuper = nil;
local tableRemove = table.remove;

local Application = UnityEngine.Application;
local mIsEditor = Application.isEditor;
local mLoadUIAssetBundle = GameDebugConfig.loadUIAssetBundle;
local mCheckLoadUIAssetBundle = mIsEditor and mLoadUIAssetBundle == false

local CanvasType = typeof(UnityEngine.Canvas);
local GraphicRaycasterType = typeof(UnityEngine.UI.GraphicRaycaster);
local mAdditionalCanvasShaderChannels = UnityEngine.AdditionalCanvasShaderChannels;

local mPlayAnimation = "PlayAnimation";
local mViewSound = "ViewSound"
local mForbitSound = "ForbitSound"

function BaseWindow:OnLuaNew(go)
	self.mCheckBaseWindow = true;

	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self,go);
end

function BaseWindow:StartPreloadAsset()
	
end

function BaseWindow:PreLoadAsset(path,file)
	mAssetManager.PreLoadAsset(path,file);
end

function BaseWindow:PreLoadViewModule(luaClass)
	if mCheckLoadUIAssetBundle then
		return false;
	end

	local view_item = require(luaClass);
	local view_param = view_item:InitViewParam();
	if view_param == nil then
		return;
	end
	self:PreLoadAsset(view_param.viewPath,view_param.viewName);
end

function BaseWindow:OnLoadViewCompleteInit(go)
	if self.mViewParams.AdditionalShaderChannels then
		local canvas = go:AddComponent(CanvasType);
		go:AddComponent(GraphicRaycasterType);
		canvas.additionalShaderChannels = mAdditionalCanvasShaderChannels.TexCoord1;
	end
end

--用于检测界面是否符合某些条件下显示
--true：可显示
--false：不可显示
function BaseWindow:CheckShow()
	return true;
end

function BaseWindow:CheckPlayAnimation()
	if mCheckLoadUIAssetBundle then
		return false;
	end

	local selfViewParams = self.mViewParams;
	return false --and selfViewParams and selfViewParams[mPlayAnimation] and self.mExternalForceShow ~= true;
end

function BaseWindow:InternalInit()
	if self.mIsShow and self:CheckPlayAnimation() then
		self.mDelayInit = true;
	else
		self:Init();
	end
end

function BaseWindow:OnShow()
	local selfGo = self.mGameObject;
	
	if selfGo then
		local show = self.mIsShow;
		self:InternalSetGameObjectActive(show);

		if self:CheckPlayAnimation() then
			local bgLayer = self.mBgLayer;
			if bgLayer then
				bgLayer:SetParent(self.mTransform.parent);
				bgLayer:SetAsFirstSibling();
			end

			mUIAnimationUtil:PlayOpenAnimation(self.mTransform,function()
				if bgLayer then
					bgLayer:SetParent(self.mTransform);
					bgLayer:SetAsFirstSibling();
				end

				if self.mDelayInit then
					self.mDelayInit = false;
					self:Init();
				end
				
				self:InternalOnViewShow();
			end);
		else
			self:InternalOnViewShow();
		end	
	else
		self:LoadView();
	end
end

function BaseWindow:HandleUI(viewModule,handleStatus,params)
	mUIManager:HandleUI(viewModule,handleStatus,params);
end

function BaseWindow:CheckDisposeCostUI()
	local viewParams = self.mViewParams;
	if viewParams then
		--要先判断full_cost
		if viewParams.full_cost then
			mUIManager:CheckDisposeCostUI(false,self);
		elseif viewParams.cost then
			mUIManager:CheckDisposeCostUI(true,self);
		end
	end
end

function BaseWindow:InternalOnViewShow()
	mUIManager:OnLayerShow(self);

	local viewParams = self.mViewParams;
	if viewParams then
		--要先判断full_cost
		--设置了viewParams.cost = viewParams.full_cost;
		--在MainCostView使用cost统一逻辑
		if viewParams.full_cost then
			viewParams.costViewParent = self.mTransform;
			viewParams.costViewParentLayer = self:GetViewCurParent();
			viewParams.costViewWindow = self;
			viewParams.cost = viewParams.full_cost;
			mUIManager:HandleFullCostUI(1,viewParams);
		elseif viewParams.cost then
			viewParams.costViewParent = self.mTransform;
			viewParams.costViewParentLayer = self:GetViewCurParent();
			viewParams.costViewWindow = self;
			self:HandleWindowCostUI(1,viewParams);
		end
	end

	self:OnViewShowPlaySound();
	mSuper.InternalOnViewShow(self);
end

function BaseWindow:InternalOnViewHide()
	mUIManager:OnLayerHide(self);
	mSuper.InternalOnViewHide(self);

	local viewParams = self.mViewParams;
	if viewParams then
		--要先判断full_cost
		if viewParams.full_cost then
			viewParams.costViewParent = nil;
			mUIManager:HandleFullCostUI(0);
		elseif viewParams.cost then
			viewParams.costViewParent = nil;
			self:HandleWindowCostUI(0);
		end
	end

	self:OnViewHidePlaySound();
end

function BaseWindow:OnViewShowPlaySound()
	if self:CheckForbitSound() ~= true then
		self:PlayShowSound();

		local sound = self.mViewParams[mViewSound];
		if sound ~= nil then
			self:PlaySoundName(sound);
		end
	end
end

function BaseWindow:OnViewHidePlaySound()
	if self:CheckForbitSound() ~= true then
		self:PlayHideSound();
	end
end

function BaseWindow:CheckForbitSound()
	return self.mViewParams[mForbitSound];
end

function BaseWindow:GetParentSortingOrder()
	return mUIManager:GetLayerSortingOrder(self.mViewParams.ParentLayer);
end

function BaseWindow:GetValidSortingOrder()
	return self:GetParentSortingOrder() + 1;
end

--加载UI特效
function BaseWindow:AddUIEffect( effect, goParent ,layer)
	mSuper.AddUIEffect(self,effect,goParent, layer or self.mViewParams.ParentLayer);
end

function BaseWindow:InternalDispose()
	local UIEffectList = self.mUIEffectList;
	if UIEffectList then
		for i=#UIEffectList,1,-1 do
			local effect = UIEffectList[i];
			self:DestroyImmediate(effect);
			tableRemove(UIEffectList,i);
		end
	end

	self:CheckDisposeCostUI();

	mSuper.InternalDispose(self);
end

--非主动隐藏，比如同层级界面切换
function BaseWindow:ExternalForceHideView()
	self.mExternalForceHide = true;
	self:HideView();
	self.mExternalForceHide = false;
end

--非主动显示，比如返回之前界面
function BaseWindow:ExternalForceShowView()
	self.mExternalForceShow = true;
	self:ShowView();
	self.mExternalForceShow = false;
end

--打开界面音效
function BaseWindow:PlayShowSound()
	--print("PlayShowSound:",self.mViewParams.viewName);
	self:Dispatch(self.mEventEnum.PLAY_SOUND,mSoundConst.ty_0201);
end

--关闭界面音效
function BaseWindow:PlayHideSound()
	--print("PlayHideSound:",self.mViewParams.viewName);
	self:Dispatch(self.mEventEnum.PLAY_SOUND,mSoundConst.ty_0202);
end

return BaseWindow;
