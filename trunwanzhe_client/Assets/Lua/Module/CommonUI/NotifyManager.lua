local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local NotifyManager = mLuaClass("ActivityOpenServerVO", mBaseLua);

function NotifyManager:OnLuaNew()
	self.mDicNotify = {};
	self.mDicNotifyCache = {};
end

function NotifyManager:CreateNotifyView(em, go)
    self.mDicNotify[em] = go;
    self:Notify(em);
end

function NotifyManager:OnShowNotify(em, show)
    self.mDicNotifyCache[em] = show;
    self:Notify(em);
end

function NotifyManager:Notify(em)
    local go = self.mDicNotify[em];
	local show = self.mDicNotifyCache[em];
    if go ~= nil and show ~= nil then
    	go:SetActive(show);
    end
end

function NotifyManager:Dispose( )
	self.mDicNotify = {};
end

local instance = NotifyManager.LuaNew();
return instance;