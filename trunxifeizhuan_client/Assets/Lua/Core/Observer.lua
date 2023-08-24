local LuaClass = require "Core/LuaClass"
local Observer = LuaClass("Observer");

function Observer:OnLuaNew(observable)
	self.mObservable = observable;
end

function Observer:GetObservable()
	return self.mObservable;
end

function Observer:SetObservable(observable)
	self:RemoveListeners();
	self.mObservable = observable;
end

function Observer:RegisterListener(type,listener)
	local observable = self:GetObservable();

	if not observable then
		return;
	end

	local listeners = self.mRegisterListeners;
	if not listeners then
		listeners = {};
		self.mRegisterListeners = listeners;
	end

	table.insert( listeners,{type,listener});
	observable:AddObserver(type,listener);
end

function Observer:RemoveListeners()
	local listeners = self.mRegisterListeners;
	local observable = self:GetObservable();
	if listeners and observable then	
		for i,v in ipairs(listeners) do
			observable:RemoveObserver(v[1],v[2]);
		end
	end
	self.mRegisterListeners = nil;
end

function Observer:Dispose()
end

return Observer;