local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mSortTable = require "Common/SortTable"
local mActorConfig = require "ConfigFiles/ConfigSysactor"
local mDraftConfig = require "ConfigFiles/ConfigSysdraft"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mDraftChipConfig = require "ConfigFiles/ConfigSysdraft_chip"
local mDraftDataVO = require "Module/Draft/DraftDataVO"
local mEventEnum = require "Enum/EventEnum"
local mFollowerVOControl = require "Module/Follower/FollowerVOControl"
local mGameModelManager = require "Manager/GameModelManager"
local DraftModel = mLuaClass("DraftModel",mBaseModel);
local mipairs = ipairs

function DraftModel:OnLuaNew()
	self.mCommonChipId = mConfigSysglobal_value[mConfigGlobalConst.COMMON_CHIP];
	self.mRandomCampChipId = mConfigSysglobal_value[mConfigGlobalConst.RANDOM_CAMP_CHIP];
	self.mBagUpdate = false;
end

function DraftModel:RecvSpecialDraftGroup(pbDraftGroup)
	 local specialDraftList =  {};
	 for i=1,4 do
	 	specialDraftList[i] = mSortTable.LuaNew();
	 end
	 for k,v in mipairs(pbDraftGroup.List) do
	 	for i,value in mipairs(v.partner_id) do
	 		local data = mFollowerVOControl:CreateConfigFollowerVO(value);
	 	    specialDraftList[k]:AddOrUpdate(i,data);
	 	end

	 end
	 --print(pbDraftGroup.time)
     self.mRefreshTime = pbDraftGroup.time;
	 self.mSpecialDraftList = specialDraftList;
end

function DraftModel:InitDefaultDraftList()
	local draftList = self.mDraftList;
	if draftList~= nil then
       draftList:ClearDatas(true);
	else
       draftList = mSortTable.LuaNew(function(a, b) return a.mId > b.mId end, nil, true);
	end
	local specialItem = {};
	local normalItem = {};
	local index = 1;
	local normalIndex = 1;
	for k,v in pairs(mDraftConfig) do
		local id = 1000 - v.index;
		local goods = v.goods_cost;
		local goodsId = v.icon;
		local name = v.draft_name;
		if v.type == 10 then
           id = 0;
		end
		local flag = true;
		local draftDataVO = mDraftDataVO.LuaNew(v.type,goodsId,name,id,v,goodsId);
		if v.show == 2 then
           specialItem[index] = draftDataVO;
           index = index + 1;
           local bagModel = mGameModelManager.BagModel;
           local number = bagModel:GetGoodsNumberGoodsId(goodsId,bagModel.mTypeEnum.ConSumeType);
           flag = number > 0;
        else
           normalItem[normalIndex] = goodsId;
           normalIndex = normalIndex + 1;
		end
		if flag then
           draftList:AddOrUpdate(goodsId,draftDataVO);
		end
	end
	self.mNormalItem = normalItem;--一直显示的列表
    self.mSpecialItem = specialItem;--有道具才显示的列表
	self.mDraftList = draftList;
end

--碎片发生变化检测是否有可以合成的或者删掉不够合成的(不包括已删除了的)
function DraftModel:CheckHaveChipToDraft()
	local bagModel = mGameModelManager.BagModel;
	local chipList = bagModel:GetGoodsListWithType(bagModel.mTypeEnum.DraftType);
	local commonChipId = self.mCommonChipId;
	local commonChipCount = bagModel:GetGoodsNumberGoodsId(commonChipId,bagModel.mTypeEnum.DraftType);
	local draftList = self.mDraftList;

    for i,v in mipairs(chipList.mSortTable) do
    	local id = v.mID;
    	if id ~= commonChipId and id ~= self.mRandomCampChipId and id > 0 then
           local count = bagModel:GetGoodsNumberGoodsId(id,bagModel.mTypeEnum.DraftType);
           local draftChipConfig = mDraftChipConfig[id];
           local needCount = draftChipConfig.goods_num;

           if draftChipConfig ~= nil then

           	  if count + commonChipCount >= needCount then
           	  local actorId = draftChipConfig.follow_list[1];
              local name = mActorConfig[actorId].name;
              draftList:AddOrUpdate(id,mDraftDataVO.LuaNew(0,actorId,name,count,nil,id));
              elseif draftList:GetValue(id) ~= nil then
                 if count + commonChipCount < needCount then
                    draftList:RemoveKey(id);
                    self:Dispatch(mEventEnum.ON_DRAFT_REMOVE_ITEM);
                 end 
              end
           end
    	end
    end
end

function DraftModel:CheckSpecialItem(id)
	for i,v in mipairs(self.mSpecialItem) do
		if v.mChipId == id then
           self.mDraftList:AddOrUpdate(id,v);
		end
	end
end

--碎片删除
function DraftModel:RemoveChip(id)
	for i,v in mipairs(self.mNormalItem) do
		if v == id or id == self.mCommonChipId then
           return ;
		end
	end
    self.mDraftList:RemoveKey(id);
    self:Dispatch(mEventEnum.ON_DRAFT_REMOVE_ITEM);
end

return DraftModel;