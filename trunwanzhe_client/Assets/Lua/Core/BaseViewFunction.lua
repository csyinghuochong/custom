local mLuaClass = require "Core/LuaClass"
local mEventDispatcherInterface = require "Events/EventDispatcherInterface"
local BaseViewFunction = mLuaClass("BaseViewFunction",mEventDispatcherInterface);
local mColor = Color;

function BaseViewFunction:FindChild(path)
	local t = self.mTransform:Find(path);
	if t == nil then
		return t;
	end

	local go = t.gameObject;
	local btn = go:GetComponent("UIButton");
	if go ~= nil and btn ~= nil then
		btn.hover = mColor.white;
		btn.pressed = mColor.white;
		btn.duration = 0;

		local scale = go:GetComponent("UIButtonScale");
		if scale == nil then
			go:AddComponent("UIButtonScale");
		end
	end

	return go;
end

function BaseViewFunction:FindComponent(name, component)
	if name == nil or name == "" then
		return self.mTransform:GetComponent(component);
	else
		return self:FindChild(name):GetComponent(component);
	end
end

return BaseViewFunction;