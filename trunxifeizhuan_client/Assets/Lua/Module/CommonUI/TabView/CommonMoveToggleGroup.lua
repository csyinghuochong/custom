local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mCommonMoveToggleButton = require "Module/CommonUI/TabView/CommonMoveToggleButton"

local CommonMoveToggleGroup = mLuaClass("CommonMoveToggleGroup",mBaseLua);

function CommonMoveToggleGroup:OnLuaNew(transform, callback,defaultIndex)
	local button_list = {};
	local clickButtonBack = function ( index )
		self:OnClickToggleButton(index,true);
	end

	local count = transform.childCount;
	for i = 1,count do
		local go = transform:GetChild(i - 1).gameObject;
        button_list[i] = mCommonMoveToggleButton.LuaNew(i, go, clickButtonBack);
        button_list[i]:SetSelected(false);
	end
	self.mButton_list = button_list;
	self.mCallback = callback;
	local index = defaultIndex or 1;
	self:OnClickToggleButton(index);
end

function CommonMoveToggleGroup:OnClickToggleButton(index,flag)
    local last_index = self.mSelectIndex;
	if last_index == index then
		return;
	end

	local button_list = self.mButton_list;
	if last_index ~= nil then
		button_list[last_index]:SetSelected(false);
	end	
	button_list[index]:SetSelected(true);
	self.mSelectIndex = index;

	local call_back = self.mCallback;
	if call_back ~= nil and flag ==  true then
		call_back(index);
	end
end

--外部调用
function CommonMoveToggleGroup:SetRedPoint(redPointList)
	for i,v in ipairs(self.mButton_list) do
		v:SetRedPoint(redPointList[i]);
	end
end

--外部调用
function CommonMoveToggleGroup:SwitchToogle(index)
	self:OnClickToggleButton(index,true);
end


return CommonMoveToggleGroup;