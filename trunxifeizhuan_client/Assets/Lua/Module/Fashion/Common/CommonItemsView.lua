local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mDoFileUtil = require "Utils/DoFileUtil";
local CommonItemsView = mLuaClass("CommonItemsView",mBaseLua);
local ipairs = ipairs;

function CommonItemsView.InitItemViews(itemRoot,viewTypeName)
	local viewType = mDoFileUtil:DoFile(viewTypeName);
	local views = {};
	local itemCount = itemRoot.childCount;
	for i = 1,itemCount do
		local view = viewType.LuaNew(itemRoot:GetChild(i-1).gameObject);
		view:SetIndex(i);
		views[i] = view;
	end
	local instance = CommonItemsView.LuaNew();
	instance.mViews = views;
	instance.mRoot = itemRoot.gameObject;
	return instance;
end

function CommonItemsView.CreateItemViews(itemRoot,viewTypeName,itemCount)
	local viewType = mDoFileUtil:DoFile(viewTypeName);
	local views = {};
	for i = 1,itemCount do
		local view = viewType.LuaNew();
		view:SetIndex(i);
		view:SetItemRoot(itemRoot);
		views[i] = view;
	end

	local instance = CommonItemsView.LuaNew();
	instance.mViews = views;
	instance.mRoot = itemRoot.gameObject;
	return instance;
end

function CommonItemsView:ShowView(datas)
	self.mRoot:SetActive(true);
	self:OnUpdateView(datas);
end

function CommonItemsView:OnUpdateView(datas)
	local views = self.mViews;
	for i,v in ipairs(views) do
		local data = datas[i];
		if data then
			v:ForceShowView(data);
		else
			v:HideView();
		end
	end
end

function CommonItemsView:HideView()
	self.mRoot:SetActive(false);
end

function CommonItemsView:UpdateItemViewByIndex(index,data)
	local views = self.mViews;
	local view = self.mViews[index];
	if view then
		view:ForceShowView(data);
	end
end

function CommonItemsView:GetItemView(index)
	return self.mViews[index];
end

function CommonItemsView:Dispose()
	local views = self.mViews;
	if views then
		for i,v in ipairs(views) do
			v:CloseView();
		end
		self.mViews = nil;
	end
	self.mRoot = nil;
end

return CommonItemsView;