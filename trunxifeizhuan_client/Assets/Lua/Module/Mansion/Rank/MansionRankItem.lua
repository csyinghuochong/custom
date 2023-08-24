local mLuaClass = require "Core/LuaClass"
local RankItem = require "Module/Rank/RankItem"
local mGameModelManager = require "Manager/GameModelManager"
local mMansionRankInfo = require "Module/Mansion/Rank/MansionRankInfo"
local MansionRankItem = mLuaClass("MansionRankItem", RankItem);
local mSuper = nil;

function MansionRankItem:InitViewParam()
   return {
     ["viewPath"] = "ui/mansion/",
     ["viewName"] = "mansion_rank_item_view",
   };
end

function MansionRankItem:Init( )
	self.mTextValue2 = self:FindComponent("Value2","Text");
	self.mTextValue3 = self:FindComponent("Value3","Text");
	self.mRankType = mGameModelManager.RankModel.mTypeEnum.MANSION;

    mSuper = self:GetSuper(RankItem.LuaClassName);
	mSuper.Init(self);
end

function MansionRankItem:OnUpdateData(  )
	mSuper.OnUpdateData(self);
	local data = self.mData;

	self.mTextValue2.text = mMansionRankInfo:GetLevelByBoom(data.value);
	self.mTextValue3.text = mMansionRankInfo:GetAwardByRank(self.mRankType, data.rank);
	
end

return MansionRankItem;