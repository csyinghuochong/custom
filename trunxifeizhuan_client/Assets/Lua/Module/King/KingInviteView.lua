local mLuaClass = require "Core/LuaClass"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local mLanguage = require "Utils/LanguageUtil"
local mLayoutController = require "Core/Layout/LayoutController"
local mEventEnum = require "Enum/EventEnum"
local mUIGray = require "Utils/UIGray"
local mGameModelManager = require "Manager/GameModelManager"
local mKingController = require "Module/King/KingController"
local mCommonGoodsUseVO = require "Module/CommonUI/CommonGoodsUseVO"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mCommonGoodsUseItemView = require "Module/CommonUI/CommonGoodsUseItemView";
local mConfigSysgraceSkillLevel = require "ConfigFiles/ConfigSysgrace_skill_level"
local mConfigSysgraceSkill = require "ConfigFiles/ConfigSysgrace_skill"
local mKingAttributeItem = require "Module/King/KingAttributeItem"
local mAttributeTypeToVO = require "Module/Talent/AttributeTypeToVO"
local mStringFormat = string.format;
local mIpairs = ipairs;
local KingInviteView = mLuaClass("KingInviteView",mCommonTabBaseView);

function KingInviteView:InitViewParam()
	return {
		["viewPath"] = "ui/king/",
		["viewName"] = "grace_info_view",
	};
end

function KingInviteView:Init()
    self.mSkillDesc = self:FindComponent("skillDesc","Text");
    self.mSkillName = self:FindComponent("skillName","Text");
    self.mBtnName = self:FindComponent("btnName","Text");
    self.mExpNum = self:FindComponent("expNum","Text");
    self.mNextValue = self:FindComponent("nextValue","Text");
    self.mSliderExp = self:FindComponent("slider","Slider");
    self.mSliderAddExp = self:FindComponent("sliderAdd","Slider");
    self.mUIGray = mUIGray.LuaNew():InitGoGraphic(self:Find('graceBtn').gameObject);
    self:FindAndAddClickListener("graceBtn",function() self:OnClickBtn(); end,nil,0.5);
    local useGoodsList = {};
    for i=1,3 do
    	useGoodsList[i] = mCommonGoodsUseItemView.LuaNew(self:Find('goodsItem'..i).gameObject);
    end
    self.mUseGoodsList = useGoodsList;
    self.mSkillGridEx = mLayoutController.LuaNew(self:Find("skillGrid"), require "Module/King/KingSkillItemView");
	self:RegisterEventListener(mEventEnum.ON_SKILL_UPDATE, function()
         self:InitSkills();
    end, true);
    local attributeList = {};
    for i=1,6 do
    	attributeList[i] = mKingAttributeItem.LuaNew(self:Find(mStringFormat('attribute/attribute%d', i)).gameObject);
    end
    self.mAttributeList = attributeList;
    self:RegisterEventListener(mEventEnum.ON_SELECT_KING_SKILL, function(data)
         self:OnSelect(data);
    end, true);
    self.mGoodsList = {};
end

function KingInviteView:OnUpdateUI(data)
	local model = mGameModelManager.KingModel;
	if model.mInviteRecv then
       self:InitSkills();
	else
       mKingController:SendGetSkillData(1);
	end
end

function KingInviteView:InitSkills()
	local model = mGameModelManager.KingModel;
	local data_soure = model.mInviteSkillList;
	self:SetSkills(data_soure);
end

function KingInviteView:SetSkills(data_soure)
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

function KingInviteView:OnSelect(data)
    self:InitSkillData(data);
end

function KingInviteView:InitSkillData(skillData)
	self.mLastLevel = nil;
	self.mSelectSkillData = skillData;
	local skillConfig = skillData.mSys_vo;
	local skillLevelConfig = skillData:GetLevelConfig();
	self.mSkillDesc.text = skillConfig.desc;
	self.mSkillName.text = skillConfig.name;
	self.mExpNum.text = skillData.mExp.."/"..skillLevelConfig.level_exp;
	local sliderValue = skillData.mExp / skillLevelConfig.level_exp;
	self.mSliderExp.value = sliderValue > 0.05 and sliderValue or 0;
	self.mSliderAddExp.value = 0;
	self:SetBtnName();
	local useGoodsList = self.mUseGoodsList;
	for i=1,3 do
		local goods = skillConfig.goods[i];
		local goodsid = goods.goods_id;
		local exp = goods.goods_exp;
		local bagModel = mGameModelManager.BagModel
		local count = bagModel:GetGoodsNumberGoodsId(goodsid,bagModel.mTypeEnum.ConSumeType);
		local callBack = function (selectCount)
			self:SetGoodsBack(selectCount,goodsid,i,exp)
		end
		local goodsData = mCommonGoodsUseVO.LuaNew(goodsid,count,callBack,10);
		useGoodsList[i]:ExternalUpdate(goodsData);
	end
    self:SetAttribute(skillLevelConfig);
    self:SetNextAttribute(skillLevelConfig);

end

function KingInviteView:SetNextAttribute(skillLevelConfig)
	local skillData = self.mSelectSkillData;
	local maxLevel = skillData.mSys_vo.max_level;
	if skillData.mLevel == maxLevel then
       self.mNextValue.text = mLanguage.king_level_full;
       self.mExpNum.text = mLanguage.king_level_full;
	else
	   local valueStr = "";
	   local colorStr = "<color=#55AE57>+%s</color>";
	   if skillLevelConfig.add_attri ~= nil then
	   	  for i,v in mIpairs(skillLevelConfig.add_attri) do
	   	     if v.value ~= 0 then
	   	         local attri_vo = mAttributeTypeToVO.mAttriteTypeVO[v.key];
                 valueStr = valueStr.." "..attri_vo.name ..mStringFormat(colorStr,self:GetValue(v.key, v.value));
             end
	      end
          self.mNextValue.text = mStringFormat(mLanguage.king_next_level,valueStr);
	   end
	end
end

function KingInviteView:SetAttribute(skillLevelConfig)
	local attributeList = self.mAttributeList;
	local index = 1;
	for i,v in mIpairs(skillLevelConfig.base_attri) do
		if v.value ~= 0 and index <= 6 then
		   attributeList[index]:ShowView();
		   attributeList[index]:UpdateUI(v.key,v.value);
           index = index +1;
		end
	end
	for i=index,6 do
		attributeList[i]:HideView();
	end
end

function KingInviteView:GetValue(id, value)
	local attri_vo = mAttributeTypeToVO.mAttriteTypeVO[id];
	
	if attri_vo.rate == 0 then
		value = Mathf.Round(value);
	else
		value = value * 100;
		value = Mathf.Round(value);
		value = value..'%';
	end

	return value;
end

function KingInviteView:SetGoodsBack(goodsCount,goodsId,index,goodExp)
	self.mGoodsList[index] = {id = goodsId,count = goodsCount,exp = goodExp};
	self:SetAddExp();
end

function KingInviteView:SetAddExp()
	local skillData = self.mSelectSkillData;
	local goodsList = self.mGoodsList;
	local exp = 0;
	local haveExp = skillData.mExp;
	for i,v in mIpairs(goodsList) do
		exp = exp + v.exp * v.count;
	end
    self.mUIGray:SetGray(exp == 0);
	exp = exp + haveExp;
	local lastLevel = self.mLastLevel ~= nil and self.mLastLevel or skillData.mLevel;
	local currentExp,levelUpExp,endLevel = self:JustExp(exp,skillData.mLevel);
	self.mExpNum.text = currentExp.."/"..levelUpExp;
	if endLevel ~= lastLevel then
	   self.mLastLevel = endLevel;
       self.mSliderExp.value = 0;
       local key = mStringFormat("%d_%d", endLevel, skillData.mSkillID);
       self:SetAttribute(mConfigSysgraceSkillLevel[key]);
       self:SetNextAttribute(mConfigSysgraceSkillLevel[key]);
	end
	if endLevel == skillData.mLevel then
		local sliderValue = haveExp / levelUpExp;
		self.mSliderExp.value = sliderValue > 0.05 and sliderValue or 0;
    end
    local sliderAddValue = currentExp / levelUpExp;
	self.mSliderAddExp.value = sliderAddValue > 0.05 and sliderAddValue or 0;
end

--递归
function KingInviteView:JustExp(exp,level)
	local skillId = self.mSelectSkillData.mSkillID;
	local key = mStringFormat("%d_%d", level, skillId);
	local levelUpExp = mConfigSysgraceSkillLevel[key].level_exp;
	if exp > levelUpExp then
       local maxLevel = self.mSelectSkillData.mSys_vo.max_level;
       if level < maxLevel then
          return self:JustExp(exp - levelUpExp,level + 1);
       else
          return levelUpExp,levelUpExp,level;
       end
	else
       return exp,levelUpExp,level;
	end
end

function KingInviteView:SetBtnName()
	self.mBtnName.text = mLanguage.king_invite;
end

function KingInviteView:OnClickBtn()
	local sendList = {};
	local flag = true;
	for i,v in mIpairs(self.mGoodsList) do
		if v.count > 0 then
		   flag = false;
           local data = {id = v.id,count = v.count};
           table.insert(sendList,data);
		end
	end
	if flag then
       mCommonTipsView.Show(mLanguage.king_select_goods);
	else
	   local data = self.mSelectSkillData;
	   mKingController:SendUpdateSkill(data.mSys_vo.skill_type,data.mSkillID,sendList);
    end
end

function KingInviteView:Dispose()
   	local grid_ex = self.mSkillGridEx;
	if grid_ex ~= nil then
		grid_ex:Dispose();
	end
	self.mInitFlag = false;
end

return KingInviteView;