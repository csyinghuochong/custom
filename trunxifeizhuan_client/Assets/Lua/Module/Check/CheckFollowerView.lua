local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mLayoutController = require "Core/Layout/LayoutController"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local mSortTable = require "Common/SortTable"
local mGameModelManager = require "Manager/GameModelManager"
local mFollowerListView = require "Module/Follower/FollowerListView"
local mFollowerAttributeView = require "Module/Follower/FollowerAttributeView"
local mString = string;
local CheckFollowerView = mLuaClass("CheckFollowerView", mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgLevel = mLanguageUtil.level;
local mLgCombat = mLanguageUtil.common_combat;
function CheckFollowerView:InitViewParam()
	return {
		["viewPath"] = "ui/check/",
		["viewName"] = "check_follower_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function CheckFollowerView:Init()
	self:FindAndAddClickListener("c_bg/Button_close",function()self:OnClickClose();end);

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_OTHERS_FOLLOWER, function(vo)
		self:OnClickFollowerItem(vo);
	end, true);

	self:InitLeft();
	self:InitRight();
end

function CheckFollowerView:InitLeft()
	self.mModelShowView = mModelShowView.LuaNew(self:Find('model'));
	self.mTextName = self:FindComponent('featureView/Text_name', 'Text');
	self.mTextType = self:FindComponent('featureView/Text_type', 'Text');
	self.mTextCombat = self:FindComponent('featureView/Text_combat', 'Text');
	self.mTypeState = self:FindComponent('featureView/Image_type','GameImage');

	local star_list = {};
	for i = 1, 6 do
		local go = self:Find('featureView/star/'..i).gameObject;
		star_list[i] = go;
	end
	self.mStarList = star_list;
end

function CheckFollowerView:InitRight()
	self.mTextExp = self:FindComponent('follower_info/Text_exp', 'Text');
	self.mTextOffice = self:FindComponent('follower_info/Text_office', 'Text');
	self.mSlider = self:FindComponent('follower_info/Slider_exp/Slider','Slider');

	self.mAttributeView = mFollowerAttributeView.LuaNew(self:Find('follower_info/follower_attri_view').gameObject);
	local parentSkill = self:Find('follower_info/scrollViewSkill/Grid');
	self.mGridSkill = mLayoutController.LuaNew(parentSkill, require 'Module/Check/CheckSkillItem');
end

function CheckFollowerView:OnClickClose()
	self:ReturnPrevQueueWindow();
end

function CheckFollowerView:OnClickFollowerItem(data)
	self.mFollowerData = data;
	self.mFollowerListView:OnClickFollowerItem(data);
	self:UpdateData(data)
end

function CheckFollowerView:UpdateData(data)
	self:UpdateLeft(data);
	self:UpdateRight(data);
end

function CheckFollowerView:UpdateLeft(data)
	self.mModelShowView:OnUpdateVO(data );
	local star = data:GetStar();
	local star_list = self.mStarList;
	for i =1, 6 do
		star_list[i]:SetActive(i <= star);
	end

	local type_name, type_icon = data:GetTypeInfo();
	self.mTextName.text = data:GetName();
	self.mTextType.text = type_name;
	self.mTextCombat.text = mLgCombat..data:GetCombat();
	self.mTypeState:SetSprite(type_icon);
end

function CheckFollowerView:UpdateRight(data)
	local maxExp = data:GetCurLVMaxExp();
	self.mTextOffice.text = mString.format('%s<color=#c98c25>（%d%s）</color>', data:GetOfficeName(), data:GetLevel(), mLgLevel);
	self.mTextExp.text =mString.format('%d/%d', data:GetExp(), maxExp);
	self.mSlider.value = (data:GetExp() / maxExp)*100;
	self.mAttributeView:OnUpdateUI(data);
	local data_soure = mSortTable.LuaNew(nil,nil,true);
	for k,v in pairs(data.mSkillList) do
		v.mIsDetial = true;
		data_soure:AddOrUpdate(v.mID,v);
	end
	self.mGridSkill:UpdateDataSource(data_soure);
end

function CheckFollowerView:OnViewShow(data)
	self.mModelShowView:ShowView();
	local model = mGameModelManager.CheckModel;
	self.mFollowerListView = mFollowerListView.LuaNew(model.mDataSoureFollower1, self:Find('listView'));
	self.mFollowerListView:ShowView();
end

function CheckFollowerView:OnViewHide()
	self.mModelShowView:HideView();
	self.mFollowerListView:HideView();
end

function CheckFollowerView:Dispose()
	self.mFollowerListView:CloseView();
	self.mGridSkill:Dispose();
end

return CheckFollowerView;