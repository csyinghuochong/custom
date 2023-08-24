local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mBaseView = require "Core/BaseView"
local mUIManager = require "Manager/UIManager"
local mGameModelManager = require "Manager/GameModelManager"
local mDGTween = DG.Tweening.ShortcutExtensions;
local mGameLuaInterface = GameLuaInterface;
local MainCostView = mLuaClass("MainCostView",mBaseView);
local mVetor3 = Vector3;

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgWan = mLanguageUtil.wan;
local mLgYi = mLanguageUtil.yi;

--                 元宝   金币，     体力，   精力，     阅历，       竞技币，      通宝，       时装币，    贡献值         美人令
local costType = {"gold","silver","strength","energy","experience","arena_coin","mansion_cion","dress_coin","devote_coin","wisdom_coin"};

function MainCostView:InitViewParam()
	return {
		["viewPath"] = "ui/main_interface/",
		["viewName"] = "main_cost_view",
	};
end
function MainCostView:Init()
	local costView = {};

	for i,v in ipairs(costType) do
		costView[v] = self:Find(v);
		self:FindAndAddClickListener(v.."/Button",function()self:OnClickAdd();end)
	end
	self.costView = costView;

	self.mTextCoin = self:FindComponent('silver/Text_count', 'Text');
	self.mTextGold = self:FindComponent('gold/Text_count', 'Text');
	self.mTextSp = self:FindComponent('strength/Text_count', 'Text');
	self.mTextEnergy = self:FindComponent('energy/Text_count', 'Text');
	self.mTextYueLi = self:FindComponent('experience/Text_count', 'Text');
	self.mTextArena = self:FindComponent('arena_coin/Text_count', 'Text');
	self.mTextMansion = self:FindComponent('mansion_cion/Text_count', 'Text');
	self.mTextDressCoin = self:FindComponent('dress_coin/Text_count', 'Text');
	self.mTextDevoteCoin = self:FindComponent('devote_coin/Text_count', 'Text');
	self.mTextWisdomCoin = self:FindComponent('wisdom_coin/Text_count', 'Text');

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_STRENGTH, function(value) self:UpdateSp(value,true); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_ENERGY,function(value) self:UpdateEnergy(value,true); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_COIN,function(value) self:UpdateCoin(value,true); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_GOLD,function(value) self:UpdateGold(value,true); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_YUELI,function(value) self:UpdateYueLi(value,true); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_ARENA_COIN,function(value) self:UpdateArena(value,true); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_HOUSE_COIN,function(value) self:UpdateMansion(value,true); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_DRESS_COIN,function(value) self:UpdateDressCoin(value,true); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_DEVOTE_COIN,function(value) self:UpdateDevoteCoin(value,true); end,true);
	self:RegisterEventListener(mEventEnum.ON_PLAYER_UPDATE_WISDOM_COIN,function(value) self:UpdateWisdomCoin(value,true); end,true);

	self:OnInit();
end

function MainCostView:OnInit()
	
end

function MainCostView:OnClickAdd()
	mUIManager:HandleUIWithParent(self.mCostViewParentLayer,mViewEnum.StoreView,1);
end

function MainCostView:PlayEffect(transform)
	local duration = 0.2;
	local scale = 2;
	mGameLuaInterface.DOScale(transform,mVetor3.New(scale,scale),duration, function()
		mDGTween.DOScale(transform,mVetor3.one,duration);
	end);
end

function MainCostView:UpdateCoin(coin,showEffect)
	self.mTextCoin.text = self:GetNumString(coin);

	if showEffect then
		self:PlayEffect(self.mTextCoin.transform)
	end
end

function MainCostView:UpdateGold(gold,showEffect)
	self.mTextGold.text = self:GetNumString(gold);

	if showEffect then
		self:PlayEffect(self.mTextGold.transform)
	end
end

function MainCostView:UpdateYueLi( value )
	self.mTextYueLi.text = self:GetNumString(value);
end

function MainCostView:GetNumString(Num)
	if Num >= 1000000000 then
		local num1,num2 = math.modf(Num/100000000);
		return num1..mLgYi;
	elseif Num >= 100000 then
		local num1,num2 = math.modf(Num/10000);
		return num1..mLgWan;
	else
		return tostring(Num);
	end
end

function MainCostView:UpdateSp(sp,showEffect)
	self.mTextSp.text = sp.."/100";

	if showEffect then
		self:PlayEffect(self.mTextSp.transform)
	end
end

function MainCostView:UpdateEnergy(energy,showEffect)
	self.mTextEnergy.text = energy.."/10";

	if showEffect then
		self:PlayEffect(self.mTextEnergy.transform)
	end
end

function MainCostView:UpdateArena(arena,showEffect)
	self.mTextArena.text = arena;

	if showEffect then
		self:PlayEffect(self.mTextArena.transform)
	end
end

function MainCostView:UpdateMansion(mansion, showEffect)
	self.mTextMansion.text = mansion;

	if showEffect then
		self:PlayEffect(self.mTextMansion.transform)
	end
end

function MainCostView:UpdateDressCoin(mansion, showEffect)
	self.mTextDressCoin.text = mansion;

	if showEffect then
		self:PlayEffect(self.mTextDressCoin.transform)
	end
end

function MainCostView:UpdateDevoteCoin(mansion, showEffect)
	self.mTextDevoteCoin.text = mansion;

	if showEffect then
		self:PlayEffect(self.mTextDevoteCoin.transform)
	end
end

function MainCostView:UpdateWisdomCoin(mansion, showEffect)
	self.mTextWisdomCoin.text = mansion;

	if showEffect then
		self:PlayEffect(self.mTextWisdomCoin.transform)
	end
end

function MainCostView:OnViewShow(logicParams)
	local roleBase = mGameModelManager.RoleModel.mPlayerBase;
	self:UpdateCoin(roleBase.coin);
	self:UpdateGold(roleBase.gold);
	self:UpdateSp(roleBase.sp);
	self:UpdateEnergy(roleBase.energy);
	self:UpdateYueLi(roleBase.experience);
	self:UpdateArena(roleBase.arena_coin);
	self:UpdateMansion(roleBase.house_coin);
	self:UpdateDressCoin(roleBase.dress_coin);
	self:UpdateDevoteCoin(roleBase.devote_coin);
	self:UpdateWisdomCoin(roleBase.wisdom_coin);

	self:SetParent(logicParams.costViewParent);
	self.mCostViewParentLayer = logicParams.costViewParentLayer;
	self.mCostViewWindow = logicParams.costViewWindow;

	local costParams = self.mCacheCostParams or logicParams.cost;
	self:HandleCostParams(costParams);
end

function MainCostView:HandleCostParams(costParams)
	if costParams == nil then
		return;
	end

	local costView = self.costView;
	if costView == nil then
		self.mCacheCostParams = costParams;
		return;
	end

	for k,v in pairs(costView) do
		v.gameObject:SetActive(false);
	end

	for i,v in ipairs(costParams) do
		local view = costView[v];
		view.gameObject:SetActive(true);
		view:SetSiblingIndex(i - 1);
	end

	self:SetPosition(costParams);
end

function MainCostView:SetPosition(costParams)
	local pos = self.mTransform.localPosition;
	pos.x = costParams.x or 150;
	pos.y = costParams.y or 288;
	self.mTransform.localPosition = pos;
end

function MainCostView:CheckDisposeCostUI(window)
	--print("---------------CheckDisposeCostUI:",self.LuaClassName,self.mCostViewWindow.LuaClassName,window.LuaClassName,debug.traceback());
	if self.mIsDestory == false and self.mCostViewWindow == window then
		self:CloseView();
	end
end

function MainCostView:Dispose()
	self.costView = nil;
end

return MainCostView;
