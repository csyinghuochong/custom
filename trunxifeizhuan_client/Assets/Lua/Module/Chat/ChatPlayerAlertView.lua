local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local ChatPlayerAlertView = mLuaClass("ChatPlayerAlertView", mBaseWindow);
local mFriendController = require "Module/Friend/FriendController"
local mCheckController = require "Module/Check/CheckController"
local mGameModelManager = require "Manager/GameModelManager"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local mRoleIconPath = mResourceUrl.role_icon;

function ChatPlayerAlertView.Show(data)
	mUIManager:HandleUI(mViewEnum.ChatPlayerAlertView, 1, data);
end

function ChatPlayerAlertView:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "chat_player_alert_view",
		["ParentLayer"] = mCommonChatLayer1,
		["viewBgEnum"] = mViewBgEnum.gray_clickable,
	};
end

function ChatPlayerAlertView:Init()
	self.mTextName = self:FindComponent("Text/TextName","Text");
	self.mTextPosition = self:FindComponent("Text/TextPosition","Text");
	self.mTextLevel = self:FindComponent("Head/Level","Text");
	self.mImgIcon = self:FindComponent("Head/Head","RawImage");
	self.mImgIcon.color = Color.clear;
	self.mImgHeadBack = self:FindComponent('Head/Back','Image');
	self.mImgHeadBord = self:FindComponent('Head/Bord','Image');
	self:FindAndAddClickListener("Btn/BtnCheck", function() self:OnClickBtnCheck() end,"ty_0203");
	self:FindAndAddClickListener("Btn/BtnFriend", function() self:OnClickBtnFriend() end,"ty_0203");
	self:FindAndAddClickListener("Btn/BtnUnlook", function() self:OnClickBtnUnlook() end,"ty_0203");
	self:FindAndAddClickListener("Btn/BtnPrivate", function() self:OnClickBtnPrivate() end,"ty_0203");

	self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end
end

function ChatPlayerAlertView:OnViewShow(logicParams)
	self.mData = logicParams;
	local data = logicParams;

	self.mTextName.text = data.player_name;
	self.mTextPosition.text = self:GetPositionStr(data.sex,data.position);
	self.mTextLevel.text = data.level;

	if data.sex == 1 then
		mUITextureManager.LoadTexture(mRoleIconPath, "role_10103",self.mLoadedIcon);
	else
		mUITextureManager.LoadTexture(mRoleIconPath, "role_10201",self.mLoadedIcon);
	end

	if data.position >= 7 then
		self.mGameObjectUtil:SetImageSprite(self.mImgHeadBord,"common_bag_iconframe_7");
		self.mGameObjectUtil:SetImageSprite(self.mImgHeadBack,"common_bag_iconframe_7s");
	else
		self.mGameObjectUtil:SetImageSprite(self.mImgHeadBord,"common_bag_iconframe_"..data.position);
		self.mGameObjectUtil:SetImageSprite(self.mImgHeadBack,"common_bag_iconframe_"..data.position.."s");
	end
end

function ChatPlayerAlertView:GetPositionStr(sex,position)
	if sex == 1 then
		return mConfigSyspromote[position].man_name;
	else
		return mConfigSyspromote[position].woman_name;
	end
end

function ChatPlayerAlertView:OnClickBtnCheck()
	local data = self.mData;
	mCheckController:SendGetOtherPlayer(data.player_id);
	self:HideView();
end

function ChatPlayerAlertView:OnClickBtnFriend()
	local data = self.mData;
	mFriendController:SendAddFriend(data.player_id);
	self:HideView();
end

function ChatPlayerAlertView:OnClickBtnUnlook()
	local data = self.mData;
	mFriendController:SendAddBlackList(data.player_id);
	self:HideView();
end

function ChatPlayerAlertView:OnClickBtnPrivate()
	local data = self.mData;
	local mEvent = self.mEventEnum;
	self:Dispatch(mEvent.ON_CHAT_TO_PLAYER,data);
	self:HideView();
end

function ChatPlayerAlertView:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = Color.white;
end

function ChatPlayerAlertView:Dispose()
end

return ChatPlayerAlertView;