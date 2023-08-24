local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mCommonToggleButton = require "Module/CommonUI/TabView/CommonToggleButton"
local mCommonMoveToggleButton = require "Module/CommonUI/TabView/CommonMoveToggleButton"
local CommonTabView = mLuaClass("CommonTabView");
local mString = require 'string'
local mSuper;

function CommonTabView:OnLuaNew(trans, view_vo_list, call_back, get_data_back, normalColor, selectColor, isMoveButton)
	self.mTransform = trans;
	local clickButtonBack = function ( index )
		self:OnClickToggleButton(index,true);
	end
	self.mNormalColor = normalColor;
	self.mSelectColor = selectColor;
	local toggle_list = {};
	local button_node = self:Find('buttonView');
	local button_number = button_node.childCount;
	for i = 1, button_number do
		local toggle = {};
		local button_go = button_node:GetChild(i - 1).gameObject;
		if isMoveButton then
			toggle.btn = mCommonMoveToggleButton.LuaNew(i, button_go, clickButtonBack);
		else
			toggle.btn = mCommonToggleButton.LuaNew(i, button_go, clickButtonBack, self.mSelectColor ~= nil);
		end
		toggle.btn:SetSelected(false,self.mNormalColor);

		if view_vo_list ~= nil then
			toggle.view_vo = view_vo_list[i];
		end
	
		toggle_list[i] = toggle;
	end
	self.mToggleList = toggle_list;

	self.mCallBack = call_back;
	self.mGetDataBack = get_data_back;
end

function CommonTabView:Find( name )
	return self.mTransform:Find(name);
end

function CommonTabView:GetSubView(view_vo)
	local view = nil;
	
	if view_vo ~= nil then
		local view_item = require(view_vo.luaClass);
		local go_path = view_vo.childPath;

		if go_path ~= nil and go_path ~= "" then
			local view_go = self:Find(go_path).gameObject;
			view = view_item.LuaNew(view_go);
		else
			view = view_item.LuaNew();
			if view.mViewParams ~= nil then
				view.mViewParams.ParentLayer = self.mTransform;
			end
		end
		
	end
	return view;
end

function CommonTabView:SetSubViewVisible(index, show)
	if index == nil then
		return;
	end

	local toggle_list = self.mToggleList;
	local toggle = toggle_list[index];
	if show then
		toggle.btn:SetSelected(show,self.mSelectColor);
	else
		toggle.btn:SetSelected(show,self.mNormalColor);
	end

	if toggle.view_vo == nil then
		return;
	end

	local view = toggle.view;
	if show then
		if view == nil then
			view = self:GetSubView(toggle.view_vo);
			toggle.view = view;
		end

		local data = self:CallDataBack();
		view:ShowView(data);
	else
		if view ~= nil then
			view:HideView();
		end
	end
end

function CommonTabView:CallDataBack()
	local get_back = self.mGetDataBack;
	if get_back ~= nil then
		return get_back();
	end

	return nil;
end

--外部调用
function CommonTabView:SetRedPoint(redPointList)
	for i,v in ipairs(self.mToggleList) do
		v.btn:SetRedPoint(redPointList[i]);
	end
end

function CommonTabView:SetRedPointForIndex(index,state)
	self.mToggleList[index].btn:SetRedPoint(state);
end

function CommonTabView:OnClickToggleButton(index, call)
	self:ChangeSubView(index,call);
end

function CommonTabView:ShowView()
	self:UpdateSubView(true);
end

function CommonTabView:GetViewByIndex( index )
	local toggle = self.mToggleList[ index ];
	return toggle and toggle.view or nil;
end

function CommonTabView:GetCurrentView()
	return self.mToggleList[self.mSelectIndex].view;
end

function CommonTabView:ChangeSubView(index, call)
	local last_index = self.mSelectIndex;
	if last_index == index or index == nil then
		return;
	end
	self:SetSubViewVisible(last_index, false);
	self:SetSubViewVisible(index, true);
	self.mSelectIndex = index;

	local call_back = self.mCallBack;
	if call_back ~= nil and call ==  true then
		call_back(index);
	end
end

function CommonTabView:UpdateSubView(show)
	local view = self:GetCurrentView();
	local data = self:CallDataBack();

	if show then
		if view.mIsShow and view.mGameObject ~=nil then
			view:OnUpdateUI(data);
		else
			view:ShowView(data);
		end
	else
		view:HideView();
	end
	
end

function CommonTabView:HideView()
	self:GetCurrentView():HideView();
end

function CommonTabView:CloseView()
	local view_list = self.mToggleList;
	for k, v in pairs(view_list) do
		if v.view ~= nil then
			v.view:CloseView();
		end
	end

	self.mSelectIndex = nil;
	self.mCallBack = nil;
	self.mToggleList = nil;
end

return CommonTabView;