local mUIGray = require "Utils/UIGray"
local mLuaClass = require "Core/LuaClass"
local mCommonSkillItemView = require "Module/CommonUI/CommonSkillItemView"
local FollowerSkillItemView = mLuaClass("FollowerSkillItemView", mCommonSkillItemView);
local mVector3 = Vector3;
local mSuper;
local mColor = Color;

function FollowerSkillItemView:OnLuaNew( go, call_back)

	mSuper = self:GetSuper(mCommonSkillItemView.LuaClassName);
   	mSuper.OnLuaNew(self, go, call_back);
end

function FollowerSkillItemView:AddLongClick( skill_vo )
	
end

return FollowerSkillItemView;