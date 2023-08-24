local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mGameModelManager = require "Manager/GameModelManager"
local MailController = mLuaClass("MailController",mBaseController);

--协议处理--
function MailController:AddNetListeners()
	local s2c = self.mS2C;
	s2c:MAIL_MAILS_INFO(function(pbOpenPanel)
		mGameModelManager.MailModel:OnRecvMailList(pbOpenPanel);
	end);

	s2c:MAIL_READ(function(pbMailInfo)
		mGameModelManager.MailModel:OnRecvMailInfo(pbMailInfo);
	end);

	s2c:MAIL_DEL(function(pbResult)
		mGameModelManager.MailModel:OnRecvMailDelete(pbResult);
	end);

	s2c:MAIL_DEL_ALL(function(pbResult)
		mGameModelManager.MailModel:OnRecvMailDeleteAll(pbResult);
	end);

	s2c:MAIL_GET_AWARD_ALL(function(pbResult)
		mGameModelManager.MailModel:OnRecvMailGetAwardAll(pbResult);
	end);

	s2c:MAIL_GET_AWARD(function(pbMailInfo)
		mGameModelManager.MailModel:OnRecvMailGetAward(pbMailInfo);
	end);

	s2c:MAIL_ADD(function(pbMailIntro)
		mGameModelManager.MailModel:OnRecvMailAdd(pbMailIntro);
	end);
end

--事件处理--
function MailController:AddEventListeners()
	
end

--获取邮件列表--
function MailController:SendGetMailList()
	self.mC2S:MAIL_MAILS_INFO(true);
end

--获取一封邮件信息--
function MailController:SendGetMailInfo(mailId)
	self.mC2S:MAIL_READ(mailId,true);
end

--删除一封邮件--
function MailController:SendDeleteMail(mailId)
	self.mC2S:MAIL_DEL(mailId,true);
end

--删除所有邮件--
function MailController:SendDeleteAllMail()
	self.mC2S:MAIL_DEL_ALL(true);
end

--获取所有奖励--
function MailController:SendGetAllAward()
	self.mC2S:MAIL_GET_AWARD_ALL(true);
end

--获取一份奖励--
function MailController:SendGetAward(mailId)
	self.mC2S:MAIL_GET_AWARD(mailId,true);
end

local mMailControllerInstance = MailController.LuaNew();
return mMailControllerInstance;