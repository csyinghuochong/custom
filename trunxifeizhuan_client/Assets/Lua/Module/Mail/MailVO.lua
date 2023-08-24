local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local MailVO = mLuaClass("MailVO", BaseLua);
local mRandom = Mathf.Random;
--邮件数据--
function MailVO:OnLuaNew(data)
	self.id = data.id;
	self.title = data.title;
	self.create_time = data.create_time;
	self.extend_time = data.extend_time;
	self.read_status = data.read_status;
	self.append_status = data.append_status;
	self.type = data.type;
	self.sort_status = data.read_status;
	self.info = nil;
end

return MailVO;