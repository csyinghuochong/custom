local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mBaseView = require "Core/BaseView"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mConfigSysskill = require "ConfigFiles/ConfigSysskill"
local mConfigSysfollower = require "ConfigFiles/ConfigSysactor"
local mConfigSysfashion = require "ConfigFiles/ConfigSysfashion"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local GameObject = UnityEngine.GameObject;
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mConfigSysfollower_office_up = require "ConfigFiles/ConfigSysfollower_office_up"

local FriendDetailView = mLuaClass("FriendDetailView", mBaseWindow);
function FriendDetailView:InitViewParam()
	return {
		["viewPath"] = "ui/friend/",
		["viewName"] = "friend_detail_view",
		["ParentLayer"] = mFollowerSelectLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function FriendDetailView:Init()
	self.mTextName = self:FindComponent("Left/Text_name","Text");
	self.mModelFeature = self:Find('Left/model');

	self:FindAndAddClickListener("c_bg/Button_close", function() self:HideView() end);	

	local parentSkill = self:Find('Right/skillScrollView/Grid');
	self.mGridExSkill = mLayoutController.LuaNew(parentSkill, require "Module/Friend/FriendDetailSkillItem");
	local parentFollower = self:Find('Right/followerScrollView/Grid');
	self.mGridExFollower = mLayoutController.LuaNew(parentFollower, require "Module/Friend/FriendDetailFollowerItem");
	local parentFashion = self:Find('Right/fashionScrollView/Grid');
	self.mGridExFashion = mLayoutController.LuaNew(parentFashion, require "Module/Friend/FriendDetailFashionItem");
	local parentStone = self:Find('Right/stoneScrollView/Grid');
	self.mGridExStone = mLayoutController.LuaNew(parentStone, require "Module/Friend/FriendDetailStoneItem");

	self.mLeadNode = self:Find('Left/model').gameObject;
end

function FriendDetailView:OnViewShow(logicParams)
	self.mTextName.text = logicParams.name;

	local leadNode = self.mLeadNode;
	leadNode:SetActive(true);

	local data_soureSkill = mSortTable.LuaNew();
	for i = 1, 4 do
		local skillData = {id = 1101040+i};
		data_soureSkill:AddOrUpdate(i,skillData);
	end
	self.mGridExSkill:UpdateDataSource(data_soureSkill);

	local data_soureFollower = mSortTable.LuaNew();
	for j = 1, 5 do
		data_soureFollower:AddOrUpdate(j,mConfigSysfollower[10001+j*1000]);
	end
	self.mGridExFollower:UpdateDataSource(data_soureFollower);

	local data_soureFashion = mSortTable.LuaNew();
	for k = 1, 5 do
		data_soureFashion:AddOrUpdate(k,mConfigSysfashion[1001000+k]);
	end
	self.mGridExFashion:UpdateDataSource(data_soureFashion);

	local data_soureStone = mSortTable.LuaNew();
	for l = 1, 5 do
		data_soureStone:AddOrUpdate(l,mCommonGoodsVO.LuaNew(1001111+l,1));
	end
	self.mGridExStone:UpdateDataSource(data_soureStone);
end

function FriendDetailView:LoadModleComplete(obj)
	local model = self.mModelObj;
	if model ~= nil then
		GameObject.DestroyImmediate(model);
	end

	self.mModelObj = obj;
	mGameObjectUtil:SetParent(obj.transform, self.mModelFeature);
end

function FriendDetailView:Dispose()
	self.mGridExSkill:Dispose();
	self.mGridExFollower:Dispose();
	self.mGridExFashion:Dispose();
	self.mGridExStone:Dispose();
end

return FriendDetailView;