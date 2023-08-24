local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mCommonToggleButton = require "Module/CommonUI/TabView/CommonToggleButton"

local CommonToggleGroup = mLuaClass("CommonToggleGroup",mBaseLua);

function CommonToggleGroup:OnLuaNew(transform, callback,defaultIndex,normalColor,selectColor)
	local button_list = {};
	local clickButtonBack = function ( index )
		self:OnClickToggleButton(index,true);
	end

	self.mNormalColor = normalColor;
	self.mSelectColor = selectColor;

	local count = transform.childCount;
	for i = 1,count do
		local go = transform:GetChild(i - 1).gameObject;
        button_list[i] = mCommonToggleButton.LuaNew(i, go, clickButtonBack,self.mNormalColor ~= nil);
        button_list[i]:SetSelected(false);
	end
	self.mButton_list = button_list;
	self.mCallback = callback;
	local index = defaultIndex or 1;
	self:OnClickToggleButton(index);
end

function CommonToggleGroup:SetCanAlwaysReturn(  )
	self.mAlwayRetrun = true;
end

function CommonToggleGroup:CancelCurrentSelect(  )
	local last_index = self.mSelectIndex;
	local button_list = self.mButton_list;
	if last_index ~= nil then
		button_list[last_index]:SetSelected(false,self.mNormalColor);
	end
	self.mSelectIndex = nil;
end

function CommonToggleGroup:OnClickToggleButton(index,flag)
    local last_index = self.mSelectIndex;

	if last_index == index and self.mAlwayRetrun ~= true then
		return;
	end

	local button_list = self.mButton_list;
	if last_index ~= nil then
		button_list[last_index]:SetSelected(false,self.mNormalColor);
	end	
	button_list[index]:SetSelected(true,self.mSelectColor);
	self.mSelectIndex = index;

	local call_back = self.mCallback;
	if call_back ~= nil and flag ==  true then
		call_back(index);
	end
end

--外部调用
function CommonToggleGroup:SetRedPoint(redPointList)
	for i,v in ipairs(self.mButton_list) do
		v:SetRedPoint(redPointList[i]);
	end
end

--外部调用
function CommonToggleGroup:SwitchToogle(index)
	self:OnClickToggleButton(index,true);
end


return CommonToggleGroup;