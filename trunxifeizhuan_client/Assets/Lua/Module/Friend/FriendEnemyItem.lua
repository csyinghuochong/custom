local mLuaClass = require "Core/LuaClass"
local mUIGray = require "Utils/UIGray"
local mLayoutItem = require "Core/Layout/LayoutItem"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mAssetManager = require "AssetManager/AssetManager"
local mTimeUtil = require "Utils/TimeUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mGameTimer = require "Core/Timer/GameTimer"
local FriendEnemyItem = mLuaClass("FriendEnemyItem",mLayoutItem);
local mSuper = nil;
local mColor = Color
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgPower = mLanguageUtil.friend_info_power;
local mLgLevel = mLanguageUtil.friend_info_level;

local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"

function FriendEnemyItem:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_blacklist_item_view",
	};
end

function FriendEnemyItem:Init( )
	self.mTextName = self:FindComponent('Middle/Name','Text');
	self.mTextPost = self:FindComponent('Middle/Post','Text');
	self.mTextPower = self:FindComponent('Middle/Power','Text');
	self.mTextTime = self:FindComponent('Middle/Time','Text');
	self.mImgSex = self:FindComponent('Middle/Sex','GameImage');
	local goPlayer = self:Find("Left/Player").gameObject;
	self.mPLayer = mCommonPlayerHeadView.LuaNew(goPlayer);
	
	local deleteCallBack = function() self:OnClickBtn(); end;
	local btn = self:Find('Right/Delete').gameObject;
	self:AddBtnClickListener(btn, deleteCallBack);

	self:FindAndAddClickListener("Left/Player/Icon",function()self:OnClickHead();end);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end


function FriendEnemyItem:OnClickBtn( )
	local detail = self.mData;
	local mEvent = self.mEventEnum;
	self:Dispatch(mEvent.ON_OPEN_ENEMY_DELETE_POPUP,detail);
end

function FriendEnemyItem:OnClickHead()
	local detail = self.mData;
	local mEvent = self.mEventEnum;
	self:Dispatch(mEvent.ON_CHECK_PLAYER,detail.id);
end

function FriendEnemyItem:OnViewShow( )
	
end

function FriendEnemyItem:OnUpdateData()
	local  data = self.mData;
	self.mTextName.text = data.name;
	self.mTextPost.text = self:GetPositionStr(data.sex,data.position);
	self.mTextPower.text = mLgPower..data.combat;

	if data.online == 1 then
		self.mTextTime.gameObject:SetActive(false);
	else
		self.mTextTime.gameObject:SetActive(true);
		local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
		local second = currentTime - data.last_online_time;
		if second >= 86400 then
			self.mTextTime.text = mTimeUtil:TransToDay(second);
		elseif second >= 3600 then
			self.mTextTime.text = mTimeUtil:TransToHour(second);
		else
			self.mTextTime.text = mTimeUtil:TransToMin(second);
		end
	end
	
	self.mPLayer:SetInfo(data.sex,data.position,data.level);

	self:SetSexIconPos(data);
end

function FriendEnemyItem:SetSexIconPos(data)
	local namePosX = self.mTextName.transform.localPosition.x;
	local nameWidth = self.mTextName.preferredWidth;
	local sexIconWidth = 10;
	local sexIconPosY = self.mImgSex.transform.localPosition.y;
	local x = namePosX + nameWidth + sexIconWidth;
	self.mImgSex.transform.anchoredPosition = Vector2(x,sexIconPosY);
	if data.sex == 1 then
		self.mImgSex:SetSprite("friend_icon_boy");
	else
		self.mImgSex:SetSprite("friend_icon_girl");
	end
end

function FriendEnemyItem:GetPositionStr(sex,position)
	local str;
	if sex == 1 then
		str = mConfigSyspromote[position].man_name;
	else
		str = mConfigSyspromote[position].woman_name;
	end
	return str;
end

return FriendEnemyItem;