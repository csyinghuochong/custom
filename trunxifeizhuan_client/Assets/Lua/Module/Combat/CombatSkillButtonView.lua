local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local CombatSkillButtonView = mLuaClass("CombatSkillButtonView", mBaseView);
local CommonButtonEventListener = require "Module/CommonUI/CommonButtonEventListener"
local Vector3 = Vector3;
local mOffset = Vector3.New(-90,0,0);
local mCDColor = Color.New(0.5,0.5,0.5,1);
local mNormalColor = Color.New(1,1,1,1);
local mColor = Color;

local Application = UnityEngine.Application;
local mResourceManager = ResourceManager;
local mIsEditor = Application.isEditor;
local mTextureType = typeof(UnityEngine.Texture);
local mSkillIconPath = mResourceUrl.skill_icon;

function CombatSkillButtonView:Init()
	self.mTextCd = self:FindComponent('cd', 'Text');
	self.mImageFrame = self:FindComponent("frame","Image");
	self.mSelectedView = self:Find('selected').gameObject;

	local icon = self:FindComponent('icon', 'RawImage');
	self.mIcon = icon;

	self:SetSelected(self.mSelected or false);
	local parent = self.mTransformParent;
	if parent then
		self:SetPosition(parent,self.mIndex);
	end

	local skill = self.mSkill;
	if skill then
		self:UpdateView(skill);
	end

	self.mLoadedIcon = function (tex)
		self:OnLoadedIcon(tex);
	end

	local pressCallback = function(flag)
		self:OnPress(flag);
	end

	local holdCallback = function ()
		self:OnHold();
	end

	local btn = CommonButtonEventListener.LuaNew(icon.gameObject,0.75,pressCallback,holdCallback);
	btn.mNotCallOnExit = true;
end


function CombatSkillButtonView:OnPress(flag)

	local onPress = self.mOnPress;
	if onPress then
		onPress(self,flag);
	end

end

function CombatSkillButtonView:OnHold()

	local onHold = self.mOnHold;
	if onHold then
		onHold(self);
	end

end

function CombatSkillButtonView:SetSelected(state)
	self.mSelected = state;

	local selectedView = self.mSelectedView;
	if selectedView then
		selectedView:SetActive(state);
	end
end

function CombatSkillButtonView:UpdateData(skill)
	self.mSkill = skill;

	if self.mGameObject and skill then
		self:UpdateView(skill);
	end

end

function CombatSkillButtonView:OnLoadedIcon(tex)
	self.mIcon.texture = tex;
end

function CombatSkillButtonView:UpdateView(skill)
	local state = skill:GetState();
	local cd = state.mCDTotalTime - state.mTimeSinceSkillStart + 1;

	local textCd = self.mTextCd;
	textCd.gameObject:SetActive(cd>0);
	if cd > 0 then
		textCd.text = cd;
		self.mIcon.color = mCDColor;
		self.mImageFrame.color = mCDColor;
	else
		self.mIcon.color = mNormalColor;
		self.mImageFrame.color = mNormalColor;
	end

	local icon = skill.mIcon;
	if icon then
		mUITextureManager.LoadTexture(mSkillIconPath, icon,self.mLoadedIcon);
	end
end

function CombatSkillButtonView:SetPosition(parent,index)
	self.mTransformParent = parent;
	self.mIndex = index;

	local transform = self.mTransform;
	if transform then
		transform:SetParent(parent);
		transform.localPosition = mOffset*(index-1);
		transform.localScale = Vector3.one;
	end
end

return CombatSkillButtonView;