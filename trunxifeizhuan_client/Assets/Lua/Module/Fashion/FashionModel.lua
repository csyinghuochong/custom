local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mConfigSysfashion = require "ConfigFiles/ConfigSysfashion"
local mConfigSysfashion_suit = require "ConfigFiles/ConfigSysfashion_suit"
local FashionVO = require "Module/Fashion/FashionVO"
local FashionSuitVO = require "Module/Fashion/FashionSuitVO"
local mEventEnum = require "Enum/EventEnum"
local FashionModel = mLuaClass("FashionModel", mBaseModel);
local SortTable = require "Common/SortTable"
local mGameModelManager = require "Manager/GameModelManager"

local mMaleDefaultSuitId = 101;
local mFeMaleDefaultSuitId = 201;

function FashionModel:GetFashionPosition(id)
	-- body
	local config = mConfigSysfashion[id];
	if config then
		return config.position;
	end

	return -1;
end

function FashionModel:Convert(fashion_list)
	local fashions = nil;
	for i,v in ipairs(fashion_list) do
		local id = v.id;
		local fashion = FashionVO.LuaNew(id, mConfigSysfashion[id]);
		fashion:OnRecvData(v);
		if not fashions then
			fashions = {};
		end
		fashions[fashion.mPosition] = fashion;
	end
	return fashions;
end

function FashionModel:OnRecvFashions(pbFashionList,msgType)

	local fashion_list = pbFashionList.fashion_list;
	local fashionDataSource = self:GetFashionDataSource();
	local actFashionDataSource = self:GetActivedFashionDataSource();

	local equipedFashions = self:GetEquipedFashions();
	

	local currentEquiped = nil;

	for i,v in ipairs(fashion_list) do
		local id = v.id;
		local position = self:GetFashionPosition(id);
		local dataSource = fashionDataSource[position];
		local actDataSource = actFashionDataSource[position];
		local totalDataSource = fashionDataSource[0];

		if dataSource then
			local fashion = dataSource:GetValue(id);
			if fashion then
				fashion:OnRecvData(v);
				fashion:SetActive();

				if fashion.mEquiped then
					currentEquiped = equipedFashions[position];
					currentEquiped:SetEquiped(false);
					equipedFashions[position] = fashion;
				end

				dataSource:AddOrUpdate(id,fashion);
				totalDataSource:AddOrUpdate(id,fashion);
				actDataSource:AddOrUpdate(id,fashion);

				if msgType == 2 then
					self:Dispatch(mEventEnum.ON_UPDATE_FASHION_INFO,fashion);
				end
			end
		end
	end

	if currentEquiped then
		self:ClearTempEquipedFashions();
		self:Dispatch(mEventEnum.ON_UPDATE_EQUIPED_FASHIONS,equipedFashions);
	end
end

local mResult = {};
function FashionModel:OnRecvUpdateFashionResult(pbResult,updateType)
	mResult.result = pbResult.result;
	mResult.updateType = updateType;
	self:Dispatch(mEventEnum.ON_UPDATE_FASHION_RESULT,mResult);
end

function FashionModel:GetFashion(id)
	local fashionDataSource = self:GetFashionDataSource();
	local dataSource = fashionDataSource[0];
	return dataSource:GetValue(id);
end

function FashionModel:CheckInitSuitDataSource()
	if not self.mMaleSuitDataSource then
		self:InitSuitDataSource();
	end
end

function FashionModel:InitSuitDataSource()
	local suitDataSource = nil;
	local maleSuitDataSource = {};
	local femaleSuitDataSource = {};

	for k,v in pairs(mConfigSysfashion_suit) do
		suitDataSource = v.sex == 1 and maleSuitDataSource or femaleSuitDataSource;
		local suitType = v.type;
		local dataSource = suitDataSource[suitType];
		if not dataSource then
			dataSource = SortTable.LuaNew(nil,nil,true);
			suitDataSource[suitType] = dataSource;
		end
			
		local vo = FashionSuitVO.LuaNew(k,v);
		dataSource:AddOrUpdate(k,vo);
	end

	self.mMaleSuitDataSource = maleSuitDataSource;
	self.mFeMaleSuitDataSource = femaleSuitDataSource;
end

function FashionModel:CreateDefaultSuit(sex)
	local suit = sex == 1 and mConfigSysfashion_suit[mMaleDefaultSuitId] or mConfigSysfashion_suit[mFeMaleDefaultSuitId];
	local fashions = {};
	for i,v in ipairs(suit.components) do
		local fashion = FashionVO.LuaNew(v, mConfigSysfashion[v]);
		fashion:SetAsDefault();
		fashions[fashion.mPosition] = fashion;
	end
	return fashions;
end

function FashionModel:CheckInitDefaultSuit()
	if not self.mMaleDefaultSuit then
		self:InitDefaultSuit();
	end
end

function FashionModel:InitDefaultSuit()
	self.mMaleDefaultSuit = self:CreateDefaultSuit(1);
	self.mFeMaleDefaultSuit = self:CreateDefaultSuit(2);
end


local function SortFashion(a,b)
	if a.mActived then
		if b.mActived then
			return a.mId < b.mId;
		else
			return true;
		end
	else
		if b.mActived then
			return false;
		else
			return a.mId < b.mId;
		end
	end
end

function FashionModel:AddEmptyData(k,minCount,dataSource)
	local len = #dataSource.mSortTable;
	if len < minCount then
		local key = -k*1000;
		for i = len+1,minCount do
			dataSource:AddOrUpdate(key-i,{mId = key-i,mActived = false});
		end
	end
end

function FashionModel:GetActivedFashionDataSource()
	local sex = mGameModelManager.RoleModel.mPlayerBase.sex;
	return sex == 1 and self.mActivedMaleFashionDataSource or self.mActivedFeMaleFashionDataSource;
end

function FashionModel:CheckInitFashionDataSource()
	if not self.mMaleFashionDataSource then
		self:InitFashionDataSource();
	end
end

function FashionModel:InitFashionDataSource()

	local fashionDataSource = nil;
	local actFashionDataSource = nil;

	local maleFashionDataSource = {};
	local femaleFashionDataSource = {};
	local actMaleFashionDataSource = {};
	local actFemaleFashionDataSource = {};

	local totalDataSource = nil;

	local maleTotalDataSource = SortTable.LuaNew(SortFashion,"MaleTotalDataSource",true);
	local femaleTotalDataSource = SortTable.LuaNew(SortFashion,"FemaleTotalDataSource",true);

	maleFashionDataSource[0] = maleTotalDataSource;
	femaleFashionDataSource[0] = femaleTotalDataSource;

	for k,v in pairs(mConfigSysfashion) do
		local isMale = v.sex == 1;
		fashionDataSource = isMale and maleFashionDataSource or femaleFashionDataSource;
		actFashionDataSource = isMale and actMaleFashionDataSource or actFemaleFashionDataSource;
		totalDataSource = isMale and maleTotalDataSource or femaleTotalDataSource;

		local position = v.position;
		local dataSource = fashionDataSource[position];
		if not dataSource then
			dataSource = SortTable.LuaNew(SortFashion,"DataSource_"..position,true);
			fashionDataSource[position] = dataSource;
		end

		local actDataSource = actFashionDataSource[position];
		if not actDataSource then
			actDataSource = SortTable.LuaNew(SortFashion,"ActiveDataSource_"..position,true);
			actFashionDataSource[position] = actDataSource;
		end

		local vo = FashionVO.LuaNew(k,v);

		dataSource:AddOrUpdate(k,vo);
		actDataSource:AddOrUpdate(k,vo);
		totalDataSource:AddOrUpdate(k,vo);
	end

	for k,v in pairs(actMaleFashionDataSource) do
		self:AddEmptyData(k,24,v);
	end

	for k,v in pairs(actFemaleFashionDataSource) do
		self:AddEmptyData(k,24,v);
	end

	self.mMaleFashionDataSource = maleFashionDataSource;
	self.mFeMaleFashionDataSource = femaleFashionDataSource;
	self.mActivedMaleFashionDataSource = actMaleFashionDataSource;
	self.mActivedFeMaleFashionDataSource = actFemaleFashionDataSource;

end

function FashionModel:GetFashionDataSource()
	self:CheckInitFashionDataSource();
	local sex = mGameModelManager.RoleModel.mPlayerBase.sex;
	return sex == 1 and self.mMaleFashionDataSource or self.mFeMaleFashionDataSource;
end

function FashionModel:GetSuitDataSource()
	self:CheckInitSuitDataSource();
	local sex = mGameModelManager.RoleModel.mPlayerBase.sex;
	return sex == 1 and self.mMaleSuitDataSource or self.mFeMaleSuitDataSource;
end

function FashionModel:GetDefaultFashion(sex,position)

	self:CheckInitDefaultSuit();
	if not sex then
		sex = mGameModelManager.RoleModel.mPlayerBase.sex;
	end

	local suit = sex == 1 and self.mMaleDefaultSuit or self.mFeMaleDefaultSuit;
	local fashion = suit[position];

	return fashion;
end

function FashionModel:GetDefaultSuit()
	self:CheckInitDefaultSuit();
	return mGameModelManager.RoleModel.mPlayerBase.sex == 1 and self.mMaleDefaultSuit or self.mFeMaleDefaultSuit;
end

function FashionModel:GetEquipedFashions()
	local fashions = self.mEquipedFashions;
	if not fashions then
		fashions = self:CreateDefaultSuit(mGameModelManager.RoleModel.mPlayerBase.sex);
		self.mEquipedFashions = fashions;
	end
	return fashions;
end

function FashionModel:GetTempEquipedFashions()
	local fashions = self.mTempEquipedFashions;
	if not fashions then
		fashions = {};
		local equipedFashions = self:GetEquipedFashions();
		for k,v in pairs(equipedFashions) do
			fashions[k] = v;
		end
		self.mTempEquipedFashions = fashions;
	end
	return fashions;
end

function FashionModel:ClearTempEquipedFashions()
	self.mTempEquipedFashions = nil;
end

function FashionModel:GetTempEquipedFashion(position)
	local fashions = self:GetTempEquipedFashions();
	return fashions[position];
end

function FashionModel:SetTempFashion(fashion)
	local fashions = self:GetTempEquipedFashions();
	fashions[fashion.mPosition] = fashion;
end

return FashionModel;