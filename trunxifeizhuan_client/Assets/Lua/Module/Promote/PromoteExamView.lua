local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameTimer = require "Core/Timer/GameTimer"
local mAlertView = require "Module/CommonUI/AlertView"
local mGameModelManager = require "Manager/GameModelManager"
local mPromoteController = require "Module/Promote/PromoteController"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local PromoteExamView = mLuaClass("PromoteExamView",mBaseWindow);
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgStopExam = mLanguageUtil.promote_stop_exam;

function PromoteExamView:InitViewParam()
	return {
		["viewPath"] = "ui/promote/",
		["viewName"] = "promote_exam_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function PromoteExamView:Init()
	self:InitSubView( );
	self:AddListeners( );
end

function PromoteExamView:InitSubView(  )
	self.mSubViewList = {};
	self.mView1 = self:Find('promote_begin_view').gameObject;
	self.mView2 = self:Find('promote_answer_view').gameObject;
	self.mView3 = self:Find('promote_score_view').gameObject;

	self.mPromoteExamNpcView = ModelRenderTexture.LuaNew(self:Find('model'));
	self.mPromoteExamNpcView:OnUpdateUI('r_200111' );

	self.mClickStopExam = function (  )
		mPromoteController:SendStopExam();
	end

	self.mButtonClose = self:Find("Button_close").gameObject;
	self:AddBtnClickListener(self.mButtonClose,function()
		self:HideView();
		mUIManager:HandleUI(mViewEnum.PromoteEntryView,1);
	end);
end

function PromoteExamView:AddListeners(  )
	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_BEGIN_NEXT_EXAM, function(vo)
		self:OnUpdateView(vo);
	end, true);
	self:RegisterEventListener(mEventEnum.ON_UPDATE_EXAM_VIEW, function(vo)
		self:OnUpdateVO(vo);
	end, true);

	self:RegisterEventListener(mEventEnum.ON_RECV_NPC_RESULT, function(vo)
		self:HideView();
		mUIManager:HandleUI(mViewEnum.PromoteEntryView,1);
	end, true);
end

function PromoteExamView:OnViewShow( logicParams )
	if logicParams == nil then
		logicParams = mGameModelManager.PromoteModel:GetCurrentExamVO();
	end

	self:OnUpdateView(logicParams);
	self.mPromoteExamNpcView:ShowView();
end

function PromoteExamView:OnViewHide(  )
	self.mPromoteExamNpcView:HideView();
end

function PromoteExamView:HideSubView( )
	self.mView1:SetActive(false);
	self.mView2:SetActive(false);
	self.mView3:SetActive(false);
end

function PromoteExamView:OnClickStopExam()
	mAlertView.Show({title=nil, desc1=nil, desc2=mLgStopExam, btnName= nil,CallBack = self.mClickStopExam});
end

--更换界面
function PromoteExamView:OnUpdateView( vo )
	local view = self.mCurrentExamView;
	if view ~= nil then
		view:HideView();
	end
	
	local viewList = self.mSubViewList;
	local go_path, view_name = vo:GetCurrentView();
	if view_name == nil then
		return;
	end
	
	local view = viewList[view_name];
	if view == nil then
		local go = self:Find(go_path).gameObject;
		view = require('Module/Promote/'..view_name).LuaNew(go);
		viewList[view_name] = view;
	end
	view:ShowView( vo );
	self.mCurrentExamView = view;
	self.mButtonClose:SetActive(vo.mPhaseStatus ~= 1);
end

--刷新当前界面， 目前只有答题
function PromoteExamView:OnUpdateVO( vo )
	self.mCurrentExamView:OnUpdateUI( vo );
end

function PromoteExamView:Dispose(  )
	 self.mCurrentExamView = nil;
	 self.mPromoteExamNpcView:Dispose(  );
end

return PromoteExamView;