local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local NotifyDef = require "Module/CommonUI/NotifyDef"
local mBaseProxyWindow = require "Core/BaseProxyWindow"
local mActivityModel = require "Module/Activity/ActivityModel"
local NotifyManager = require "Module/CommonUI/NotifyManager"
local mActivityItemVO = require "Module/Activity/ActivityItemVO"
local mLayoutController = require "Core/Layout/LayoutController"
local mConfigSysactive_lv = require "ConfigFiles/ConfigSysactive_lv"
local mConfigSysactive_combat = require "ConfigFiles/ConfigSysactive_combat"
local mConfigSysactive_phase = require "ConfigFiles/ConfigSysactive_phase"
local mActivationCodeView = require "Module/Activity/ActivationCodeView"
local mActivityControl = require "Module/Activity/ActivityController"
local BgEnum = Assets.Scripts.Com.Game.Enum.BgEnum;
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local BaseViewParam = Assets.Scripts.Com.Game.Core.BaseViewParam;
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local SysSoundConst = Assets.Scripts.Com.Game.Config.SysSoundConst;
local ActivityType = require "Module/Activity/ActivityType";
local ActivityView = mLuaClass("ActivityView",mBaseProxyWindow);
local mString = require 'string'
local mColor = Color;
local instance;

function ActivityView:OnLuaNew()
	local baseViewParam = BaseViewParam.New();
	baseViewParam.url = "UI/Activity/ActivityView";
	baseViewParam.viewName = "ActivityView";
	baseViewParam.ParentLayer = UIManager.mNormalLayer1;
    baseViewParam.bgEnum = BgEnum.GRAY;
    baseViewParam.hideAllActors = true;

	self.mGameProxyWindow = UIManager:RegisterViewFromLua("ActivityView",baseViewParam,ActivityView.Init,ActivityView.Show,ActivityView.Hide,ActivityView.Dispose);
end

function ActivityView.Init()
	instance.mTransform = instance.mGameProxyWindow.transform;
	instance.mGameObject = instance.mGameProxyWindow.gameObject;

	local btn_number = 4;
	local btn_back = {};
	local btn_notify = {};
	local btn_name = {};
	for i = 1, btn_number do
		local btn_path = mString.format('Button/Button%d', i - 1);

        btn_back[i] = instance:FindComponent(mString.format('%s/background', btn_path), 'UISprite')
        btn_notify[i] = instance:FindChild(mString.format('%s/Notify', btn_path));
        btn_name[i] = instance:FindComponent(mString.format('%s/Label', btn_path), 'UILabel');

        CSharpInterface.GameUIEventListenerGet(instance:FindChild(btn_path), function ()
			instance:OnClickButton(i);
		end, SysSoundConst.S_UI_OPEN_VIEW);
	end
	instance.mButtonNumber = btn_number;
	instance.mButtonBack = btn_back;
	instance.mButtonNotify = btn_notify;
	instance.mButtonName = btn_name;

	local btn_close = instance:FindChild("Button_Close");
	CSharpInterface.GameUIEventListenerGet(btn_close,function ()
		instance.mGameProxyWindow:HideView();
	end);

	instance.mPanelObj = instance:FindChild("Panel");
	local parent = instance:FindComponent('Panel/Grid', 'UIGrid');
	instance.mGridEx = mLayoutController.LuaNew(parent, require "Module/Activity/ActivityItemView");

	instance.mGetStageInfoBack = function()
		instance:OnGetStageInfoBack();
	end
	instance.mGetRewardBack = function(op_type, id)
		instance:OnGetRewardBack(op_type, id);
	end
	instance.mSendGetReward = function(id)
		instance:OnSendGetReward(id);
	end

    local btn_type_dic = {};
    btn_type_dic[1] = ActivityType.Level;
    btn_type_dic[2] = ActivityType.Power;
    btn_type_dic[3] = ActivityType.Stage;
    btn_type_dic[4] = ActivityType.ActivationCode;
    instance.mButtonType = btn_type_dic;
end

function ActivityView:OnGetStageInfoBack()
    local mType = self.mType;
    if mType == ActivityType.Stage then
    	self:InitGrid(mType);
    end
end

function ActivityView:OnGetRewardBack(op_type, id)
	local mType = self.mType;
	if mType == op_type then
		self:ItemOperateBack(id);
	end
	
    self:CheckButtonNotify();
end

function ActivityView:OnSendGetReward(id)
	mActivityControl:SendActivityOperate(self.mType, id);
end

function ActivityView:ItemOperateBack(id)
	local item = self.mGridEx:GetChild(id);
	if item ~= nil then
		item:ItemOperateBack();
	end
end

function ActivityView:OnClickButton(index)
	local mType = self.mType;
	local cType = self.mButtonType[index];
	if mType == cType then
		return;
	end
	if mType == ActivityType.ActivationCode then
		local activationCodeView = self.mActivationCodeView;
		if activationCodeView ~= nil then
			activationCodeView:HideView();
		end
	end

	self.mType = cType;
	if cType == ActivityType.Stage then
		self.mPanelObj:SetActive(true);
		mActivityControl:SendActivityPhaseInfo();
	elseif cType == ActivityType.ActivationCode then
		local activationCodeView = self.mActivationCodeView;
		if activationCodeView == nil then
			activationCodeView = mActivationCodeView.LuaNew();
			self.mActivationCodeView = activationCodeView;
		end
		activationCodeView:ShowView();
		self.mPanelObj:SetActive(false);
	else
		self.mPanelObj:SetActive(true);
		self:InitGrid(cType);
	end

    self:SetButton(index);
end

local mNormaSprite = 'public_tab_2';
local mDisableSprite = 'public_tab_1';
local mDisableColor = mColor.New(172 / 255,  173 / 255, 196 / 255);
function ActivityView:SetButton(index)
	local btn_back = self.mButtonBack;
	local btn_name = self.mButtonName;
     for i = 1, instance.mButtonNumber do
     	btn_back[i].spriteName = i == index and mDisableSprite or mNormaSprite;
     	btn_name[i].color = i == index and mColor.white or mDisableColor;
     end
end

function ActivityView:InitGrid(mType)
	local grid_ex = self.mGridEx;
	--grid_ex:InitPanelPos();

	local data = mSortTable.LuaNew(function(a, b) return self:Sort(a, b) end, nil, true);
	if mType == ActivityType.Level then
		for k, v in pairs(mConfigSysactive_lv) do
			local id = v.lv;
			data:AddOrUpdate(id, mActivityItemVO.LuaNew(mType, id, self.mSendGetReward));
		end
	elseif mType == ActivityType.Power then
		for k, v in pairs(mConfigSysactive_combat) do
			data:AddOrUpdate(k, mActivityItemVO.LuaNew(mType, k, self.mSendGetReward));
		end
	else
		for k, v in pairs(mConfigSysactive_phase) do
			data:AddOrUpdate(k, mActivityItemVO.LuaNew(mType, k, self.mSendGetReward));
		end
	end

	grid_ex:UpdateDataSource(data);
end

function ActivityView:Sort(a, b)
	local r;
	local a_id = a.mID;
	local b_id = b.mID;
	local mType = self.mType;
	local get1 = mActivityModel:GetGetState(mType, a_id);
    local get2 = mActivityModel:GetGetState(mType, a_id);
    if get1 == get2 then
    	r = a_id < b_id;
    else
    	r = get2;
    end
    return r;
end


function ActivityView:CheckButtonNotify()
	local btn_notify = self.mButtonNotify;
	btn_notify[1]:SetActive(mActivityModel:CheckLevelNotify());
    btn_notify[2]:SetActive(mActivityModel:CheckPowerNotify());
    btn_notify[3]:SetActive(mActivityModel:CheckPhaseNotify());
end

function ActivityView.Show()
	instance:SetButton(1);
	instance.mType = ActivityType.Level;
	instance.mPanelObj:SetActive(true);
	instance:InitGrid(ActivityType.Level);
	instance:CheckButtonNotify();

	mActivityModel.mGetPhaseInfoBack = instance.mGetStageInfoBack;
	mActivityModel.mGetActiveOperateBack = instance.mGetRewardBack;
end

function ActivityView.Hide()
	NotifyManager:OnShowNotify(NotifyDef.NEW_ACTIVITY_NOTIFY, mActivityModel:CheckActivityNotify());

	mActivityModel.mGetPhaseInfoBack = nil;
	mActivityModel.mGetActiveOperateBack = nil;

	local activationCodeView = instance.mActivationCodeView;
		if activationCodeView ~= nil then
			activationCodeView:HideView();
		end
end

function ActivityView.Dispose()
	local grid_ex = instance.mGridEx;
	if grid_ex ~= nil then
		grid_ex:Dispose();
	end
end

function ActivityView:OpenUI()
	UIManager:OpenUIFromLua("ActivityView");
end

instance = ActivityView.LuaNew();
return instance;