local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mGameTimer = require "Core/Timer/GameTimer"
local mCDColorCode = "<color=#00FF00>%s</color>";
local mLanguage = require "Utils/LanguageUtil"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mGameModelManager = require "Manager/GameModelManager"
local CombatSkillButtonView = require "Module/Combat/CombatSkillButtonView"
local CombatSkillView = mLuaClass("CombatSkillView",mBaseView);
local Object = UnityEngine.Object;
local mTable = require "table"
local ipairs = ipairs;
local string = string;

function  CombatSkillView:Init()
	self.mPrefab = self:Find("skill_button_view").gameObject;

	self.mOnPressButton = function (button,flag)
		self:OnPressButton(button,flag);
	end
	self.mOnHoldButton = function (button)
		self:OnHoldButton(button);
	end

	self.mInfoView = self:Find("skill_info_view").gameObject;
	self.mTextSkilName = self:FindComponent("skill_info_view/name","Text");
	self.mTextSkillDesc = self:FindComponent("skill_info_view/desc","Text");
	self.mInfoRectTransform = self.mInfoView:GetComponent("RectTransform");
end

function CombatSkillView:HideButtonViews()
	local buttonViews = self.mButtonViews;
	if buttonViews then
		for i,v in ipairs(buttonViews) do
			v:HideView();
		end
	end
end

function CombatSkillView:SetSkillEffect( effet_node )
	self.mEffectNode = effet_node;
end

function CombatSkillView:ShowButtonViews(actor)
	local skills = actor:GetSkills();
	local buttonViews = self.mButtonViews;
	if not buttonViews then
		buttonViews = {};
		self.mButtonViews = buttonViews;
	end

	local transform = self.mTransform;
	local prefab = self.mPrefab;
	local passivitySkill = nil;
	for i,v in ipairs(skills) do
		local buttonView = buttonViews[i];
		if not buttonView then
			buttonView = CombatSkillButtonView.LuaNew(Object.Instantiate(prefab));
			buttonView:SetPosition(transform,i);
			buttonView.mOnPress = self.mOnPressButton;
			buttonView.mOnHold = self.mOnHoldButton;
			buttonView.mGameObject.name = "Guide_fight_skill_"..i;
			buttonViews[i] = buttonView;
		end
		buttonView:UpdateData(v);
		buttonView:ShowView(v);

		if v.mPassive then
			passivitySkill = buttonView;
		end
	end

	local effect_node = self.mEffectNode;
	effect_node.gameObject:SetActive( passivitySkill ~= nil );
	if passivitySkill then
		mGameObjectUtil:SetParent(effect_node, passivitySkill.mTransform);
		effect_node:SetSiblingIndex( 1 );
	end

	local defalutSkill = buttonViews[1];
	if defalutSkill then
		local last = self.mSelectedButton;
		if last and last == defalutSkill then
			self.mSelectedButton = nil;
		end
		self:OnClickButton(defalutSkill);
	end
end

function CombatSkillView:OnClickButton(button)
	if mGameModelManager.GuideModel.mRunCount ~= 0 then
    	self:Dispatch(mEventEnum.ON_RUN_NEXT_STEP);
    end
	local last = self.mSelectedButton;

	if last == button then
		return;
	end

	local skill = button.mSkill;

	if skill:CanUse() == false then
		return ;
	end

	if last then
		last:SetSelected(false);
	end

	button:SetSelected(true);
	self.mSelectedButton = button;

	self:Dispatch(mEventEnum.ON_PLAYER_SELECT_SKILL,skill);
end

function CombatSkillView:OnPressButton(button,flag)

	if flag then
		self:OnClickButton(button);
	else
		if self.mSkillInfo then
			mGameTimer.SetTimeout(0.5,function()
				self.mInfoView:SetActive(false);
				self.mSkillInfo = nil;
				end);
		end
	end

end

function CombatSkillView:OnHoldButton(button)
	self:ShowSkillInfo(button.mSkill);
end

function CombatSkillView:UpdateInfoViewHeight(text)
	local rectTransform = self.mInfoRectTransform;
    local size = rectTransform.sizeDelta;
    size.y = text.preferredHeight + 80;
    rectTransform.sizeDelta = size;
end

function CombatSkillView:ShowSkillInfo(skill)
	if self.mSkillInfo ~= skill then
		self.mSkillInfo = skill;
		if skill then
			local cdInfo = "";
			if skill.mPassive then
				cdInfo = string.format(mCDColorCode,mLanguage.combat_passive);
				elseif skill.mCd > 0 then
					cdInfo = string.format(mCDColorCode,string.format(mLanguage.combat_cd,skill.mCd));
				end
			local textSkillDesc = self.mTextSkillDesc;
			textSkillDesc.text = skill.mData:GetDescribe()..cdInfo;
			self.mTextSkilName.text = skill.mName;
			self:UpdateInfoViewHeight(textSkillDesc);
			self.mInfoView:SetActive(true);
		end
	end
end

function CombatSkillView:UpdateView(actor)
	self.mActor = actor;
	self:HideButtonViews();
	self:ShowButtonViews(actor);
end

function CombatSkillView:Dispose()
	local buttonViews = self.mButtonViews;
	if buttonViews then
		for i,v in ipairs(buttonViews) do
			v:CloseView();
		end
		self.mButtonViews = nil;
	end

end

return CombatSkillView;