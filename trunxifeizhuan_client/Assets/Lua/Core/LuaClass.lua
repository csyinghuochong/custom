local Application = UnityEngine.Application;
local mClassDefine = {};

local mLuaClass = function(className,super)
	local cls = {};
	
	if super then
		setmetatable(cls,{__index = super});
	end

	if Application.isEditor then
		if not className then
			error("类名为空");
		end

		if mClassDefine[className] then
			error(className .. "类名重复了");
		end

		mClassDefine[className] = true;
	end
	
	cls.LuaSuper = super;
	cls.LuaClassName = className;
	cls.__index = cls;
	
	function cls.LuaNew(...)
		local instance = setmetatable({},cls);
		instance.LuaClass = cls;
		instance:OnLuaNew(...);
		return instance;
	end
	
	return cls;
end

return mLuaClass;