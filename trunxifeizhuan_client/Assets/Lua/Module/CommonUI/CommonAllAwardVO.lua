local mLuaClass = require "Core/LuaClass"
local BaseLua = require "Core/BaseLua"
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local mTalentItemVO = require "Module/Talent/TalentItemVO"
local CommonAllAwardVO = mLuaClass("CommonAllAwardVO",BaseLua);

function CommonAllAwardVO:OnLuaNew(id,num,isTalent,talent,isGet)
	self.mID = id;
	if isTalent then
		self.mGoodsData = mTalentItemVO.LuaNew(talent,nil);
	else
		self.mGoodsData = mCommonGoodsVO.LuaNew(id,num,nil,true);
	end
	self.mIsTalent = isTalent;
    self.mIsGet = isGet;
    self.mSortIndex = isTalent and 1 or 2;
end

return CommonAllAwardVO;
