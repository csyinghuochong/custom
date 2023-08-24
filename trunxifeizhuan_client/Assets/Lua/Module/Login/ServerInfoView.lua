local mQueueWindow = require "Core/QueueWindow"
local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameModelManager = require "Manager/GameModelManager"
local ServerInfoView = mLuaClass("ServerInfoView",mQueueWindow);
local mAreaItemVO = require"Module/Login/AreaItemVO";
local mServerItemVO = require"Module/Login/ServerItemVO";
local mViewBgEnum = require "Enum/ViewBgEnum"
local mLayoutController = require "Core/Layout/LayoutController"
local mSortTable = require "Common/SortTable"

local mLanguageUtil = require "Utils/LanguageUtil"
local mServer = mLanguageUtil.server;
local mLastLogin = mLanguageUtil.last_login;
local mString = require "string"
local mTable = require "table"

function ServerInfoView:InitViewParam()
	return {
		["viewPath"] = "ui/login/",
		["viewName"] = "server_info_view",
		["ParentLayer"] = mLoginLayer1,
		["viewBgEnum"] = mViewBgEnum.transparent,
	};
end

function ServerInfoView:Init()
	self.mAreaGridEx = nil;
	self.mServerGridEx = nil;
	self.mServerData = {};
	
	self.text_commend_server = self:FindComponent('Button_commend_server/Text_server', 'Text');
	self:FindAndAddClickListener('Button_commend_server',function() self:OnClickCommendServer() end);
	self:FindAndAddClickListener('common_bg/btnClose',function() self:HideView() end);

	local area_parent = self:Find('ServerList/Grid');
	self.mServerGridEx = mLayoutController.LuaNew(area_parent, require "Module/Login/ServerItemView");

	self:InitAreaList();
	self:ShowCommendServer();
end

function ServerInfoView:ShowCommendServer()
	local loginModel = mGameModelManager.LoginModel;
	local new_server = loginModel:GetNewServer();

	self.text_commend_server.text = tostring(new_server.sid)..mServer..new_server.sname;
end

function ServerInfoView:OnClickCommendServer()
	local loginModel = mGameModelManager.LoginModel;
	local new_server = loginModel:GetNewServer();
	self:OnSelectServer(new_server.sid);
end

function ServerInfoView:OnSelectServer(server_id)
	local loginModel = mGameModelManager.LoginModel;
	loginModel:SetLastServer(server_id);
	self:Dispatch(mEventEnum.LOGIN_SELECT_SERVER);
	self:HideView();
end

function ServerInfoView:OnClickServerItem(data)
	self:OnSelectServer(data.mID);
end

function ServerInfoView:OnClickAreaItem(index)
	local loginModel = mGameModelManager.LoginModel;
	local list = loginModel:GetServerListVO(index);
	local new_count = mTable.getn(list);
	local data = self.mServerData;

	data = mSortTable.LuaNew(function(a, b) return a.mID > b.mID end, nil, true);
	for i = 1, new_count do
		local item = list[i];
		area_name = tostring(item.sid)..mServer..item.sname;
		data:AddOrUpdate(i, mServerItemVO.LuaNew(item.sid, area_name, function(data) self:OnClickServerItem(data) end));
	end

	self.mServerGridEx:UpdateDataSource(data);
	self.mServerData = data;
end

function ServerInfoView:ShowServerList()
	
end

function ServerInfoView:InitAreaList()
	local loginModel = mGameModelManager.LoginModel;
	local area_count = loginModel:GetAreaCount();
	local area_per_server = loginModel.mAreaPerItem;

	local data = mSortTable.LuaNew(function(a, b) return a.mID > b.mID end, nil, true);
	for i = 1, area_count do

		local area_name;
		if i == area_count then
			area_name = mLastLogin;
		else
			area_name = tostring(i * area_per_server - (area_per_server - 1))..'-'..tostring(i * area_per_server).."服";
		end

		data:AddOrUpdate(i, mAreaItemVO.LuaNew(i, area_name, function(index) self:OnClickAreaItem(index) end));
	end

	local area_parent = self:Find('Scroll_Area/Grid');
	local grid = mLayoutController.LuaNew(area_parent, require "Module/Login/AreaItemView");
	grid:UpdateDataSource(data, function() 
		grid:GetChild(1):ClickAreaItem();
	end);
	self.mAreaGridEx = grid;
end

function ServerInfoView:Dispose()
	local grid_ex = self.mAreaGridEx;

	if(grid_ex~= nil) then
		 grid_ex:Dispose();
		 grid_ex = nil;
	end
end

return ServerInfoView;