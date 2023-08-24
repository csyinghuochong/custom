local mLuaClass = require "Core/LuaClass"
local mBattleActorItemView = require "Module/BattleArray/BattleActorItemView"
local EndlessBattleActorItemView = mLuaClass("EndlessBattleActorItemView",mBattleActorItemView);
local mSuper = nil;

function EndlessBattleActorItemView:Init()
	mSuper = self:GetSuper(mBattleActorItemView.LuaClassName);
    mSuper.Init(self);

    self.mImgBlood = self:FindComponent("blood","Image");
    self.mBloodLightImage = self:FindComponent('bloodLight', 'Image');
    self.mBloodBack = self:FindComponent('bloodBack', 'Image');
end

function  EndlessBattleActorItemView:SetData(vo)
	self.mData = vo;
	local followerItem = self.mFollowerItem;
	if vo ~= nil then
		followerItem:ShowView();
		followerItem:ExternalUpdateData(vo);
		self.mImgBlood.gameObject:SetActive(true);
		self.mBloodLightImage.gameObject:SetActive(true);
		self.mBloodBack.gameObject:SetActive(true);
		self:SetBlood();
	else
		followerItem:HideView();
		self.mImgBlood.gameObject:SetActive(false);
		self.mBloodLightImage.gameObject:SetActive(false);
		self.mBloodBack.gameObject:SetActive(false);
	end
end

function EndlessBattleActorItemView:SetBlood()
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
end

return EndlessBattleActorItemView;