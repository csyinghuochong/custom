local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mPlayerPrefs = UnityEngine.PlayerPrefs;
local mMath = require "math"
local mTable = require "table"
local mGameTimer = require "Core/Timer/GameTimer"
local mEventDispatcher = require "Events/EventDispatcher"
local mEventEnum = require "Enum/EventEnum"

local LoginModel = mLuaClass("LoginModel",mBaseModel);

function LoginModel:OnLuaNew()
	self.mAreaPerItem = 10;

	self.mAccount = mPlayerPrefs.GetString('Account');
	self.mPassword = mPlayerPrefs.GetString('Password'); 
	self.mLastServerID = mPlayerPrefs.GetInt('LastServerID'); 
	self.mServerTimeDiffer = 0; --服务器与客户端的时间差
	self:SendTimeMsgIfNextDay();
end

function LoginModel:OnDispose()
	local timer = self.mGameTimer;
	if timer then
		timer:Dispose();
		self.mGameTimer = nil;
	end
end

function LoginModel:CheckAccountAndPassword(account, password)
	if account == "" or password == "" then
		return false;
	elseif account ~= self.mAccount or password ~= self.mPassword then
		return false;
	else
		return true;
	end
end

--获取当前时间戳
function LoginModel:GetCurrentTime()
	return self.mServerTimeDiffer + os.time();
end

--设置明天00:00:00时派发消息
function LoginModel:SendTimeMsgIfNextDay()
	local time = self:GetCurrentTime();
	local yearNum = tonumber(os.date("%Y",time));
	local monthNum = tonumber(os.date("%m",time));
	local dayNum = tonumber(os.date("%d",time));
	local timeToZero = os.time({year=yearNum,month=monthNum,day=dayNum,hour=24,minute=59,second=59}) + 1 - time ;
	self.mGameTimer = mGameTimer.HandSetTimeout(timeToZero,function()self:SendNextDay();end);
end

function LoginModel:SendNextDay()
	mEventDispatcher:Dispatch(mEventEnum.LOGIN_NEW_DAY);
	self.mGameTimer = mGameTimer.HandSetTimeout(86400,function()self:SendNextDay();end);
end

function LoginModel:InitServerInfo(data)
	self.mServerListVO = data;

	local last_id = self.mLastServerID;
	local per_item = self.mAreaPerItem;
	local server_list = data.DEV;
	local server_count = mTable.getn(server_list);
	local area_count = 1 + mMath.ceil(server_count / per_item);

	local area_list = {};
	local last_servervo = nil;
	area_list[area_count] = {};
	mTable.sort(server_list, function(a, b ) return a.sid < b.sid end );
	for k , v in pairs(server_list) do
		local serverId = v.sid;

		if serverId == last_id then
			mTable.insert(area_list[area_count], v);
			last_servervo = v;
		end

		local areaIndex = mMath.ceil(k / per_item);
		local serverIndex = k % per_item;
		serverIndex =  serverIndex == 0 and per_item  or serverIndex;
		if area_list[areaIndex] == nil then
			area_list[areaIndex] = {};
		end
		area_list[areaIndex][serverIndex] = v;
	end

	if(last_servervo == nil) then
		last_servervo = server_list[server_count];
	end
	self.mLastServerVO = last_servervo;
	self.mServerToArea = area_list;
end

function LoginModel:GetServerListVO(area)
	return self.mServerToArea[area];
end

function LoginModel:GetAreaCount()
	return mTable.getn(self.mServerToArea);
end

function LoginModel:GetLastServer()
	return self.mLastServerVO;
end

function LoginModel:GetNewServer()
	local server_list = self.mServerListVO.DEV;
	local server_count = mTable.getn(server_list);
	return server_list[server_count];
end

function LoginModel:SetAccount(account)
	self.mAccount = account;
	mPlayerPrefs.SetString("Account", account);
end

function LoginModel:SetLastServer(server_id)
	self.mLastServerID = server_id;
	local server_list = self.mServerListVO.DEV;
	local server_count = mTable.getn(server_list);
	for i = 1, server_count do
		local item = server_list[i];
		if item.sid == server_id then
			self.mLastServerVO = item;
			break;
		end
	end

	mPlayerPrefs.SetInt('LastServerID', server_id); 
end

function LoginModel:SetPassword(password)
	self.mPassword = password;
	mPlayerPrefs.SetString("Password", password);
end

return LoginModel;