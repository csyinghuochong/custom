local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mBaseProxyWindow = require "Core/BaseProxyWindow"
local mGameTimer = require "Core/Timer/GameTimer"
local BgEnum = Assets.Scripts.Com.Game.Enum.BgEnum;
local Alert = Assets.Scripts.Com.Game.Module.Prompt.Alert;
local ActionGameObject = System.Action_UnityEngine_GameObject
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local BaseViewParam = Assets.Scripts.Com.Game.Core.BaseViewParam;
local SysSoundConst = Assets.Scripts.Com.Game.Config.SysSoundConst;
local SpecialButton = Assets.Scripts.Com.Game.Mono.UI.SpecialButton;
local RenderQueueEnum = Assets.Scripts.Com.Game.Enum.RenderQueueEnum;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local CommonTipsView = mLuaClass("CommonTipsView",mBaseProxyWindow);
local GameObject = UnityEngine.GameObject;
local ArrayUtil = require "Utils/ArrayUtil"
local mString = require 'string'
local mColor = Color;
local instance;


function CommonTipsView:OnLuaNew()
	local baseViewParam = BaseViewParam.New();
	baseViewParam.url = "UI/Prompt/FlowTip";
	baseViewParam.viewName = "FlowTip";
	baseViewParam.ParentLayer = UIManager.mGlobalPop4;
    baseViewParam.forbidSound = true;

	self.mGameProxyWindow = UIManager:RegisterViewFromLua("CommonTipsView",baseViewParam,CommonTipsView.Init,CommonTipsView.Show,CommonTipsView.Hide,CommonTipsView.Dispose);
end

function CommonTipsView.Init()
    instance.mTransform = instance.mGameProxyWindow.transform;
	instance.mGameObject = instance.mGameProxyWindow.gameObject;

	instance.mTextTip = instance.mGameObject:GetComponent('UILabel');
end

local mTip = params;
function CommonTipsView.Show()
   instance.mTextTip.text = mTip;
 
   instance.mGameTimer = mGameTimer.SetTimeout(1.5, function()
   		instance.mGameProxyWindow:HideView()
   end, true);
end

function CommonTipsView.Hide()
    instance:DisposeTimer();
end

function CommonTipsView:DisposeTimer(  )
	local gameTimer = self.mGameTimer;
	if gameTimer ~= nil then
		gameTimer:Dispose();
		self.mGameTimer = nil;
	end	
end

function CommonTipsView.Dispose()
   
end

function CommonTipsView.ShowTip(params)
	mTip = params;
    UIManager:OpenUIFromLua("CommonTipsView");
end

instance = CommonTipsView.LuaNew();
return instance;