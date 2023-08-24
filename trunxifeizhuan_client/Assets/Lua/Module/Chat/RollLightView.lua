local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mSortTable = require "Common/SortTable"
local mTable = table
local mVector2 = Vector2
local mGameLuaInterface = GameLuaInterface;
local mEase = DG.Tweening.Ease;
local mDGTween = DG.Tweening.ShortcutExtensions;
local mGameModelManager = require "Manager/GameModelManager"
local RollLightView = mLuaClass("RollLightView", mBaseWindow);

function RollLightView.Show(data)
	mUIManager:HandleUI(mViewEnum.RollLightView, 1, data);
end

function RollLightView:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "rolllight_view",
		["ParentLayer"] = mCommonChatLayer1,
	};
end

function RollLightView:Sort(a,b)
	return a.create_time < b.create_time;
end

function RollLightView:Init()
	self.mText = self:FindComponent('TextTrans/faceText','GameEmojiText');
	self.mTrans = self:FindComponent('TextTrans/faceText','RectTransform');
	self.mIsPlaying = false;
end

function RollLightView:OnViewShow(data)
	self:RollText();
end

function RollLightView:RollText()
	local model = mGameModelManager.ChatModel;
	local data_soure = model.mRollDataSoure;
	local sortTable = data_soure.mSortTable;
	if not self.mIsPlaying and mTable.getn(sortTable) > 0 then
		local chat = sortTable[1];
		self.mText:SetEmojiText(chat.msg);
		local textWidth = self.mText.preferredWidth + 20;
		local transform = self.mTrans;
		transform.sizeDelta = mVector2(textWidth,30);
		transform.anchoredPosition = mVector2(240,-1.3);
		self.mIsPlaying = true;
		local tween = mDGTween.DOLocalMoveX(transform, -textWidth - 240, textWidth/50);
		mGameLuaInterface.SetEase(tween,mEase.Flash);
		mGameLuaInterface.OnComplete(tween,function() self:FinishAnimate(chat) end);
	end
end

function RollLightView:FinishAnimate(chat)
	local model = mGameModelManager.ChatModel;
	local data_soure = model.mRollDataSoure;
	data_soure:RemoveKey(chat.id);
	self.mIsPlaying = false;
	local isEmpty = mTable.getn(data_soure.mSortTable) == 0;
	if isEmpty then
		self:HideView();
	else
		self:RollText();
	end
end

function RollLightView:Dispose()
end

return RollLightView;