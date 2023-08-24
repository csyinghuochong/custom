local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local mLayoutController = require "Core/Layout/LayoutController"
local mDraftController = require "Module/Draft/DraftController"
local ArchiveView = mLuaClass("ArchiveView", mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgLast = mLanguageUtil.archive_type_last;
local mLgTable = {mLanguageUtil.archive_type1,mLanguageUtil.archive_type2,mLanguageUtil.archive_type3,mLanguageUtil.archive_type4,mLanguageUtil.archive_type5}

function ArchiveView:InitViewParam()
	return {
		["viewPath"] = "ui/archive/",
		["viewName"] = "archive_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function ArchiveView:Init()
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ReturnPrevQueueWindow(); end);

	local parent = self:Find("Right/scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Archive/ArchiveItemView");
	self.mGridEx:RefreshUpdateSortIndex(true);

	self.mTextPageNumTitle = self:FindComponent("Right/LeftTitle","Text");
	self.mTextPageNum = self:FindComponent("Right/LeftNum","Text");
	self.mTextAllNum = self:FindComponent("Right/RightNum","Text");

	local callBack = function( index )
		   self:OnClickTypeButton(index);
	 end
	local go = self:Find('Left/buttonView');
	self.mToggleGroup = mCommonToggleGroup.LuaNew(go,callBack,1);
    self.mSelectIndex = 1;

    self:RegisterEventListener(self.mEventEnum.ON_GET_ARCHIVE_LIST, function(data)
         self:CreateNum(self.mSelectIndex);
         self:CreateAllNum();
    end, true);
end

function ArchiveView:CreateAllNum()
	local model = mGameModelManager.ArchiveModel;
	local typesAll,all = model:GetAllNum();
	self.mTextAllNum.text = typesAll.."/"..all;
end

function ArchiveView:OnClickTypeButton(index)
	self.mSelectIndex = index;
	self:CreateDataByIndex(index);
	self:CreateNum(index);
end

function ArchiveView:CreateDataByIndex(index)
	local model = mGameModelManager.ArchiveModel;
	local data_soure = model.mTypeTable[index];
	self.mGridEx:UpdateDataSource(data_soure);
end

function ArchiveView:CreateNum(index)
	local model = mGameModelManager.ArchiveModel;
	local pageNum,allPageNum = model:GetPageNum(index);
	self.mTextPageNumTitle.text = mLgTable[index]..mLgLast;
	self.mTextPageNum.text = pageNum.."/"..allPageNum;
end

function ArchiveView:OnViewShow(param)
	local model = mGameModelManager.ArchiveModel;
	if not model.mIsEverGetList then
		mDraftController:SendGetDraftShowList();
		model.mIsEverGetList = true;
	end 
	self:OnClickTypeButton(self.mSelectIndex);
	self:CreateAllNum();
	self.mCallBack = param;
end

function ArchiveView:OnViewHide(param)
	local callBack = self.mCallBack;
	if callBack ~= nil then
		callBack();
	end
end

function ArchiveView:Dispose()
end

return ArchiveView;