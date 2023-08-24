local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mBattleFollowerItemView = require "Module/BattleArray/BattleFollowerItemView"
local EndlessMeirenArrayItemView = mLuaClass("EndlessMeirenArrayItemView",mBattleFollowerItemView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mSuper = nil;

function EndlessMeirenArrayItemView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_array_item_view",
	};
end

function EndlessMeirenArrayItemView:Init()
    self.mDead = self:Find("dead").gameObject;
    self.mBloodImage = self:FindComponent('blood', 'Image');
    self.mBloodLightImage = self:FindComponent('bloodLight', 'Image');
	  mSuper = self:GetSuper(mBattleFollowerItemView.LuaClassName);
	  mSuper.Init(self);
end

function EndlessMeirenArrayItemView:ClickFollowerItem()
	  if self.mData:GetMeirenCurrentHp() > 0 then
       local data = self.mData;
       local followerData = self.mFollowerData;
       followerData.follower = data;
       followerData.state = not self.mIsSelectd;
       self:DispatchFollowerData(followerData);
	  else
       mCommonTipsView.Show(mLanguageUtil.follower_die);
	  end
end

function  EndlessMeirenArrayItemView:UpdateUI()
	  mSuper.UpdateUI(self);
    local currentHp = self.mData:GetMeirenCurrentHp();



    self.mDead:SetActive(currentHp <= 0);
    if currentHp <= 0 then
       self.mImageSelect:SetActive(false);
    end
    local hp = self.mData.mTotalAttri[1];
    local hpPercent = currentHp / hp;
    self.mBloodImage.fillAmount = hpPercent;
    self.mBloodLightImage.fillAmount = hpPercent;
    if hpPercent <= 0.3 then
       self.mGameObjectUtil:SetImageSprite(self.mBloodImage,"endless_level2_bar2");
    elseif 0.3 < hpPercent and hpPercent <= 0.5 then
       self.mGameObjectUtil:SetImageSprite(self.mBloodImage,"endless_level2_bar3");
    elseif hpPercent > 0.5 then
       self.mGameObjectUtil:SetImageSprite(self.mBloodImage,"endless_level2_bar1");
    end
end

return EndlessMeirenArrayItemView;
