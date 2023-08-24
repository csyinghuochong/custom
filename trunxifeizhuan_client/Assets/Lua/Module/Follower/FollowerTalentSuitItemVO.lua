local BaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local ConfigSystalent_type = require "ConfigFiles/ConfigSystalent_type"
local ConfigSystalent_suit = require "ConfigFiles/ConfigSystalent_suit"
local FollowerTalentSuitItemVO = mLuaClass("FollowerTalentSuitItemVO", BaseLua);

function FollowerTalentSuitItemVO:OnLuaNew(talent_type, talent_num)
	self.mTalentNumber = talent_num;
	self.mTalentTypeVO = ConfigSystalent_type[ talent_type ];
	self.mTalentSuitVO = ConfigSystalent_suit[ talent_type ];
end

function FollowerTalentSuitItemVO:GetIcon(  )
	return self.mTalentTypeVO.icon
end

function FollowerTalentSuitItemVO:GetName ( )
	return self.mTalentTypeVO.name;
end 

function FollowerTalentSuitItemVO:GetSuitName(  )
	return self.mTalentSuitVO.suit_name;
end

function FollowerTalentSuitItemVO:GetNumber(  )
	return self.mTalentSuitVO.suit_number;
end

function FollowerTalentSuitItemVO:GetDesc(  )
	return self.mTalentSuitVO.suit_desc;
end

function FollowerTalentSuitItemVO:GetAttri(  )
	return self.mTalentSuitVO.addition_attri;
end

return FollowerTalentSuitItemVO;