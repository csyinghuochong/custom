local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local ChildMainView = mLuaClass("ChildMainView",mQueueWindow);
local mDGTween = DG.Tweening.ShortcutExtensions;
local mVector3 = Vector3

function ChildMainView:InitViewParam()
	return {
		["viewPath"] = "ui/child/",
		["viewName"] = "child_main_view",
		["ParentLayer"] = mMainLayer,
		["ForbitSound"] = true,
	};
end

function ChildMainView:Init()
	-- self.mTweener = nil;
	-- self.mExpandButton = true;
	-- self.mIsAnimator = false;
	-- self.mBRTransform = self:Find("Panel/BottomRight/Function_open");
	-- self.mArrowTransform = self:Find("Panel/BottomRight/Button_arrow");

	self:FindAndAddClickListener('Panel/BottomRight/Function_open/Button_task',function() self:OnClickTask() end);
	self:FindAndAddClickListener('Panel/BottomRight/Function_open/Button_check',function() self:OnClickCheck() end);
	self:FindAndAddClickListener('Panel/BottomRight/Function_open/Button_event',function() self:OnClickEvent() end);
	self:FindAndAddClickListener('Panel/BottomRight/Function_open/Button_pos',function() self:OnClickPos() end);
	self:FindAndAddClickListener('Panel/BottomRight/Function_open/Button_train',function() self:OnClickTrain() end);
	-- self:FindAndAddClickListener('Panel/BottomRight/Button_arrow',function() self:OnClickArrow() end);
	self:FindAndAddClickListener('Panel/TopRight/Button_return',function() self:HideView() end);
end

function ChildMainView:OnClickTask()
	mUIManager:HandleUI(mViewEnum.ChildTaskView,1);
end

function ChildMainView:OnClickCheck()
	mUIManager:HandleUI(mViewEnum.ChildCheckView,1);
end

function ChildMainView:OnClickEvent()
	print("OnClickEvent");
end

function ChildMainView:OnClickPos()
	print("OnClickPos");
end

function ChildMainView:OnClickTrain()
	mUIManager:HandleUI(mViewEnum.ChildTrainView,1);
end

-- function ChildMainView:OnClickArrow()
-- 	is_animator = self.mIsAnimator;
-- 	if(is_animator) then return end

-- 	self.mIsAnimator = true;
-- 	local expand = self.mExpandButton;
-- 	local arrow_transform = self.mArrowTransform;
-- 	local transform = self.mBRTransform;
	
-- 	if expand then
-- 		expand = false;
-- 		mDGTween.DOScale(transform, mVector3.New(0, 0, 0), 0.3).onComplete = function() self:ShowButtonAnimator(false) end;
-- 		arrow_transform.localEulerAngles = mVector3.New(0, 0, 45);
-- 	else
-- 		expand = true;
-- 		mDGTween.DOScale(transform, mVector3.New(1, 1, 1), 0.3).onComplete = function() self:ShowButtonAnimator(true) end;
-- 		arrow_transform.localEulerAngles = mVector3.New(0, 0, 0);
-- 	end

-- 	self.mExpandButton = expand;
-- end

-- function ChildMainView:ShowButtonAnimator(show_animator)
-- 	self.mIsAnimator = false;
-- end

function ChildMainView:OnViewShow()
	
end

function ChildMainView:OnViewHide(removeQueueWindow)
	
end

function ChildMainView:Dispose()
end

return ChildMainView;
