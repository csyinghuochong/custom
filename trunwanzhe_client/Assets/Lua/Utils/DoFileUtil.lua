local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"

local DoFileUtil = mLuaClass("DoFileUtil",mBaseLua);
local mRequire = require;

function DoFileUtil:DoFile(luaPath)
	local luaModule = self[luaPath];
	if not luaModule then
		luaModule = mRequire(luaPath);
		self[luaPath] = luaModule;
	end

	return luaModule;
end

local instance = DoFileUtil.LuaNew();
return instance;