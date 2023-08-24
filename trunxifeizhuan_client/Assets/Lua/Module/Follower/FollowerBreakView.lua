local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum";
local mUIManager = require "Manager/UIManager"
local mLanguageUtil = require "Utils/LanguageUtil"
local mAlertView = require "Module/CommonUI/AlertView"
local mFollowerBaseVO = require "Module/Follower/FollowerBaseVO"
local TalentAttributeItem = require "Module/Talent/TalentAttributeItem"
local mFollowerController = require "Module/Follower/FollowerController"
local mFollowerItemView = require "Module/CommonUI/CommonFollowerItemView"
local FollowerBreakCostItem = require "Module/Follower/FollowerBreakCostItem"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local FollowerBreakView = mLuaClass("FollowerBreakView", mCommonTabBaseView);

function FollowerBreakView:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_break_view",
	};
end

function FollowerBreakView:Init()
	self:SetParent(self.mGoParent);
	
	self.mTextCost = self:FindComponent('Text_cost', 'Text');
	self.mTextLevel1 = self:FindComponent('Text_lv_1', 'Text');
	self.mTextLevel2 = self:FindComponent('Text_lv_2', 'Text');
	self.mFollowerItem1 = mFollowerItemView.LuaNew(self:Find('retinue_1').gameObject);
	self.mFollowerItem2 = mFollowerItemView.LuaNew(self:Find('retinue_2').gameObject);

	local attri_list = {};
	local mPath = 'attri%d';
	for i = 1, 3 do
		attri_list[i] = TalentAttributeItem.LuaNew(self:Find(string.format(mPath, i)).gameObject);
	end
	self.mAttriList = attri_list;
	
	local clickBack = function (  )
		self:OnOpenCostView( );
	end
	local costList = {};
	for i = 1, 5 do
		costList[i] = FollowerBreakCostItem.LuaNew(self:Find('button_add'..i).gameObject, clickBack);
	end
	self.mCostItemList = costList;

	self.mSendFollowerBreak = function (  )
		self:SendFollowerBreak();
	end

	self:FindAndAddClickListener('Button_1', function() self:OnClickButton() end, nil , 0.5);

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_SELECT_BREAK_FOLLOWER, function(vo)
   		self:OnSelectCostItem(vo);
   	end, true);

   	self:RegisterEventListener(mEventEnum.ON_CANCEL_BREAK_FOLLOWER, function(vo)
   		self:OnCancelCostItem(vo);
   	end, true);
end

function FollowerBreakView:OnOpenCostView(  )
	mUIManager:HandleUI(mViewEnum.FollowerBreakCostView, 1, { followerVo = self.mData,  needStar = self.mNeedStar, needNumber = self.mNeedNumber, selectIds = self.mCostDataList });
end

local mLgTip = mLanguageUtil.follower_break_cost;
function FollowerBreakView:OnClickButton(  )
	local dayu = self:CheckDayuNeedStar();

	if dayu then
		mAlertView.Show({title=nil, desc1=nil, desc2=mLgTip, btnName= nil,CallBack = self.mSendFollowerBreak});
	else
		self:SendFollowerBreak();
	end
end

function FollowerBreakView:GetCostIds(  )
	local ids = { };
	for k, v in pairs( self.mCostDataList ) do
		ids[ k ] = tonumber(v.mUID);
	end
	return ids;
end

function FollowerBreakView:SendFollowerBreak(  )
	local data = self.mData;
	mFollowerController:SendFollowerBreak(data.mUID, self:GetCostIds());
end

function FollowerBreakView:CheckDayuNeedStar(  )
	for k, v in pairs(self.mCostDataList) do
		if v:GetStar() > self.mNeedStar then
			return true;
		end
	end
	return false;
end

function FollowerBreakView:OnUpdateUI(data)
	self.mData = data;
	self.mCostDataList = { };
	
	self:UpdateCost(data);
	self:UpdateSubView(data);
	self:ShowAttribute(data);
end

function FollowerBreakView:UpdateCost(data)
	local maxLevel1 = data:GetStarVO().max_lv;
	local maxLevel2 = data:GetNextStarVO().max_lv;
	self.mTextLevel1.text = maxLevel1;
	self.mTextLevel2.text = maxLevel2;
	self.mTextCost.text = data:GetBreakCoin();
end

function FollowerBreakView:ShowAttribute( data )
	local attriList = self.mAttriList;
	local bentiAtti = data:GetBenTiAttri();
	local growAttri = data:GetGrowAttri();
	local nextStarAdd = data:GetNextStarVO( ).addition_attri;
	for k, v in pairs(attriList) do
		v:UpdateUITo(k, bentiAtti[k], growAttri[k] * ( 1 + nextStarAdd) );
	end
end

function FollowerBreakView:UpdateSubView(data )
	local breakCost = data:GetBreakCost();

	local costList = self.mCostItemList;
	local star_num = breakCost.star_num;
	local star_lv = breakCost.star_lv;
	for i = 1, star_num do
		costList[i]:SetValid( );
	end
	for i = star_num + 1, 5 do
		costList[i]:SetLock();
	end
	self.mNeedStar = star_lv;
	self.mNeedNumber = star_num;

	self.mFollowerItem1:ExternalUpdateData(data);
	self.mFollowerItem2:ExternalUpdateData(data:GetNextStarClone());
end

function FollowerBreakView:OnSelectCostItem( data )
	if #self.mCostDataList < self.mNeedNumber then
		table.insert( self.mCostDataList, data );
		self.mCostItemList[ #self.mCostDataList ]:OnSelectCostItem( data );
	end
end

function FollowerBreakView:OnCancelCostItem( data )
	self.mCostItemList[ #self.mCostDataList ]:OnCancelCostItem( data );
	table.remove( self.mCostDataList );
end

return FollowerBreakView;

