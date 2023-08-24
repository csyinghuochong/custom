local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mBattleFollowerItemView = require "Module/BattleArray/BattleFollowerItemView"
local CommonButtonEventListener = require "Module/CommonUI/CommonButtonEventListener"
local EndlessFollowerListArrayItemView = mLuaClass("EndlessFollowerListArrayItemView",mBattleFollowerItemView);
local mSuper = nil;

function EndlessFollowerListArrayItemView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_follower_list_array_item_view",
	};
end

function EndlessFollowerListArrayItemView:Init()
	self.mImgBlood = self:FindComponent("blood","Image");
    self.mBloodLightImage = self:FindComponent('bloodLight', 'Image');
    self.mGoDead = self:Find("dead").gameObject;
	mSuper = self:GetSuper(mBattleFollowerItemView.LuaClassName);
	mSuper.Init(self);
end

function  EndlessFollowerListArrayItemView:UpdateUI()
	mSuper.UpdateUI(self);
	self:SetBlood();
end

function EndlessFollowerListArrayItemView:SetBlood()
	local data = self.mData;
	local currentHp = data:GetMeirenCurrentHp();
	local hp = data.mTotalAttri[1];
    local hpPercent = currentHp / hp;
    self.mImgBlood.fillAmount = hpPercent;
    self.mBloodLightImage.fillAmount = hpPercent;
    if hpPercent <= 0.3 then
       self.mGameObjectUtil:SetImageSprite(self.mImgBlood,"endless_level2_bar2");
    elseif 0.3 < hpPercent and hpPercent <= 0.5 then
       self.mGameObjectUtil:SetImageSprite(self.mImgBlood,"endless_level2_bar3");
    elseif hpPercent > 0.5 then
       self.mGameObjectUtil:SetImageSprite(self.mImgBlood,"endless_level2_bar1");
    end

    self.mGoDead:SetActive(currentHp <= 0);
end

return EndlessFollowerListArrayItemView;