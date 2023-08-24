local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameLuaInterface = GameLuaInterface;
local mDoFileUtil = require "Utils/DoFileUtil";
local ObjectPool = require "Common/ObjectPool"
local GameTimer = require "Core/Timer/GameTimer"

---这个类仅供调试用
local function DebugTipsCallback()
	return mDoFileUtil:DoFile(mViewEnum.DebugTipsView).LuaNew();
end

local DebugTipsViewPool = ObjectPool.LuaNew(DebugTipsCallback,nil,nil);

local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local DebugTipsView = mLuaClass("DebugTipsView", mCommonTipsView);
local mBeginPosition = Vector3.New(0,-100,0);
local mSize = Vector2.New(1000,400);

function DebugTipsView:Init()
	local tips = self:Find("tips");
    tips.sizeDelta = mSize;
    self.mTipsText = tips:GetComponent('Text');
end

function DebugTipsView:OnViewShow(logicParams)
    self.mTipsText.text = logicParams;
    local transform = self.mTransform;
    transform.localPosition = mBeginPosition;
    mGameLuaInterface.DOLocalMoveY(transform, 300, 5, function() self:OnFade() end);
end

function DebugTipsView:OnFade()
	self:HideView()
	DebugTipsViewPool:Put(self);
end

local mTips = "";
local mShowingTip = nil;

local function ShowTip()
	local obj = DebugTipsViewPool:Get();
	obj:ShowView(mTips);
	mTips = "";
	mShowingTip = nil;
end 

function DebugTipsView.ShowAffectResult(msg)
	mTips = mTips..msg
	if not mShowingTip then
		GameTimer.SetTimeout(1,ShowTip);
		mShowingTip = true;
	end
end

return DebugTipsView;