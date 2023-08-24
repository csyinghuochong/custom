local mLuaClass = require "Core/LuaClass";
local mLayoutItem = require "Core/Layout/LayoutItem";
local mChatController = require "Module/Chat/ChatController";
local mGmContraoller = require "Module/Gm/GmController";
local GmItemView = mLuaClass("GmItemView", mLayoutItem);
local mGameTimer = require "Core/Timer/GameTimer";
local mTimeUtil = require "Utils/TimeUtil";
local mGmHrl = require "Module/Gm/GmHrl";

function GmItemView:InitViewParam()
	return {
		["viewPath"] = "ui/gm/",
		["viewName"] = "gm_item_view",
	};
end

function GmItemView:Init()
	self.mInput = self:FindComponent('InputField/Placeholder','Text');
	self.mInput2 = self:FindComponent('InputField', 'InputField');
	self.mButtonText = self:FindComponent('Button/Text', 'Text');
	self.mButton = self:FindComponent('Button', 'Button');

	self:FindAndAddClickListener("Button", function() self:OnClickInputField() end);
	self.mTimer = mGameTimer.SetInterval(1, function() self:OnUpdateTimer() end);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function GmItemView:OnUpdateTimer()
	local data = self.mData;
	if data.e_cmd == "server_time" then
		data.params = data.params + 1;
		self.mInput.text = self:ShowParams(data);		
	end
end

function GmItemView:OnUpdateData(_data)
	local data = self.mData;
	-- local data = self:Convert(self.mData);

	self.mInput.text = self:ShowParams(data);
	self.mButtonText.text = data.z_cmd;
	-- 类型为2的为服务器参数，禁止点击
	if data.type == mGmHrl.mType2 then
		self.mButton.interactable = false;
		self.mInput2.interactable = false;
		self.mInput2.text = nil;
	elseif data.params == "" then
		self.mInput2.interactable = false;
	else
		self.mInput2.interactable = true;
		self.mButton.interactable = true
	end
end

function GmItemView:ShowParams(data)
	local ecmd = data.e_cmd;
	local showParams = nil;
	if ecmd == "open_time" then
		showParams = mTimeUtil:TransToYearMonthDayHMS(data.params);
	elseif ecmd == "server_time" then
		showParams = mTimeUtil:TransToYearMonthDayHMS(data.params);
	else
		showParams = data.params;
	end
	return showParams;
end

function GmItemView:Convert(data)
	local ecmd = data.e_cmd;
	if ecmd == "open_time" then
		data2.params = mTimeUtil:TransToYearMonthDayHMS(data.params);
	elseif ecmd == "server_time" then
		data2.params = mTimeUtil:TransToYearMonthDayHMS(data.params);
	end
	return data;
end

function GmItemView:OnClickInputField()
	local cmd = nil;
	if self:IsFight() then
		mGmContraoller:Fight();
	else
		if self.mInput2.text ~= "" then
			cmd = self:InputCmd();
		else
			cmd = self:DefaultCmd();
		end
		self:SendCmd(cmd);
	end
end

function GmItemView:InputCmd()
	local data = self.mData;
	local inputText = self.mInput2.text;
	local cmd = "$" .. data.e_cmd;
	if data.params ~= "" then
		cmd = cmd .. "=" .. inputText;
	end
	return cmd;
end

function GmItemView:DefaultCmd()
	local data = self.mData;
	local cmd = "$" .. data.e_cmd;
	if data.params ~= "" then
		cmd = cmd .. "=" .. data.params;
	end
	return cmd;
end

function GmItemView:IsFight()
	local data = self.mData;
	return data.e_cmd == "fight" and true or false;
end

function GmItemView:SendCmd(cmd)
	mChatController:SendChat(1, cmd, 0);
end

function GmItemView:Dispose()
	local timer = self.mTimer;
	if timer ~= nil then
		timer:Dispose();
		self.mTimer = nil;
	end
end

return GmItemView;