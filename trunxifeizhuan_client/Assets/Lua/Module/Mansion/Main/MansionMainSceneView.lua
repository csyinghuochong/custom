local mViewEnum = require "Enum/ViewEnum"
local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mUIManager = require "Manager/UIManager"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysfunction_open = require "ConfigFiles/ConfigSysfunction_open"
local mFunctionOpenManager = require "Module/MainInterface/FunctionOpenManager"
local MansionMainSceneView = mLuaClass("MansionMainSceneView",mBaseView);
local mVector2 = Vector2;

local WIDTH = 2048;
local HEIGHT = 768;
function MansionMainSceneView:Init()
	self:AddListeners();
	self:InitSubView();
end

function MansionMainSceneView:InitSubView(  )
	local bgTransform = self:Find('main_bg'):GetComponent('RectTransform');
	local width = mUIManager:GetDeviceWidth( );
	local height = mUIManager:GetDeviceHeight( );
	local scaleRate = height / HEIGHT;
	bgTransform.sizeDelta = Vector2( WIDTH * scaleRate  , height );
	bgTransform.localPosition = Vector3(  -1 * width / 2, 0 , 0 );

	for k,v in pairs(mConfigSysfunction_open) do
		if v.button_info ~= nil and v.button_info[1] == "2"then
			local buttonSceneID = tonumber(v.button_info[2]);
			local button_transform = self:FindAndAddClickListenerReturnTrance('main_bg/btn/'..buttonSceneID,function(id)self:OnClickButton(v);end);
			mFunctionOpenManager:RegisterFunctionGo(k,button_transform.gameObject,v.open_condition)
			button_transform:Find("Name"):GetComponent("Text").text = v.button_info[3];
			local positon = button_transform.localPosition;
			button_transform.localPosition = Vector3.New( positon.x * scaleRate, positon.y *  scaleRate, 0 );
		end
	end

	local npc_view = self:Find('main_bg/npc');
	local npc_positon = npc_view.localPosition;
	npc_view.localPosition = Vector3.New( npc_positon.x * scaleRate, npc_positon.y *  scaleRate, 0 );

	local servant_view = self:Find('main_bg/servant');
	local servant_number = servant_view.childCount;
	for i = 1, servant_number do
		local servant_item = servant_view:GetChild(i - 1);
		local positon = servant_item.localPosition;
		servant_item.localPosition = Vector3.New( positon.x * scaleRate, positon.y *  scaleRate, 0 );
	end

	local plant_view = self:Find('main_bg/plant');
	local plant_number = plant_view.childCount;
	for i = 1, plant_number do
		local plant_item = plant_view:GetChild(i - 1);
		local positon = plant_item.localPosition;
		plant_item.localPosition = Vector3.New( positon.x * scaleRate, positon.y *  scaleRate, 0 );
	end
end

function MansionMainSceneView:AddListeners(  )
	
end

function MansionMainSceneView:OnClickButton(data)
	local mansionVo = self.mData; 
	if data.view_params ~= nil and mansionVo:IsSelfMansion( ) then
		mUIManager:HandleUI(mViewEnum[data.view_params[1]], 1, mansionVo);
	end
end

function MansionMainSceneView:OnRecvMansionData( data )
	self.mData = data;
end

function MansionMainSceneView:OnViewShow()
	
end

function MansionMainSceneView:OnViewHide()

end

return MansionMainSceneView;