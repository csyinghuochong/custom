local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mUIGray = require "Utils/UIGray"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mSortTable = require "Common/SortTable"
local mMailVO = require "Module/Mail/MailVO"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mCommonAllAwardVO = require "Module/CommonUI/CommonAllAwardVO"
local mLayoutController = require "Core/Layout/LayoutController"
local mTable = table;
local mMailController = require "Module/Mail/MailController"
local mGameModelManager = require "Manager/GameModelManager"
local mTimeUtil = require "Utils/TimeUtil"
local mCommonGetAwardView = require "Module/CommonUI/CommonGetAwardView"
local MailView = mLuaClass("MailView", mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgTimeTitle = mLanguageUtil.mail_time_title;
function MailView:InitViewParam()
	return {
		["viewPath"] = "ui/mail/",
		["viewName"] = "mail_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["PlayAnimation"] = true,
		["ChangeSceneDispose"] = true,
	};
end

function MailView:Init()
	self.mGoNoneMail = self:Find("NoneMail");
	self.mGoLight = self:Find("scrollViewMail/Grid/light").gameObject;
	local parentMail = self:Find("scrollViewMail/Grid");
	self.mGridMail = mLayoutController.LuaNew(parentMail, require "Module/Mail/MailItem");
	self.mGridMail:SetSelectedViewTop(true);
	local parentAward = self:Find("scrollViewAward/Grid");
	self.mGridAward = mLayoutController.LuaNew(parentAward, require "Module/Mail/MailAwardItem");
	self.mGoScrollViewAward = self:Find("scrollViewAward").gameObject;

	self.mTextNum = self:FindComponent("TextNum","Text");
	self.mTextTime = self:FindComponent("Top/Time","Text");
	self.mTextTitle = self:FindComponent("Top/Title","Text");
	self.mTextMailDesc = self:FindComponent("TextMailDesc","Text");

	local clickAllDelete = function() self:OnClickAllDelete(); end
	local clickAllGet = function() self:OnClickAllGet(); end
	local clickDelete = function() self:OnClickDelete(); end
	local clickGet = function() self:OnClickGet(); end

	self.mBtnAllDelete = self:FindComponent("BtnAllDelete","Button");
	self.mBtnAllGet = self:FindComponent("BtnAllGet","Button");
	self.mBtnDelete = self:FindComponent("BtnDelete","Button");
	self.mBtnGet = self:FindComponent("BtnGet","Button");

	self:AddBtnClickListener(self.mBtnAllDelete.gameObject, clickAllDelete);
	self:AddBtnClickListener(self.mBtnAllGet.gameObject, clickAllGet);
	self:AddBtnClickListener(self.mBtnDelete.gameObject, clickDelete);
	self:AddBtnClickListener(self.mBtnGet.gameObject, clickGet);

	self.mUIGrayBtnAllGet = mUIGray.LuaNew():InitGoGraphic(self:Find('BtnAllGet/Image').gameObject);
	self.mUIGrayBtnAllDelete = mUIGray.LuaNew():InitGoGraphic(self:Find('BtnAllDelete/Image').gameObject);

	self:FindAndAddClickListener("c_bg/Button_close",function()self:OnClickClose();end);

	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_OPEN_MAIL,function(data)self:OnViewShow(data);end,true);
	self:RegisterEventListener(mEvent.ON_ITEM_SELECT_MAIL,function(data)self:OnItemSelectMail(data);end,true);
	self:RegisterEventListener(mEvent.ON_ITEM_DELETE_MAIL,function(data)self:OnItemDeleteMail(data);end,true);

	self:RegisterEventListener(mEvent.ON_SELECT_MAIL,function(data)self:ReciveSelectMail(data);end,true);
	self:RegisterEventListener(mEvent.ON_DELETE_MAIL,function(data)self:ReciveDeleteMail(data);end,true);
	self:RegisterEventListener(mEvent.ON_DELETE_MAIL_ALL,function(data)self:ReciveDeleteMailAll(data);end,true);
	self:RegisterEventListener(mEvent.ON_GET_MAIL_AWARD_ALL,function(data)self:ReciveGetMailAwardAll(data);end,true);
	self:RegisterEventListener(mEvent.ON_GET_MAIL_AWARD,function(data)self:ReciveGetMailAward(data);end,true);
	self:RegisterEventListener(mEvent.ON_ADD_MAIL,function(data)self:ReciveAddMail(data);end,true);
end

function MailView:OnClickClose()
	self:ReturnPrevQueueWindow();
end

function MailView:OnItemSelectMail(data)
	local model = mGameModelManager.MailModel;
	local descData = data.info;
	model.mSelectData = data;
	if descData == nil then
		mMailController:SendGetMailInfo(data.id);
	else
		self:RefreshDesc(data);
	end
end

function MailView:RefreshDesc(data)
	self.mTextMailDesc.gameObject:SetActive(true);
	self.mBtnGet.gameObject:SetActive(true);
	self.mBtnDelete.gameObject:SetActive(true);
	self.mTextMailDesc.text = string.gsub(data.info.content,"\\n","\n");
	self.mTextTitle.text = data.title;
	self:CreateTime(data.extend_time);

	local isShowBtnGet = data.info.append_status == 1;
	self.mBtnGet.gameObject:SetActive(isShowBtnGet);
	self.mBtnDelete.gameObject:SetActive(not isShowBtnGet);
	local append_status = data.info.append_status;
	if append_status ~= 0 then
		self.mGoScrollViewAward:SetActive(true);
		local data_soure = self:GetAwardList(data.info,append_status);
		self.mGridAward:UpdateDataSource(data_soure);
	else
		self.mGoScrollViewAward:SetActive(false);
	end
end

function MailView:GetAwardList(info,append_status)
	local data_soure = mSortTable.LuaNew(nil,nil,true);
	local talents = info.talents;
	if talents ~= nil then
		for k,v in ipairs(talents) do
			local talentData = mCommonAllAwardVO.LuaNew(k,0,true,v,append_status==2)
			data_soure:AddOrUpdate(k,talentData);
		end
	end
	local items = info.items;
	if items ~= nil then
		for k,v in ipairs(items) do
			if v.id ~= nil then
				local awardData = mCommonAllAwardVO.LuaNew(v.good_id,v.count,false,nil,append_status==2);
				data_soure:AddOrUpdate(v.good_id,awardData);
			end
		end
	end
	return data_soure;
end

function MailView:CreateTime(time)
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
	local second = time - currentTime;
	if second >= 3600 then
		self.mTextTime.text = mLgTimeTitle..mTimeUtil:TransToDayHour(second);
	else
		self.mTextTime.text = mLgTimeTitle..mTimeUtil:TransToMin(second);
	end
end

function MailView:OnItemDeleteMail(data)
	local model = mGameModelManager.MailModel;
	local data_soure = model.mDataSoure;
	model:DeleteMailInfo(data.id);
end

function MailView:ReciveSelectMail(data)
	self:RefreshDesc(data);
	self:RefreshAllDeleteBtnState();
end

function MailView:RefreshAllDeleteBtnState()
	local model = mGameModelManager.MailModel;
	if model:GetDeleteMailNum() > 0 then
		self.mUIGrayBtnAllDelete:SetGray(false);
		self.mBtnAllDelete.enabled = true;
	else
		self.mUIGrayBtnAllDelete:SetGray(true);
		self.mBtnAllDelete.enabled = false;
	end
end

function MailView:ReciveDeleteMail(data)
	local model = mGameModelManager.MailModel;
	model.mSelectData = nil;
	self.mGoLight:SetActive(false);
	self:RefreshDescToNone();
	self:RefreshNum();
end

function MailView:ReciveDeleteMailAll(data)
	self:RefreshNum();
	self:RefreshLeftText();
	local model = mGameModelManager.MailModel;
	if model.mSelectData == nil then
		self.mGoLight:SetActive(false);
		self:RefreshDescToNone();
	end
end

function MailView:RefreshDescToNone()
	self.mTextMailDesc.text = "";
	self.mTextTime.text = "";
	self.mTextTitle.text = "";
	self.mBtnGet.gameObject:SetActive(false);
	self.mBtnDelete.gameObject:SetActive(false);
	self.mGoScrollViewAward:SetActive(false);
end

function MailView:ReciveGetMailAwardAll(data)
	local model = mGameModelManager.MailModel;
	if model.mSelectData == nil then
		self:RefreshNum();
		return;
	end
	local descData = model.mSelectData.info;
	if descData ~= nil then
		if descData.append_status == 1 then
			descData.append_status = 2;
		end
		self:RefreshDesc(model.mSelectData);
		self:RefreshNum();
	end
end

function MailView:ReciveGetMailAward(data)
	self:RefreshDesc(data);
	self:RefreshNum();
	self:ShowAward(data);
end

function MailView:ShowAward(data)
	local data_soure = self:GetAwardList(data.info);
	mCommonGetAwardView.Show(data_soure);
end

function MailView:ReciveAddMail(data)
	self:RefreshLeftText();
	self:RefreshNum();
end

function MailView:RefreshNum()
	local model = mGameModelManager.MailModel;
	local num,maxNum = model:GetMailNum();
	self.mTextNum.text = num.."/"..maxNum;
	self:SetBtnState(num);
end

function MailView:SetBtnState(num)
	if num > 0 then
		self.mUIGrayBtnAllGet:SetGray(false);
		self.mBtnAllGet.enabled = true;
	else
		self.mUIGrayBtnAllGet:SetGray(true);
		self.mBtnAllGet.enabled = false;
	end

	self:RefreshAllDeleteBtnState()
end

function MailView:OnClickAllDelete()
	local model = mGameModelManager.MailModel;
	if model:CheckIsAnyMail() then
		mMailController:SendDeleteAllMail();
	end
end

function MailView:OnClickAllGet()
	local model = mGameModelManager.MailModel;
	if model:CheckIsAnyMailGift() then
		mMailController:SendGetAllAward();
	end
end

function MailView:OnClickDelete()
	local model = mGameModelManager.MailModel;
	mMailController:SendDeleteMail(model.mSelectData.id);
end

function MailView:OnClickGet()
	local model = mGameModelManager.MailModel;
	mMailController:SendGetAward(model.mSelectData.id);
end

function MailView:OnViewShow(data)
	local model = mGameModelManager.MailModel;
	local mailList = model.mDataSoure;
	if mailList ~= nil then
		model:SortMailList();
		
		self.mGridMail:UpdateDataSource(mailList);
		self:RefreshLeftText();
		self:RefreshNum();
	else
		mMailController:SendGetMailList();
	end
end

function MailView:OnViewHide()
	self:RefreshDescToNone();
	local model = mGameModelManager.MailModel;
	if model.mSelectData ~= nil then 
		self.mGridMail:SetViewSelectedByKey(model.mSelectData.id,false); 
		model.mSelectData = nil;
	end
end

function MailView:RefreshLeftText()
	local model = mGameModelManager.MailModel;
	local state = model:GetMailNumState();
	self.mGoNoneMail.gameObject:SetActive(state);
end

function MailView:Dispose()
	self.mGridMail:Dispose();
	self.mGridAward:Dispose();
end

return MailView;