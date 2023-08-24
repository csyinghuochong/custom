local mLayoutItem = require "Core/Layout/LayoutItem"
local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mSkillIconPath = mResourceUrl.skill_icon;
local mLanguage = require "Utils/LanguageUtil"
local mGameModelManager = require "Manager/GameModelManager"
local KingSkillItemView = mLuaClass("KingSkillItemView", mLayoutItem);
local mSuper = nil;

function KingSkillItemView:InitViewParam()
	return {
		["viewPath"] = "ui/king/",
		["viewName"] = "king_skill_item_view",
	};
end

function KingSkillItemView:Init()
	self.mOpenStr = self:Find("open"):GetComponent('Text');
	self.mLv = self:Find("lv"):GetComponent('Text');
	self.mOpen = self:Find("open").gameObject;
	self.mLvBack = self:Find("Image").gameObject;
    local callBack = function() self:OnClickItem() end;
    self:FindAndAddClickListener("icon", callBack);
    self.mSkillIcon = self:FindComponent('icon', 'RawImage');

	self.mLoadedIcon = function (icon)
		self:OnLoadedIcon(icon);
	end
	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function KingSkillItemView:OnClickItem()
    self:SetSelected(true);
end

function  KingSkillItemView:OnSelected(select)
	if select then
       self:Dispatch(mEventEnum.ON_SELECT_KING_SKILL,self.mData);
	end
end

function KingSkillItemView:OnUpdateData()
	self:ExternalUpdate(self.mData);
end

function KingSkillItemView:ExternalUpdate(data)
	if data == nil then
		return;
	end
	local config = data.mSys_vo;
    mUITextureManager.LoadTexture(mSkillIconPath, config.icon,self.mLoadedIcon);
    local level = mGameModelManager.RoleModel.mPlayerBase.level;
    self.mOpen:SetActive(level < config.open_level);
    self.mLvBack:SetActive(level >= config.open_level);
    self.mLv.text = data.mLevel;
    if level < config.open_level then
       self.mOpenStr.text = string.format(mLanguage.common_open_level,config.open_level);
       self.mLv.text = "";
    end
end

function KingSkillItemView:OnLoadedIcon(icon)
	self.mSkillIcon.texture = icon;
end

return KingSkillItemView;