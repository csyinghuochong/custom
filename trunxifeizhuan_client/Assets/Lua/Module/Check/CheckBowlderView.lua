local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mGameModelManager = require "Manager/GameModelManager"
local mFollowerListView = require "Module/Follower/FollowerListView"
local mFollowerAttributeView = require "Module/Follower/FollowerAttributeView"
local mString = string;
local mBowlderEquipView = require "Module/Talent/TalentEquipView"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mSortTable = require "Common/SortTable"
local CheckBowlderView = mLuaClass("CheckBowlderView", mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgCombat = mLanguageUtil.common_combat;

function CheckBowlderView:InitViewParam()
	return {
		["viewPath"] = "ui/check/",
		["viewName"] = "check_bowlder_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function CheckBowlderView:Init()
	self:FindAndAddClickListener("common_bg/Button_close",function()self:OnClickClose();end);
	self.mTextCombat = self:FindComponent('roleAttributeView/Text_combat','Text');
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_OTHERS_FOLLOWER, function(vo)
		self:OnClickFollowerItem(vo);
	end, true);
	self:RegisterEventListener(mEventEnum.ON_SELECT_EQUIP_ITEM, function(index)
		self:OnClickBowlderItem(index);
	end, true);

	self:InitView();
end

function CheckBowlderView:InitView()
	self.mFolloweBowlder = {};
	self.mModelShowView = mModelShowView.LuaNew(self:Find('model'));
	self.mModelShowView:SetColor(Color.New(1, 1, 1, 0.5));
	local model = mGameModelManager.CheckModel;
	self.mFollowerListView = mFollowerListView.LuaNew(model.mDataSoureFollower2, self:Find('listView'));
	self.mBowlderEquipView = mBowlderEquipView.LuaNew(self:Find('equipView').gameObject);
	self.mAttributeView = mFollowerAttributeView.LuaNew(self:Find('bowlder_info/bowlder_attri_view').gameObject);
	self.mTextName = self:FindComponent('bowlder_info/bowlder_attri_view/Text_name','Text');
	self.mTextType = self:FindComponent('bowlder_info/bowlder_attri_view/Text_type','Text');
	self:FindAndAddClickListener("equipView/Button_suit",function() self:OnClickOpenSuitView() end);
end

function CheckBowlderView:OnClickClose()
	self:ReturnPrevQueueWindow();
end

function CheckBowlderView:UpdateFollowerData(follower_vo, equip_indx, updateSubView)
	local followerBowlder = self.mFolloweBowlder;
	if follower_vo.mBowlderListToIndex[equip_indx] == nil then
		equip_indx = follower_vo:GetValidEquipIndex();
	end

	followerBowlder.followerVO = follower_vo;
	followerBowlder.equipIndex = equip_indx;
	followerBowlder.bowlderVO = follower_vo.mBowlderListToIndex[equip_indx];
	self:OnUpdateUI(updateSubView == nil and true or updateSubView);
	self.mTextCombat.text = mLgCombat..follower_vo:GetCombat();
end

function CheckBowlderView:OnUpdateUI(updateSubView)
	self.mBowlderEquipView:OnUpdateFollower(self.mFolloweBowlder);
	local bowlderVO = self.mFolloweBowlder.bowlderVO;
	self.mAttributeView:OnUpdateUI(bowlderVO);
	if bowlderVO ~= nil then
		self.mTextName.text = bowlderVO.mGoodsVO.goods_name;
		self.mTextType.text = bowlderVO.mGoodsVO.att_desc;
	else
		self.mTextName.text = "";
		self.mTextType.text = "";
	end
	local data = self.mFolloweBowlder.followerVO;
	self.mModelShowView:OnUpdateVO(data );
end

function CheckBowlderView:OnClickOpenSuitView(  )
	mUIManager:HandleUI(mViewEnum.BowlderSuitView, 1, self.mFolloweBowlder);
end

function CheckBowlderView:OnClickFollowerItem(data)
	local equip_indx = self.mFolloweBowlder.equipIndex;
	self:UpdateFollowerData(data, equip_indx);
	self.mFollowerListView:OnClickFollowerItem(data);
end

function CheckBowlderView:OnClickBowlderItem(equip_index)
	self:UpdateBowlderData(equip_index);
	self.mBowlderEquipView:SetSelected(equip_index);
end

function CheckBowlderView:UpdateBowlderData(equip_index)
	local followerBowlder = self.mFolloweBowlder;
	local follower_vo = followerBowlder.followerVO;
	followerBowlder.equipIndex = equip_index;
	followerBowlder.bowlderVO = follower_vo.mBowlderListToIndex[equip_index];
	self:OnUpdateUI(true);
end

function CheckBowlderView:OnViewShow(data)
	local model = mGameModelManager.CheckModel;
	local followerData = model.mDataSoureFollower2.mSortTable[1];
	self:UpdateFollowerData(followerData, 1, false);
	self.mFollowerListView = mFollowerListView.LuaNew(model.mDataSoureFollower2, self:Find('listView'));
	self.mModelShowView:ShowView();
	self.mFollowerListView:ShowView();
end

function CheckBowlderView:OnViewHide()
	self.mModelShowView:HideView();
	self.mFollowerListView:HideView();
end

function CheckBowlderView:Dispose()
	self.mFollowerListView:CloseView();
end

return CheckBowlderView;