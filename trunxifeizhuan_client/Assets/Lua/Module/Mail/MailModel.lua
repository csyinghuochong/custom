local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mTable = table;
local mSortTable = require "Common/SortTable"
local mMailVO = require "Module/Mail/MailVO"
local mGameModelManager = require "Manager/GameModelManager"
local mEventDispatcher = require "Events/EventDispatcher"
local mEventEnum = require "Enum/EventEnum"
local MailModel = mLuaClass("MailModel",mBaseModel);

function MailModel:OnLuaNew()
	self.mDataSoure = nil;
	self.mSelectData = nil;
end

--read_status 0已读 1未读
function MailModel:Sort(a,b)
	if a.sort_status == b.sort_status then
		local aTime = a.create_time;
		local bTime = b.create_time;

		if aTime == bTime then
			return a.id < b.id;
		else
			return aTime > bTime;
		end
	end

	return a.sort_status > b.sort_status;
end

function MailModel:OnRecvMailList(pbOpenPanel)
	local list = pbOpenPanel.list;
	if list ~= nil then
		local data_soure = mSortTable.LuaNew(function(a,b)return self:Sort(a,b) end,nil,true);
		for k,v in ipairs(list) do
			if v.id ~= nil then
				local mailData = mMailVO.LuaNew(v);
				local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
				local time = v.extend_time - currentTime;
				if time > 0 then
					data_soure:AddOrUpdate(mailData.id,mailData);
				end
			end
		end
		self.mDataSoure = data_soure;
		mEventDispatcher:Dispatch(mEventEnum.ON_OPEN_MAIL);
	end
end

function MailModel:OnRecvMailInfo(pbMailInfo)
	local mailInfo = pbMailInfo;
	if mailInfo ~= nil then
		local mailList = self.mDataSoure;
		local data = mailList:GetValue(mailInfo.id);
		data.info = {id=mailInfo.id,content=mailInfo.content,send_name=mailInfo.send_name,read_status=mailInfo.read_status,
					append_status=mailInfo.append_status,items=mailInfo.items,talents=mailInfo.talents};
		data.read_status = 0;
		self.mDataSoure:AddOrUpdate(mailInfo.id,data);
		mEventDispatcher:Dispatch(mEventEnum.ON_SELECT_MAIL, data);
	end
end

function MailModel:OnRecvMailDelete(pbResult)
	self.mDataSoure:RemoveKey(self.mSelectData.id);
	mEventDispatcher:Dispatch(mEventEnum.ON_DELETE_MAIL);
end

function MailModel:OnRecvMailDeleteAll(pbResult)
	local mailList = self.mDataSoure.mRawTable;
	local selectData = self.mSelectData;
	if selectData ~= nil and selectData.append_status ~= 1 then
		self.mSelectData = nil;
	end
	for k,v in pairs(mailList) do
		if v.read_status == 0 and v.append_status ~= 1 then
			self.mDataSoure:RemoveKey(v.id);
		end
	end
	mEventDispatcher:Dispatch(mEventEnum.ON_DELETE_MAIL_ALL);
end

function MailModel:OnRecvMailGetAwardAll(pbResult)
	local mailList = self.mDataSoure.mRawTable;
	for k,v in pairs(mailList) do
		if v.append_status == 1 then
			v.append_status = 2;
			v.read_status = 0;
			v.sort_status = 0;
			if v.info ~= nil then
				v.info.append_status = 2;
			end
			self.mDataSoure:AddOrUpdate(v.id,v);
		end
	end
	mEventDispatcher:Dispatch(mEventEnum.ON_GET_MAIL_AWARD_ALL);
end

function MailModel:OnRecvMailGetAward(pbMailInfo)
	local mailInfo = pbMailInfo;
	local rawTable = self.mDataSoure.mRawTable;
	rawTable[mailInfo.id].info = mailInfo;
	self:RefreshAwardState(mailInfo.id);
	if mailInfo ~= nil then
		mEventDispatcher:Dispatch(mEventEnum.ON_GET_MAIL_AWARD, rawTable[mailInfo.id]);
	end
end

function MailModel:RefreshAwardState(mailID)
	local mailList = self.mDataSoure;
	local data = mailList:GetValue(mailID);
	data.append_status = 2;
	self.mDataSoure:AddOrUpdate(data.id,data);
end

function MailModel:OnRecvMailAdd(pbMailIntro)
	if self.mDataSoure == nil then
		return;
	end
	local mailData = mMailVO.LuaNew(pbMailIntro);
	self.mDataSoure:AddOrUpdate(mailData.id,mailData)
	if mailData ~= nil then
		mEventDispatcher:Dispatch(mEventEnum.ON_ADD_MAIL, mailData);
	end
end

function MailModel:SortMailList()
	local mailList = self.mDataSoure.mRawTable;
	for k,v in pairs(mailList) do
		v.sort_status = v.read_status;
	end
	self.mDataSoure:Sort();
end

function MailModel:CheckIsAnyMail()
	local mailList = self.mDataSoure.mSortTable;
	local num = 0;
	for k,v in ipairs(mailList) do
		if v.read_status == 0 and v.append_status ~= 1 then
			num = num + 1;
		end
	end
	return num > 0;
end

function MailModel:CheckIsAnyMailGift()
	local mailList = self.mDataSoure.mSortTable;
	for k,v in ipairs(mailList) do
		if v.append_status == 1 then
			return true
		end
	end
	return false;
end

function MailModel:GetMailNum()
	local myTable = self.mDataSoure;
	local num = 0;
	local maxNum = 0;
	if myTable ~= nil then
		maxNum = mTable.getn(myTable.mSortTable);
		for k,v in ipairs(myTable.mSortTable) do
			if v.append_status == 1 then
				num = num + 1;
			end
		end
	end
	return num,maxNum;
end

function MailModel:GetMailNumState()
	local table = self.mDataSoure.mSortTable;
	if table ~= nil and mTable.getn(table) > 0 then
		return false;
	else
		return true;
	end
end

function MailModel:GetDeleteMailNum()
	local table = self.mDataSoure.mSortTable;
	local num = 0;
	if table ~= nil then
		for k,v in ipairs(table) do
			if v.append_status ~= 1 and v.read_status == 0 then
				num = num + 1;
			end
		end
		return num;
	else
		return num;
	end
end

return MailModel;