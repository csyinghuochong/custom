local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mEventEnum = require "Enum/EventEnum"
local mLanguageUtil = require "Utils/LanguageUtil"
local mEventDispatcher = require "Events/EventDispatcher"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mPlayerPrefs = UnityEngine.PlayerPrefs;
local RoleModel = mLuaClass("RoleModel",mBaseModel);

function RoleModel:OnLuaNew()
	 self.mTypeEnum = {mEnumCostStrength = 1, mEnumCostEnergy = 2,mEnumCostMansion = 12, mEnumCostBoom = 14 };
end

function RoleModel:UpdatePlayerBase(playerBase)
	 self.mPlayerBase = playerBase;
end

--1体力2精力3银两4钻石5官职6阅历7等级8经验9竞技币10时装币11贡献值12府邸币13美人令14繁荣度
function RoleModel:OnPlayerChangeInfo(pbPlayerChange)
	local playBase = self.mPlayerBase;
	local changeType = pbPlayerChange.type;
	local value = pbPlayerChange.value;
	
    if changeType == 1 then
      playBase.sp = value;
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_STRENGTH, value);
    elseif changeType == 2 then
      playBase.energy = value;
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_ENERGY, value);
    elseif changeType == 3 then
      local text = value - playBase.coin > 0 and "+"..value - playBase.coin or value - playBase.coin;
      --mCommonTipsView.Show(mLanguageUtil.silver..text);
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_COIN, value);
      playBase.coin = value;
    elseif changeType == 4 then
      local text = value - playBase.gold > 0 and "+"..value - playBase.gold or value - playBase.gold;
      --mCommonTipsView.Show(mLanguageUtil.gold..text);
      playBase.gold = value;
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_GOLD, value);
    elseif changeType == 5 then
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_OFFICE, value);
      playBase.position = value;
    elseif changeType == 6 then
      playBase.experience = value;
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_YUELI, value);
    elseif changeType == 7 then
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_LEVEL, value);
      playBase.level = value;
    elseif changeType == 8 then
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_EXP, value);
      playBase.exp = value;
    elseif changeType == 9 then
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_ARENA_COIN, value);
      playBase.arena_coin = value;
    elseif changeType == 10 then
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_DRESS_COIN, value);
      playBase.dress_coin = value;
    elseif changeType == 11 then
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_DEVOTE_COIN, value);
      playBase.devote_coin = value;
    elseif changeType == 12 then
      playBase.house_coin = value;
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_HOUSE_COIN, value);
    elseif changeType == 13 then
      mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_WISDOM_COIN, value);
      playBase.wisdom_coin = value;
    elseif changeType == 14 then
       mEventDispatcher:Dispatch(mEventEnum.ON_PLAYER_UPDATE_BOOM_COIN, value);
      playBase.boom = value;
	end
end

function RoleModel:GetOffice(  )
    return self.mPlayerBase.position;
end

function RoleModel:GetPlayerID(  )
    return self.mPlayerBase.player_id
end

function RoleModel:GetYueLi( )
    return self.mPlayerBase.experience;
end

return RoleModel;