local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mConfigSysfollower_office_up = require "ConfigFiles/ConfigSysfollower_office_up"
local CampDungeonFollowerVO = mLuaClass("CampDungeonFollowerVO", BaseLua);

function CampDungeonFollowerVO:OnLuaNew(rank,data)
	self.rank = rank
	self.id = data.partner_id;
	local configActor = mConfigSysactor[data.partner_id];
	local configOffice = mConfigSysfollower_office_up[data.partner_id.."_"..configActor.position];
	self.mConfigSysActor = configActor;
	self.mConfigSysOffice = configOffice;
	self.rate = data.rate;
end

return CampDungeonFollowerVO;