local mUIGray = require "Utils/UIGray"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mCommonLongClick = require "Module/CommonUI/CommonLongClick"
local CommonSkillItemView = mLuaClass("CommonSkillItemView", mLayoutItem);
local mVector3 = Vector3;
local mSuper;
local mColor = Color;
local mSkillIconPath = mResourceUrl.skill_icon;

function CommonSkillItemView:OnLuaNew( go, call_back)
	self.mCallBack = call_back;

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
   	mSuper.OnLuaNew(self,go);
end

function CommonSkillItemView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "common_skill_item_view",
	};
end

function CommonSkillItemView:Init()
	local lock = self:Find('no_active');
	if lock ~= nil then
		self.mLockObj = lock.gameObject;
	end

	self.mImageIcon = self:FindComponent('Imange_icon', 'RawImage');
	self.mImageIcon.color = mColor.clear;

	self.mUIGray = mUIGray.LuaNew():InitGoGraphics(self.mGameObject);

	local textLevel = self:Find('Text_lv');
	if textLevel ~= nil then
		self.mTextLevel = textLevel:GetComponent('Text');
	end

	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end
    self.mObj = self:Find("Image_bg").gameObject;
    local button = self:FindComponent('Image_bg', 'Button');
	if button ~= nil then
		self:AddBtnClickListener(self.mObj, function() self:OnClick() end);
	end

	mSuper.Init(self);
end

function CommonSkillItemView:OnUpdateData()
	self:ExternalUpdate(self.mData);
end

function CommonSkillItemView:ExternalUpdate(skill_vo, forbid_long_click)
	if skill_vo == nil then
       return;
	end
	self.mData = skill_vo;
	local level = skill_vo.mLevel;
	local lockObj = self.mLockObj;
	local isActive = skill_vo:IsActive();
	if lockObj ~= nil then
		lockObj:SetActive(not isActive);
	end
	self.mUIGray:SetGray(not isActive);
	local textLevel = self.mTextLevel;
	if textLevel ~= nil then
		textLevel.text = ( level > 0 and isActive )and level or ''; 
	end
	self.mImageIcon.color = mColor.clear;
	mUITextureManager.LoadTexture(mSkillIconPath, skill_vo.mSkillInfo.icon,self.mLoadedIcon);

	if forbid_long_click ~= false then
		self:AddLongClick( skill_vo );
	end
end

function CommonSkillItemView:AddLongClick( skill_vo )
	if skill_vo.mIsDetial and self.mObj then
		mCommonLongClick.LuaNew(self.mObj,1,skill_vo.mID,0,0.5);
	end
end

function CommonSkillItemView:OnLoadedIcon(icon)
	self.mImageIcon.texture = icon;
	self.mImageIcon.color = mColor.white;
end

function CommonSkillItemView:OnClick()
	local data = self.mData;
	local call_back = self.mCallBack;
	if call_back ~= nil and data ~= nil then
		self:PlaySoundName("ty_0204");
		call_back(data);
	end
end

return CommonSkillItemView;