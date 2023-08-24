local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mConfigSysskill_info = require "ConfigFiles/ConfigSysskill_info"
local CommonSkillVO = mLuaClass("CommonSkillVO", BaseLua);

--level == 0 不显示等级
--active == false  置灰
function CommonSkillVO:OnLuaNew(id, level, active , isDetial)
	self.mID = id;
	self.mLevel = level;
	self.mActive = active;
	self.mIsDetial = self:GetDetail(isDetial);
	self.mSkillInfo = mConfigSysskill_info[id];

	if self.mSkillInfo == nil then
		print('无效的技能id..'..id)
	end
end

function CommonSkillVO:IsActive(  )
	return self.mActive;
end

function CommonSkillVO:GetPosition( )
	return self.mSkillInfo.position;
end

function CommonSkillVO:GetDetail(isDetial)
	if isDetial ~= nil then
		return isDetial;
	else
		return true;
	end
end

return CommonSkillVO;