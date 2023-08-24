local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local FashionStyleVO = mLuaClass("FashionStyleVO", mBaseLua);
local ipairs = ipairs;
local string = string;
local mLanguage = require "Utils/LanguageUtil"
local mStyleNames = {
	[11] = mLanguage.fashion_style_11,
	[21] = mLanguage.fashion_style_21,
	[31] = mLanguage.fashion_style_31,
	[41] = mLanguage.fashion_style_41,
	[51] = mLanguage.fashion_style_51,
	[61] = mLanguage.fashion_style_61,
	[12] = mLanguage.fashion_style_12,
	[22] = mLanguage.fashion_style_22,
	[32] = mLanguage.fashion_style_32,
	[42] = mLanguage.fashion_style_42,
	[52] = mLanguage.fashion_style_52,
	[62] = mLanguage.fashion_style_62,
};

local mGradeNames = 
{
	[1] = mLanguage.fashion_style_grade_1,
	[2] = mLanguage.fashion_style_grade_2,
	[3] = mLanguage.fashion_style_grade_3,
	[4] = mLanguage.fashion_style_grade_4,
	[5] = mLanguage.fashion_style_grade_4,
}

local mGradeScores = {
	[1] = 1000,
	[2] = 750,
	[3] = 500,
	[4] = 250,
	[5] = 0
}

function FashionStyleVO:OnLuaNew(type,value,actived_star)
	self.type = type;
	self.actived_star = actived_star;
	self.actived = false;
	self.base_value = value;
	self:UpdateValue(value);
end

function FashionStyleVO:UpdateValue(v)
	
	local grade = self:GetGrade(v);
	local nextGradeScore = mGradeScores[grade - 1] or 1000;
	local gradeScore = mGradeScores[grade];

	self.grade_offset = (v - gradeScore) / ( nextGradeScore - gradeScore );
	self.grade = grade;
	self.value = v;
end

function FashionStyleVO:GetName()
	return mStyleNames[self.type];
end

function FashionStyleVO:GetGradeName()
	return mGradeNames[self.grade];
end

function FashionStyleVO:GetGrade(v)
	local score = v or self.value;
	for i,v in ipairs(mGradeScores) do
		if score > v then
			return i;
		end
	end
	return 0;
end

function FashionStyleVO:SetActive()
	self.actived = true;
end



return FashionStyleVO;