local mLuaClass = require "Core/LuaClass"
local mVerticalLayoutControllerLoop = require "Core/Layout/VerticalLayoutControllerLoop"
local mLayoutController = require "Core/Layout/LayoutController"
local mQueueWindow = require "Core/QueueWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mRankController = require "Module/Rank/RankController"
local mConfigSysrank = require "ConfigFiles/ConfigSysrank"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mRankAwardView = require "Module/Rank/RankAwardView"
local mSortTable = require "Common/SortTable"
local mRankStateVO = require "Module/Rank/RankStateVO"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote"
local mCheckController = require "Module/Check/CheckController"
local RankView = mLuaClass("RankView",mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgRankOutOf = mLanguageUtil.rank_out_of;

function RankView:InitViewParam()
	return {
		["viewPath"] = "ui/rank/",
		["viewName"] = "rank_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["PlayAnimation"] = true,
		["ChangeSceneDispose"] = true,
	};
end

function RankView:Init()
	self:FindAndAddClickListener("Btn",function()self:ClickBtn();end);
	self.mTextValueTitle = self:FindComponent("Title/Value","Text");
	self.mTextSelfRank = self:FindComponent("MyRank","Text");
	self.mTextSelfValue = self:FindComponent("MyValue","Text");
	self.mTextSelfValueTitle = self:FindComponent("MyValueTitle","Text");
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow() end);

	self:InitSubView(  );
	self:AddListeners( );
	self:InitLayoutController( );
end

function RankView:InitLayoutController(  )
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mVerticalLayoutControllerLoop.LuaNew(parent, require "Module/Rank/RankItem");
	self.mGridEx:SetItemInfo(670,102,2,5);
end

function RankView:InitSubView(  )
	self.mSaveType = true;
	local parentBtn = self:Find("btnScrollView/Grid");
	self.mGridBtn = mLayoutController.LuaNew(parentBtn, require "Module/Rank/RankBtnItem");
	self:CreateBtn();
end

function RankView:AddListeners(  )
	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_CHANGE_SELF_RANK_VALUE,function(data)self:ChangeValue(data);end,true);
	self:RegisterEventListener(mEvent.ON_ITEM_SELECT_RANK,function(data)self:OnClickItem(data);end,true);
	self:RegisterEventListener(mEvent.ON_BUTTON_SELECT_RANK,function(data)self:OnClickTypeButton(data);end,true);
end

function RankView:CreateBtn()
	local model = mGameModelManager.RankModel;
	local data_soure = mSortTable.LuaNew(function(a,b) return a.config.type < b.config.type end,nil,true)
	for k,v in ipairs(mConfigSysrank) do
		local data;

		if v.type ~= model.mTypeEnum.MANSION then

			if v.type == model.mType then
				data = mRankStateVO.LuaNew(v,true);
			else
				data = mRankStateVO.LuaNew(v,false);
			end
			data_soure:AddOrUpdate(data.config.type,data);

		end
	end
	self.mGridBtn:UpdateDataSource(data_soure);
end

function RankView:OnClickItem(data)
	mCheckController:SendGetOtherPlayer(data.id);
end

function RankView:ChangeValue(data)
	if data.self_rank == 0 then
		self.mTextSelfRank.text = mLgRankOutOf;
	else
		self.mTextSelfRank.text = data.self_rank;
	end
	local model = mGameModelManager.RankModel;
	if data.type == model.mTypeEnum.POSITION then
		local sex = mGameModelManager.RoleModel.mPlayerBase.sex;
		if sex == 2 then
			self.mTextSelfValue.text = mConfigSyspromote[data.self_value].woman_name;
		else
			self.mTextSelfValue.text = mConfigSyspromote[data.self_value].man_name;
		end
	else
		self.mTextSelfValue.text = data.self_value;
	end

	local model = mGameModelManager.RankModel;
	self.mGridEx:UpdateDataSource(model.mDataSoure);
end

function RankView:ClickBtn()
	mRankAwardView.Show();
end

function RankView:OnClickTypeButton(data)
	local model = mGameModelManager.RankModel;
	self:GetRankList(data.config.type,model.mPageNum);
end

function RankView:GetRankList(type,pageNum)
	local model = mGameModelManager.RankModel;
	local strTitle = mConfigSysrank[type].name;
	self.mTextValueTitle.text = strTitle;
	self.mTextSelfValueTitle.text = strTitle..":";
	model.mPageNowTable[type] = pageNum;
	if self.mSaveType then
		model.mType = type;
	end
	model.mDataSoure:ClearDatas(true);
	mRankController:SendGetRankList(type,1,pageNum);
end

function RankView:OnViewShow(data)
	self.mGridEx:SetActive(true);

	local model = mGameModelManager.RankModel;
	self.mGridEx:UpdateDataSource(model.mDataSoure);
	self:GetRankList(model.mType,model.mPageNum);
end

function RankView:OnViewHide()
	self.mGridEx:SetActive(false);
	self.mGridEx:RemoveLateUpdate();
end

function RankView:Dispose( )
	self.mGridEx:Dispose();
	self.mGridBtn:Dispose();
end

return RankView;