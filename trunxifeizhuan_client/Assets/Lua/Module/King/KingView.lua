local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mKingController = require "Module/King/KingController"
local mLayoutController = require "Core/Layout/LayoutController"
local mAttributeTypeToVO = require "Module/Talent/AttributeTypeToVO"
local mCommonGoodsNeedItemView = require "Module/CommonUI/CommonGoodsNeedItemView"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mUIGray = require "Utils/UIGray"
local mColor = Color
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mSkillIconPath = mResourceUrl.skill_icon;
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local KingView = mLuaClass("KingView", mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgKingSpeedTitle = mLanguageUtil.attribute_attack_king_speed;
local mLgLevel = mLanguageUtil.level
local mLgGoodsNoEnough = mLanguageUtil.common_goods_no_enough;

function KingView:InitViewParam()
	return {
		["viewPath"] = "ui/king/",
		["viewName"] = "king_view",
		["ParentLayer"] = mMainLayer,
		["ChangeSceneDispose"] = true,
	};
end

function KingView:Init()
	self.mTextName = self:FindComponent("Left/name","Text");
	self.mTextNameAndLevel = self:FindComponent("Right/name","Text");
	self.mTextDesc = self:FindComponent("Right/Desc/desc","Text");
	self.mTextMaxDesc = self:FindComponent("Right/Add/Max/desc","Text");
	self.mTextNowDesc = self:FindComponent("Right/Add/Now/desc","Text");
	self.mTextNextDesc = self:FindComponent("Right/Add/Next/desc","Text");
	self.mTextMaxNum = self:FindComponent("Right/Add/Max/add","Text");
	self.mTextNowNum = self:FindComponent("Right/Add/Now/add","Text");
	self.mTextNextNum = self:FindComponent("Right/Add/Next/add","Text");

	self.mGoMax = self:Find("Right/Add/Max").gameObject;
	self.mGoNow = self:Find("Right/Add/Now").gameObject;
	self.mGoNext = self:Find("Right/Add/Next").gameObject;
	self.mGoCost = self:Find("Right/Cost").gameObject;
	self.mGoCostMax = self:Find("Right/BtnMax").gameObject;

	local item = self:Find("Right/Cost/item").gameObject;
	self.mItem = mCommonGoodsNeedItemView.LuaNew(item);

	self.mSkillGridEx = mLayoutController.LuaNew(self:Find("Left/scrollView/Grid"), require "Module/King/KingSkillItemView");
	self.mSkillGridEx:SetSelectedViewTop(true);

	self:FindAndAddClickListener("Button_return",function() self:ReturnPrevQueueWindow(); end);
	self:FindAndAddClickListener("Right/Cost/Btn",function() self:OnClickSkillUp(); end);

	self:RegisterEventListener(mEventEnum.ON_SKILL_UPDATE, function()
         self:InitSkills();
    end, true);

    self:RegisterEventListener(mEventEnum.ON_SELECT_KING_SKILL, function(data)
         self:OnSelect(data);
    end, true);

    local UIGrayBtnLevelMax = mUIGray.LuaNew():InitGoGraphic(self:Find('Right/BtnMax/Image').gameObject);
    UIGrayBtnLevelMax:SetGray(true);

    self.mRawImageIcon = self:FindComponent("Left/icon","RawImage");
    self.mRawImageIcon.color = mColor.clear;
    self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end
end

function KingView:OnClickSkillUp()
	local costItemData = self.mCostItemData;
	if costItemData ~= nil then
		local goods_cost = {};
		local goods = {goods_id = costItemData[1],goods_num = costItemData[2]};
		goods_cost[1] = goods;
		local model = mGameModelManager.BagModel;
		local isEnough = model:CheckGoodsIsEnough(goods_cost);
		if isEnough then
			mKingController:SendUpdateSkill(1,self.mSelectSkillData.mSkillID);
		else
			mCommonTipsView.Show(mLgGoodsNoEnough);
		end
	end
end

function KingView:OnLoadedIcon(icon)
	if self.mIsDestory then
		return;
	end
	self.mRawImageIcon.texture = icon;
	self.mRawImageIcon.color = mColor.white;
end

function KingView:OnViewShow(logicParams)
	local model = mGameModelManager.KingModel;
	if model.mInviteRecv then
		self:InitSkills();
	else
		mKingController:SendGetSkillData(1);
	end

	local costItemData = self.mCostItemData;
	if costItemData ~= nil then
		local goodsVO = mCommonGoodsVO.LuaNew(costItemData[1],costItemData[2]);
		self.mItem:ExternalUpdate(goodsVO);
	end
end

function KingView:InitSkills()
	local model = mGameModelManager.KingModel;
	local data_soure = model.mInviteSkillList;
	self:SetSkills(data_soure);
end

function KingView:SetSkills(data_soure)
	local initFlag = self.mInitFlag;
	if initFlag then
       local data = data_soure:GetValue(self.mSelectSkillData.mSkillID);
       self:InitSkillData(data);
	else
		local gridEx = self.mSkillGridEx;
        gridEx:UpdateDataSource(data_soure,function ()
    	   local selectData = data_soure.mSortTable[1];
    	   if selectData ~= nil then
    	   	  gridEx:SetViewSelectedByKey(selectData.mSkillID,true);
    	   end
    	   self.mInitFlag = true;
        end);
	end
end

function KingView:OnSelect(data)
    self:InitSkillData(data);
end

function KingView:InitSkillData(skillData)
	self.mSelectSkillData = skillData;
	local skillConfig = skillData.mSys_vo;
	local skillLevelConfig = skillData:GetLevelConfig();
	skillMaxLevel = skillConfig.max_level;
	local isMaxLevel = skillData.mLevel >= skillMaxLevel;
	self.mGoMax:SetActive(isMaxLevel);
	self.mGoNow:SetActive(not isMaxLevel);
	self.mGoNext:SetActive(not isMaxLevel);
	self.mGoCost:SetActive(not isMaxLevel);
	self.mGoCostMax:SetActive(isMaxLevel);
	if isMaxLevel then
		self:CreateText(self.mTextMaxDesc,self.mTextMaxNum,skillData,false);
	else
		self:CreateText(self.mTextNowDesc,self.mTextNowNum,skillData,false);
		local skillLevelNextConfig = skillData:GetNextLevelConfig();
		self:CreateText(self.mTextNextDesc,self.mTextNextNum,skillData,true);
		local goodsVO = mCommonGoodsVO.LuaNew(skillLevelNextConfig.level_item[1],skillLevelNextConfig.level_item[2]);
		self.mItem:ExternalUpdate(goodsVO);
		self.mCostItemData = skillLevelNextConfig.level_item;
	end

	self.mTextName.text = skillConfig.name;
	self.mTextNameAndLevel.text = skillConfig.name..": "..skillData.mLevel.." "..mLgLevel;
	self.mTextDesc.text = skillConfig.desc;

	mUITextureManager.LoadTexture(mSkillIconPath,skillConfig.icon,self.mLoadedIcon);
end

function KingView:CreateText(textDesc,textNum,skillData,isNext)
	local skillLevelConfig;
	local isZero = false;
	if isNext then
		skillLevelConfig = skillData:GetNextLevelConfig();
	else
		if skillData.mLevel > 0 then
			skillLevelConfig = skillData:GetLevelConfig();
		else
			skillLevelConfig = skillData:GetLevelConfig(1);
			isZero = true;
		end
	end
	if skillLevelConfig ~= nil then
		local attri;
		if skillLevelConfig.base_attri ~= nil then
			attri = skillLevelConfig.base_attri;
			textDesc.text = self:GetName(attri[1].key);
		else
			attri = skillLevelConfig.king_attri;
			if attri[1].key == 8 then
				textDesc.text = mLgKingSpeedTitle;
			else
				textDesc.text = self:GetName(attri[1].key);
			end
		end
		local str = self:GetValue(attri[1].key,attri[1].value,isZero);
		textNum.text = str;
	end
end

function KingView:GetValue(id, value, isZero)
	local attri_vo = mAttributeTypeToVO.mAttriteTypeVO[id];
	
	if attri_vo.rate == 0 then
		if isZero then
			value = "+ 0";
		else
			value = "+ "..Mathf.Round(value);
		end
	else
		if isZero then
			value = "+ 0 %";
		else
			value = value * 100;
			value = Mathf.Round(value);
			value = "+ "..value..' %';
		end
	end

	return value;
end

function KingView:GetName( id )
	local attri_vo = mAttributeTypeToVO.mAttriteTypeVO[id];
	return attri_vo.name;
end

function KingView:Dispose()
	local grid_ex = self.mSkillGridEx;
	if grid_ex ~= nil then
		grid_ex:Dispose();
	end
	self.mInitFlag = false;
end

function KingView:OnViewHide()
	
end

return KingView;