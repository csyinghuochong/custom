local mLuaClass = require "Core/LuaClass"
local BaseLua = mLuaClass("BaseLua");

function BaseLua:OnLuaNew()
	
end

function BaseLua:GetSuper( superClsName )
	if not superClsName then
		error("BaseLua:GetSuper superClsName is nil");
		return nil;
	end

	local super = self.LuaSuper;

	while super do
		if super.LuaClassName == superClsName then
			return super;
		end

		super = super.LuaSuper;
	end

	return nil;
end

return BaseLua;