local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mTable = require "table"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local BuffView = mLuaClass("BuffView",mBaseView);
local GameObject = UnityEngine.GameObject;
local PoolManager = require "Common/PoolManager"
local mBaseViewPool = PoolManager.mBaseViewPool;
local pairs = pairs;


function BuffView:OnViewShow(logicParams)
	if logicParams then
		local buffs = logicParams:GetBuffs();
		for k,v in pairs(buffs) do
			self:OnAddBuff(v);
		end
		self.mActor = logicParams;
		self:AddObservers(logicParams);
	end
end

function BuffView:AddObservers(actor)

	local component = actor:AddComponent("ActorObserver","BuffViewComponent");
	local mNotifyEnum = component:GetNotifyEnum();

	component:RegisterListener(mNotifyEnum.OnAddBuff,function (buff)
		self:OnAddBuff(buff);
	end);
	component:RegisterListener(mNotifyEnum.OnRemoveBuff,function (buff)
		self:OnRemoveBuff(buff);
	end);
	component:RegisterListener(mNotifyEnum.OnBuffUpdate,function (buff)
		self:OnBuffUpdate(buff);
	end);
	component:RegisterListener(mNotifyEnum.OnEndRound,function (buff)
		self:OnEndRound();
	end);
end

function BuffView:RemoveObservers(actor)
	if actor then
		actor:RemoveComponent("BuffViewComponent");
	end
end

function BuffView:OnViewHide()
	local items = self.mBuffItems;
	if items then
		for k,v in pairs(items) do
			v:HideView();
			mBaseViewPool:Put(v,"Module/Combat/BuffItemView");
		end
		self.mBuffItems = nil;
	end
	self:RemoveObservers(self.mActor);
end

function BuffView:OnEndRound()
	local items = self.mBuffItems;
	if items then
		for k,v in pairs(items) do
			v:Update();
		end
	end
end

function BuffView:OnBuffUpdate(buff)
	local icon = buff.mIcon;
	if not icon then
		return;
	end

	local items = self.mBuffItems;

	if not items then
		return;
	end

	local key = self:GetItemKey(buff,icon);
	local item = items[key];
	if item then
		item:Update();
	end
end

function BuffView:GetItemKey(buff,icon)
	if buff.mConfig.state == 2013 then
		return buff.mUniqueId;
	end
	return icon;
end

function BuffView:OnRemoveBuff(buff)
	local icon = buff.mIcon;
	if not icon then
		return;
	end

	local items = self.mBuffItems;

	if not items then
		return;
	end

	local key = self:GetItemKey(buff,icon);
	local item = items[key];
	if item then
		item:OnRemoveBuff(buff);
		if item:GetBuffCount() == 0 then
			item:HideView();
			mBaseViewPool:Put(item,"Module/Combat/BuffItemView");
			items[key] = nil;
		end
	end
end

function BuffView:OnAddBuff(buff)
	local icon = buff.mIcon;
	if not icon then
		return;
	end

	local items = self.mBuffItems;
	if not items then
		items = {};
		self.mBuffItems = items;
	end

	local key = self:GetItemKey(buff,icon);
	local item = items[key];
	if not item then
		item = mBaseViewPool:Get("Module/Combat/BuffItemView");
		item:ShowView(function ()
			item:UpdateIcon(icon);
			item:SetParent(self.mTransform);
		end);
		items[key] = item;
	end
	item:OnAddBuff(buff);
end

return BuffView;