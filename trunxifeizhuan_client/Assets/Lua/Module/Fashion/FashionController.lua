local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mBaseController = require "Core/BaseController"
local FashionController = mLuaClass("FashionController",mBaseController);
local mGameModelManager = require "Manager/GameModelManager"
local mTest = true;

function FashionController:AddNetListeners()
	local s2c = self.mS2C;

	--时装列表
    s2c:PLAYER_FASHION_LIST(function(pbFashionList)
		mGameModelManager.FashionModel:OnRecvFashions(pbFashionList,1);
	end);
	--更新时装
    s2c:PLAYER_FASHION_REFRESH(function(pbFashionList)
		mGameModelManager.FashionModel:OnRecvFashions(pbFashionList,2);
	end);

	--保存
	s2c:PLAYER_FASHION_SAVE(function(pbResult)
		mGameModelManager.FashionModel:OnRecvUpdateFashionResult(pbResult);
	end);
    
    s2c:PLAYER_FASHION_COMBINE(function(pbResult)
		mGameModelManager.FashionModel:OnRecvUpdateFashionResult(pbResult,0);
	end);
	--强化
    s2c:PLAYER_FASHION_STRENGTH(function(pbResult)
		mGameModelManager.FashionModel:OnRecvUpdateFashionResult(pbResult,1);
	end);
	--进阶
	s2c:PLAYER_FASHION_PROMOTE(function(pbResult)
		mGameModelManager.FashionModel:OnRecvUpdateFashionResult(pbResult,2);
	end);
	--升星
    s2c:PLAYER_FASHION_UPRGADE_STAR(function(pbResult)
		mGameModelManager.FashionModel:OnRecvUpdateFashionResult(pbResult,3);
	end);
	--渲光
    s2c:PLAYER_FASHION_UPGRADE_COLOR(function(pbResult)
		mGameModelManager.FashionModel:OnRecvUpdateFashionResult(pbResult,4);
	end);
	--洗练
    s2c:PLAYER_FASHION_WASH(function(pbResult)
		mGameModelManager.FashionModel:OnRecvUpdateFashionResult(pbResult,5);
	end);

	--洗练保存
    s2c:PLAYER_FASHION_WASH_SAVE(function(pbResult)
		mGameModelManager.FashionModel:OnRecvUpdateFashionResult(pbResult,6);
	end);

	mTest = DebugHelper.sTestFashion;
end

--测试
function FashionController:GetFashionInfo(data)
	local fashion = {};
	fashion.id = data.mId;
	fashion.score = data.mScore;
	fashion.level = data.mLevel;
	fashion.quality = data.mQuality;
	fashion.star = data.mStar;
	fashion.color = data.mXuanguang;
	fashion.wear = 0;

	local add_attribute = {};
	local temp_attribute = {};

	for k,v in pairs(data.mAdditionalAttributes) do
		add_attribute[k] = {key = v.type,value = v.value};
	end

	for k,v in pairs(data.mTempAdditionalAttributes) do
		temp_attribute[k] = {key = v.type,value = v.value};
	end

	fashion.add_attribute = add_attribute;
	fashion.temp_attribute = temp_attribute;

	if data.mEquiped then
		fashion.wear = 1;
	end

	return fashion;
end

function FashionController:TestEquipFashions(data)
	local fashions = {};
	local fashion_list = {};
	fashions.fashion_list = fashion_list;
	for k,v in pairs(equipFashions) do
		local fashion = self:GetFashionInfo(v);
		fashion.wear = 1;
		fashion_list[k] = fashion;
	end

	mGameModelManager.FashionModel:OnRecvFashions(fashions,2);
end

function FashionController:TestGetFashion(data)
	local fashions = {};
	local fashion = self:GetFashionInfo(data);
	fashions.fashion_list = {fashion};
	mGameModelManager.FashionModel:OnRecvFashions(fashions,2);
end

function FashionController:TestLevelUp(data)
	local fashions = {};
	local fashion = self:GetFashionInfo(data);
	fashion.level = fashion.level + 1;
	fashions.fashion_list = {fashion};
	mGameModelManager.FashionModel:OnRecvFashions(fashions,2);
end

function FashionController:TestQualityUp(data)
	local fashions = {};
	local fashion = self:GetFashionInfo(data);
	fashion.quality = fashion.quality + 1;
	fashion.add_attribute[fashion.quality] = {key = 1,value = 100};
	fashions.fashion_list = {fashion};
	mGameModelManager.FashionModel:OnRecvFashions(fashions,2);
end

function FashionController:TestStarUp(data)
	local fashions = {};
	local fashion = self:GetFashionInfo(data);
	fashion.star = fashion.star + 1;
	fashions.fashion_list = {fashion};
	mGameModelManager.FashionModel:OnRecvFashions(fashions,2);
end

function FashionController:TestXuanguang(data)
	local fashions = {};
	local fashion = self:GetFashionInfo(data);
	fashion.color = fashion.color + 1;
	fashions.fashion_list = {fashion};
	mGameModelManager.FashionModel:OnRecvFashions(fashions,2);
end

function FashionController:TestWash(data)
	local fashions = {};
	local fashion = self:GetFashionInfo(data);
	local temp_attribute = fashion.temp_attribute;
	for i = 1,5 do
		temp_attribute[i] = {key = 1,value = 100};
	end
	fashions.fashion_list = {fashion};
	mGameModelManager.FashionModel:OnRecvFashions(fashions,2);
end

function FashionController:TestSaveWash(data)
	local fashions = {};
	local fashion = self:GetFashionInfo(data);
	fashions.fashion_list = {fashion};
	mGameModelManager.FashionModel:OnRecvFashions(fashions,2);
end

function FashionController:RequestFashionList()
	if mTest then
		return;
	end
	self.mC2S:PLAYER_FASHION_LIST();
end

function FashionController:SendEquipFashions(equipFashions)
	if mTest then
		self:TestEquipFashions(equipFashions);
		return;
	end
	local id_list = {};
	for k,v in pairs(equipFashions) do
		table.insert(id_list,v.mId);
	end

	self.mC2S:PLAYER_FASHION_SAVE(id_list);
end

function FashionController:SendGetFashion(data)
	if mTest then
		self:TestGetFashion(data);
		return;
	end
	self.mC2S:PLAYER_FASHION_COMBINE(data.mId);
end

function FashionController:SendLevelUp(data,use_goods)
	if mTest then
		self:TestLevelUp(data);
		return;
	end
	self.mC2S:PLAYER_FASHION_STRENGTH(data.mId,use_goods);
end

function FashionController:SendQualityUp(data)
	if mTest then
		self:TestQualityUp(data);
		return;
	end
	self.mC2S:PLAYER_FASHION_PROMOTE(data.mId);
end

function FashionController:SendStarUp(data)
	if mTest then
		self:TestStarUp(data);
		return;
	end
	self.mC2S:PLAYER_FASHION_UPRGADE_STAR(data.mId);
end

function FashionController:SendXuanguang(data)
	if mTest then
		self:TestXuanguang(data);
		return;
	end
	self.mC2S:PLAYER_FASHION_UPGRADE_COLOR(data.mId);
end

function FashionController:SendWash(data)
	if mTest then
		self:TestWash(data);
		return;
	end
	self.mC2S:PLAYER_FASHION_WASH(data.mId);
end

function FashionController:SendSaveWash(data,flag)
	if mTest then
		self:TestSaveWash(data);
		return;
	end
	self.mC2S:PLAYER_FASHION_WASH_SAVE(data.mId,flag);
end


return FashionController.LuaNew();