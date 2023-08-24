local mLuaClass = require "Core/LuaClass"
local mSortTable = require "Common/SortTable"
local mLayoutController = require "Core/Layout/LayoutController"
local mFollowerBiographyVO = require "Module/Follower/FollowerBiographyVO"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FollowerBiographyView = mLuaClass("FollowerBiographyView",mCommonTabBaseView);

function FollowerBiographyView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_biography_view",
	};
end

function FollowerBiographyView:Init( )
	local parent = self:Find('scrollView/Grid');
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Follower/FollowerBiographyItem");
	self.mTextDesc = self:FindComponent('Text_desc', 'Text');

	self:RegisterEventListener(self.mEventEnum.ON_FOLLOWER_BIOGRAPHY, function(vo)
		self:OnUpdateUI(vo);
	end, true);
end

function FollowerBiographyView:OnUpdateUI(data)
	self.mData = data;
	self.mGridEx:UpdateDataSource(  self:GetBiographyData( data ) );
	self.mTextDesc.text = data.mActorVO.biography_desc;
end

function FollowerBiographyView:GetBiographyData(  data )
	local follower_vo = data.mActorVO;
	local chapters = follower_vo.biography;
	local topBiography = data.mTopBiography;
	chapters = chapters ~= nil and chapters or {}; 

	local data_source = mSortTable.LuaNew(function(a, b) return a.mID < b.mID end, nil, true);
	for k, v in pairs(chapters) do
		data_source:AddOrUpdate(v, mFollowerBiographyVO.LuaNew(v, topBiography, data.mUID));
	end
	return data_source;
end

function FollowerBiographyView:Dispose()
	self.mGridEx:Dispose();
end

return FollowerBiographyView;