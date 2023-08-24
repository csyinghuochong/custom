local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mOtherPlayerVO = require "Module/Friend/OtherPlayerVO"
local mSortTable = require "Common/SortTable"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mFollowerVO = require "Module/Follower/FollowerVO"
local mLeadVO = require "Module/Lead/LeadVO"
local CheckModel = mLuaClass("CheckModel",mBaseModel);

function CheckModel:OnLuaNew()
	self.mDataSoureFollower1 = mSortTable.LuaNew(function(a, b) return self:Sort(a,b) end, nil, true);
	self.mDataSoureFollower2 = mSortTable.LuaNew(function(a, b) return self:Sort(a,b) end, nil, true);
end

function CheckModel:OnRecvOtherPlayer(pbOtherPlayer)
	local player = mOtherPlayerVO.LuaNew(pbOtherPlayer);
	self.mFollowerList = pbOtherPlayer.partner_list;
	self:CreateFollowerList(pbOtherPlayer);
	mUIManager:HandleUI(mViewEnum.CheckView,1,player);
end

function CheckModel:CreateFollowerList(pbOtherPlayer)
	if pbOtherPlayer ~= nil then
		local uid = nil;
		local followerVo = nil;
		local followerList1 = self.mDataSoureFollower1;
		local followerList2 = self.mDataSoureFollower2;
		followerList1:ClearDatas(false);
		followerList2:ClearDatas(false);

		for k, v in ipairs(pbOtherPlayer.partner_list) do
			uid = v.id;
			if v.main == 1 then
				self.mLeadID = uid;
				followerVo = mLeadVO.LuaNew();
				followerVo:InitFollowerData(v, false, pbOtherPlayer.sex);
			else
				followerVo = mFollowerVO.LuaNew();
				followerVo:InitFollowerData(v, false);
			end

			if v.main ~= 1 then
				followerList1:AddOrUpdate(uid, followerVo);
			else
				self.mPlayerVO = followerVo;
			end
			followerList2:AddOrUpdate(uid, followerVo);
		end
	end
end

function CheckModel:Sort( a, b )
	local aTime = a.mGetTimeTamp;
	local bTime = b.mGetTimeTamp;
	local aId = a.mID;
	local bId = b.mID;
	if aTime == bTime then
		return aId < bId;
	else
		return aTime < bTime;
	end
end

return CheckModel;