local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigGlobalValue = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local EndlseeXinjiBuffView = mLuaClass("EndlseeXinjiBuffView", mBaseView);
local mConfigSkillBuff = require "ConfigFiles/ConfigSysskill_buff"
local mNormalVector = Quaternion.Euler(0,0,90);
local mExpandVector = Quaternion.Euler(0,0,270);

function EndlseeXinjiBuffView:OnLuaNew(goParent)
	self.mBuffCost = mConfigGlobalValue[mConfigGlobalConst.BUFF_COST];
	self.mGoParent = goParent;
end

function EndlseeXinjiBuffView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_xinjibuff_view",
	};
end

function EndlseeXinjiBuffView:Init()
	self.mNormalBg = self:Find('normal/bg').gameObject;
	self.mExpand = self:Find('expand').gameObject;
	self.mCloseBg = self:Find('close').gameObject;
	self:FindAndAddClickListener("normal/btn",function() self:OnExpand() end);
	self:FindAndAddClickListener("close",function() self:OnExpand() end);
	self.mBuffCostText = self:FindComponent('cost', 'Text');
	self.mBuffCountText = self:FindComponent('count', 'Text');
	self.mArrows = self:Find("arrows");
    local buffToggleList = {};
    local buffTextList = {};
    for i=1,3 do
    	buffToggle = self:FindComponent('expand/buff'..i..'/select', 'Toggle');
    	buffToggle.onValueChanged:AddListener(function() self:OnValueChange() end);
    	buffToggleList[i] = buffToggle;
    	local buffText = self:FindComponent('expand/buff'..i..'/Text', 'Text');
        buffTextList[i] = buffText;
    end
    self.mBuffToggleList = buffToggleList;
    self.mBuffTextList = buffTextList;

    self:SetParent(self.mGoParent);
    local rectTransform = self:FindComponent(nil,'RectTransform');
    rectTransform.sizeDelta = Vector3.zero;
end

function EndlseeXinjiBuffView:OnViewShow()
	self.mIsExpand = false;
	self.mCloseBg:SetActive(false);
	local buffs = mGameModelManager.EndlessDungeonModel.mMeirenxinjiData.mBuffs;
	self.mBuffs = buffs;
	local buffList = mGameModelManager.EndlessDungeonModel.mBuffList;
	for i,v in ipairs(buffs) do
        self.mBuffTextList[i].text = mConfigSkillBuff[v].desc;
    end
    for i,v in ipairs(buffList) do
    	self.mBuffToggleList[i].isOn = v;
    end
    self:OnValueChange();
end

function EndlseeXinjiBuffView:OnValueChange()
	local count = 0;
    local toggleList = self.mBuffToggleList;
	for i=1,3 do
		if toggleList[i].isOn then
           count = count + 1;
		end
	end
	local buffCost = self.mBuffCost;
	self.mBuffCountText.text = "( "..count.."/3 )";
    self.mBuffCostText.text = count > 1 and (count - 1) * buffCost or 0;
end

function EndlseeXinjiBuffView:OnExpand()
	local expand = not self.mIsExpand;
	if expand then
       self.mArrows.rotation = mExpandVector;
	else
       self.mArrows.rotation = mNormalVector;
	end
	self.mCloseBg:SetActive(expand);
	self.mExpand:SetActive(expand);
	self.mNormalBg:SetActive(not expand);
    self.mIsExpand = expand;
end

function EndlseeXinjiBuffView:GetSelectBuffs()
	local selectBuffs = {};
	local buffs = self.mBuffs
	local buffToggleList = self.mBuffToggleList
	for i=1,3 do
		if buffToggleList[i].isOn then
           table.insert(selectBuffs,buffs[i]);
		end
	end
	return selectBuffs;
end

return EndlseeXinjiBuffView;