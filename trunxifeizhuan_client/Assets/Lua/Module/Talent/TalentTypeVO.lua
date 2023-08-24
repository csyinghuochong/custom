local mLuaClass = require "Core/LuaClass"
local TalentTypeVO = mLuaClass("TalentTypeVO");
local mLanguageUtil = require "Utils/LanguageUtil"

function TalentTypeVO:OnLuaNew(goods_type, talent_type, sys_vo, number, callback)
	self.mGoodsType = goods_type;       --才艺，秘诀，心得
	self.mTalentType = talent_type;     --农业，商业，工业
	self.mNumber = number;
	self.mSysVO = sys_vo;
	self.mCallBack = callback;
end

function TalentTypeVO:GetName(  )
	return self.mSysVO.name;
end

local name = mLanguageUtil.talent_type_to_name;
function TalentTypeVO:GetTypeName( )
	local goods_type = self.mGoodsType;
	local key = 'talent_type_name'..goods_type;
	return string.format( name, self:GetName(), mLanguageUtil[key] )
end

function TalentTypeVO:GetNumber(  )
	return self.mNumber;
end

function TalentTypeVO:GetIcon(  )
	return self.mSysVO.icon;
end

return TalentTypeVO;