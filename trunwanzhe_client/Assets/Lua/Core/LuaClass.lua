local mLuaClass = function(className,super)
	local cls = {};
	
	if super then
		setmetatable(cls,{__index = super});
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