
local mLuaClass = require "Core/LuaClass";
local mBaseModel = require "Core/BaseModel";
local mSortTable = require "Common/SortTable";
local mEventEnum = require "Enum/EventEnum";
local mEventDispatcher = require "Events/EventDispatcher";
local mGameTimer = require "Core/Timer/GameTimer";
local mGmVO = require "Module/Gm/GmVO";
local mHrl = require "Module/Gm/GmHrl";
local GmModel = mLuaClass("GmModel", mBaseModel);

function GmModel:OnLuaNew()
	self.mDataSource = nil;
	self.mCmdTypeList = {};
end

function GmModel:OnRecvGmList(data)
	local count = 0;
	for k, v in pairs(mHrl) do
		count = count + 1;
	end
	for i = 1, count do
		self.mCmdTypeList[i] = mSortTable.LuaNew(nil, nil, false);
	end
	data = self:AdditionCmd(data);

	for k, v in pairs(data.list) do
	    if v then      
	      	if v.e_cmd ~= nil then
	        	local GmData = mGmVO.LuaNew(v);
	        	self.mCmdTypeList[GmData.type]:AddOrUpdate(GmData.e_cmd, GmData);
	      	end
	    end
	end
	mEventDispatcher:Dispatch(mEventEnum.ON_GM_GET_LIST);
end

-- 客户端自己附加一些命令。
function GmModel:AdditionCmd(data)
	
	-- table.insert(data.list, {type = mHrl.mType1, e_cmd = "fight", z_cmd = "测试战斗", params = "" });

	return data;
end

return GmModel;