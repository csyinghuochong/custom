local mLuaClass = require "Core/LuaClass"
local BaseView = require "Core/BaseView"
local BalanceMoneyView = mLuaClass("BalanceMoneyView", BaseView);
local mDoFileUtil = require "Utils/DoFileUtil";
local GameObject = UnityEngine.GameObject;

local mItemViewTypes = {
	[1] = "Module/Balance/RewardMoneyItemView";
	[2] = "Module/Balance/RewardGoodsItemView";
}
function BalanceMoneyView:SetItemFormations(fomations)
	self.mFormations = mFormations;
end

function BalanceMoneyView:GetItemFormations()

	local fomations = self.mFormations;
	if not fomations then
		fomations = {{},{},{},{},{},{}};
		fomations[1] = {{x = 0,y = 0,z = 0};}
		fomations[2] = {{x = -80,y = 0,z = 0};{x = 80,y = 0,z = 0};}
		fomations[3] = {{x = -150,y = 0,z = 0};{x = 0,y = 0,z = 0};{x = 150,y = 0,z = 0};}
		fomations[4] = {{x = -80,y = 20,z = 0};{x = 80,y = 20,z = 0};{x = -80,y = -25,z = 0};{x = 80,y = -25,z = 0};}
		fomations[5] = {{x = -80,y = 20,z = 0};{x = 80,y = 20,z = 0};{x = -150,y = -25,z = 0};{x = 0,y = -25,z = 0};{x = 150,y = -25,z = 0};}
		self.mFormations = fomations;
	end

	return fomations;
end

function BalanceMoneyView:OnViewHide()
	local views = self.mItemViews;
	if views then
		for k,v in pairs(views) do
			v:HideView();
		end
	end
end

function BalanceMoneyView:GetItemList(data)
	local items = data.mItems;
	local list = nil;
	if items then
		list = items[self.mItemType];
	end
	return list;
end

function BalanceMoneyView:GetTalentList(data)
	return data.mTalents;
end

function BalanceMoneyView:OnViewShow(list)
	if list then
		local views = self.mItemViews;
		if not views then
			views = {};
			self.mItemViews = views;
		end
		
		local root = self.mTransform;
		local item = root:Find("item").gameObject;
		local itemViewType = mDoFileUtil:DoFile(mItemViewTypes[self.mItemType]);
		for i,v in ipairs(list) do
			local view = views[i];
			if not view then
				view = itemViewType.LuaNew(GameObject.Instantiate(item));
				views[i] = view;
			end
			view:SetPosition(root, Vector3.zero);
			view:ForceShowView(v);
		end
	end
end

function BalanceMoneyView:Dispose( )
	self.mItemViews = nil;
	self.mFormations = nil;
end

return BalanceMoneyView;