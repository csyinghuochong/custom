local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mConfigSysfunction_open = require "ConfigFiles/ConfigSysfunction_open"
local mFunctionOpenManager = require "Module/MainInterface/FunctionOpenManager"
local MainArenaBalanceView = require "Module/MainInterface/MainArenaBalanceView"
local mConfigsysfunctionConst = require "ConfigFiles/ConfigSysfunction_openConst"
local mGameModelManager = require "Manager/GameModelManager"
local MainSceneView = mLuaClass("MainSceneView",mBaseWindow);
local mVector2 = Vector2;
local WIDTH = 1536;
local HEIGHT = 768;
function MainSceneView:InitViewParam()
	return {
		["viewPath"] = "ui/main_interface/",
		["viewName"] = "main_scene_view",
		["ParentLayer"] = mMainSceneLayer,
		["ForbitSound"] = true,
	};
end

function MainSceneView:Init()
	self.mBgTransform = self:Find('Scroll/main_bg'):GetComponent('RectTransform');
	local xPos = (WIDTH - mUIManager:GetDeviceWidth())/2;
	self.mBgTransform.anchoredPosition = mVector2.New(xPos,0);

	self:AddListeners();
	self:InitSubView();
end

function MainSceneView:InitSubView(  )
	local button_list = {};
	local arenaTime = self:Find( 'Scroll/main_bg/arena_time' );
	for k,v in pairs(mConfigSysfunction_open) do
		if v.button_info ~= nil and v.button_info[1] == "1"then
			local buttonSceneID = tonumber(v.button_info[2]);
			button_list[buttonSceneID] = self:FindAndAddClickListenerReturnTrance('Scroll/main_bg/Scene_Button'..buttonSceneID,function(id)self:OnClickButton(k);end);
			mFunctionOpenManager:RegisterFunctionGo(k,button_list[buttonSceneID].gameObject,v.open_condition)
			button_list[buttonSceneID]:Find("Name"):GetComponent("Text").text = v.button_info[3];

			if k == mConfigsysfunctionConst.ARENAENTRY then
				mGameObjectUtil:SetParent( arenaTime, button_list[buttonSceneID]);
			end
		end
	end
	self.mArenaBalanceView = MainArenaBalanceView.LuaNew( arenaTime.gameObject );
end

function MainSceneView:AddListeners(  )
	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_CHANGE_MAINSCENE_POS,function(data)self:SetBgPosByTransform(data)end,true);
end

function MainSceneView:SetBgPosByTransform(transform)
	if transform ~= nil then
		local xPos = transform.localPosition.x;
		local xPosLeft = -(WIDTH - mUIManager:GetDeviceWidth())/2;
		local xPosRight = (WIDTH - mUIManager:GetDeviceWidth())/2;
		if xPos < xPosLeft then
			xPos = xPosRight;
		elseif xPos > xPosRight then
			xPos = xPosLeft;
		end
		self.mBgTransform.anchoredPosition = mVector2.New(xPos,0);
	else
		self.mBgTransform.anchoredPosition = mVector2.zero;
	end
end

function MainSceneView:OnClickButton(id)
	local data = mConfigSysfunction_open[id];
	if data.view_params ~= nil then
		mUIManager:HandleUI(mViewEnum[data.view_params[1]],1);
	end
end

function MainSceneView:OnViewShow()
	self.mArenaBalanceView:ShowView( );
end

function MainSceneView:OnViewHide()
	self.mArenaBalanceView:HideView( );
end

function MainSceneView:Dispose(  )
	self.mArenaBalanceView:CloseView( );
end

return MainSceneView;