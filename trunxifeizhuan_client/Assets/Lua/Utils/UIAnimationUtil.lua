local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local UIAnimationUtil = mLuaClass("UIAnimationUtil",mBaseLua);
local mUpdateManager = require "Manager/UpdateManager"
local mVector3 = Vector3;
local mDGTween = DG.Tweening.ShortcutExtensions;
local mEase = DG.Tweening.Ease;
local mGameLuaInterface = GameLuaInterface;

function UIAnimationUtil:OnLuaNew()
	self.mAnimationStartScale = 0.9;
	self.mAnimationEndScale = 1.05;
end

function UIAnimationUtil:PlayOpenAnimation(transform,callBack)
	self.mTransform = transform;
	self.mCallBack = callBack;

	transform.localScale = mVector3.one * self.mAnimationStartScale;

	local tween = mDGTween.DOScale(transform,mVector3.one * self.mAnimationEndScale,0.18);
	mGameLuaInterface.SetEase(tween,mEase.OutCirc);
	mGameLuaInterface.OnComplete(tween,function()
		local tween2 = mDGTween.DOScale(transform,mVector3.one,0.08);
		mGameLuaInterface.SetEase(tween2,mEase.InCirc);
		mGameLuaInterface.OnComplete(tween2,function()
			self.mCallBack();
		end)
	end)
end

local instance = UIAnimationUtil.LuaNew();
return instance;