local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mPromoteController = require "Module/Promote/PromoteController"
local PromoteSelectView = require "Module/Promote/PromoteSelectView"
local PromoteEvaluateView = require "Module/Promote/PromoteEvaluateView"
local PromoteTopButtonView = require "Module/Promote/PromoteTopButtonView";
local PromoteEntryView = mLuaClass("PromoteEntryView",mQueueWindow);

function PromoteEntryView:InitViewParam()
	return {
		["viewPath"] = "ui/promote/",
		["viewName"] = "promote_entry_view",
		["ParentLayer"] = mMainLayer,
	};
end

function PromoteEntryView:Init()
	self:InitSubView();
	self:AddListener();
end

function PromoteEntryView:InitSubView( )
	self.mSelectView = PromoteSelectView.LuaNew( );
	self.mEvaluateView = PromoteEvaluateView.LuaNew( );
	self.mSelectView.mGoParent = self.mTransform;
	self.mEvaluateView.mGoParent = self.mTransform;
	self.mButtonView = PromoteTopButtonView.LuaNew( self:Find( 'TopLeft' ).gameObject , 1 );
	self:FindAndAddClickListener("Button_close",function() self:ReturnPrevQueueWindow() end);
end

function PromoteEntryView:AddListener(  )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_INFO_FIRST, function()
		self:OnRecvInfoFirst();
	end, true);
	self:RegisterEventListener(mEventEnum.ON_RECV_NPC_RESULT, function(vo)
		self:OnRecvNpcResult(vo);
	end, true);
	self:RegisterEventListener(mEventEnum.ON_GIVE_UP_EXAM, function()
		self:OnRecvGiveUpExam();
	end, true);
	self:RegisterEventListener(mEventEnum.ON_ROLE_PROMOTE, function()
		self:OnRecvRolePromote();
	end, true);
end

function PromoteEntryView:OnViewShow()
	self:CheckExamState();
end

function PromoteEntryView:OnViewHide( )
	self.mSelectView:HideView( );
	self.mEvaluateView:HideView( );
end

function PromoteEntryView:Dispose(  )
	self.mSelectView:CloseView( );
	self.mEvaluateView:CloseView( );
end

function PromoteEntryView:OnRecvInfoFirst(  )
	self:UpdateSubView(  );
	if self:GetExamState() == 1 then
		mUIManager:HandleUI(mViewEnum.PromoteExamView,1);
	end
end

function PromoteEntryView:UpdateSubView(  )
	local state = self:GetExamState();
	local result = mGameModelManager.PromoteModel.mPbNpcResultList;
	if state == 2 and result then
		self:OnRecvNpcResult(result);
	else
		self.mSelectView:ShowView( );
	end
end

function PromoteEntryView:CheckExamState( )
	local examinerId = self:GetExaminerId();
	local pbSignInfo = mGameModelManager.PromoteModel.mPbSignInfo;
	if pbSignInfo == nil then
		mPromoteController:SendReqSignInfo( examinerId );
	else
		self:UpdateSubView(  );
	end
end

function PromoteEntryView:GetRoleOffice( )
	return mGameModelManager.RoleModel:GetOffice();
end

function PromoteEntryView:GetExamState( )
	local pbSignInfo = mGameModelManager.PromoteModel.mPbSignInfo;
	return pbSignInfo == nil and 0 or pbSignInfo.status;
end

--当前考官id
function PromoteEntryView:GetExaminerId(  )
	local sysPromote = mGameModelManager.PromoteModel:GetCurPromoteVO();
	return sysPromote.examiner_id;
end

function PromoteEntryView:OnRecvNpcResult( vo )
	self.mSelectView:HideView( );
	self.mEvaluateView:ForceShowView( vo );
end

function PromoteEntryView:OnRecvGiveUpExam( )
	self.mSelectView:ShowView( );
	self.mEvaluateView:HideView( );
end

function PromoteEntryView:OnRecvRolePromote( )
	self.mSelectView:ShowView( );
	self.mEvaluateView:HideView( );
end

return PromoteEntryView;