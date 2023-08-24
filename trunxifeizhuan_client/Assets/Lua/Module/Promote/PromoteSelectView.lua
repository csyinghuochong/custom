local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mConfigSysnpc = require "ConfigFiles/ConfigSysnpc";
local mGameModelManager = require "Manager/GameModelManager"
local mPromoteNPCItem = require "Module/Promote/PromoteNPCItem"
local mConfigSyspromote = require "ConfigFiles/ConfigSyspromote";
local mPromoteController = require "Module/Promote/PromoteController"
local mConfigSysmanualConst = require "ConfigFiles/ConfigSysmanualConst";
local PromoteTopButtonView = require "Module/Promote/PromoteTopButtonView"
local PromoteSelectView = mLuaClass("PromoteSelectView",mBaseView);
local GameObject = UnityEngine.GameObject;

function PromoteSelectView:InitViewParam()
	return {
		["viewPath"] = "ui/promote/",
		["viewName"] = "promote_select_view",
	};
end

function PromoteSelectView:Init()
	self:InitNPC();
	self:AddListener();
end

function PromoteSelectView:InitNPC(  )
	local npcList = {};
	local callBack = function (  )
		self:OnClickExamBtn();
	end
	local mNpcIds = self:InitNPCIds( );
	for k, v in pairs ( mNpcIds ) do
		local go = self:Find( 'npc'..k ).gameObject;
		npcList[v] = mPromoteNPCItem.LuaNew(go, mConfigSysnpc[v], callBack );
	end
	self.mNpcItemList = npcList;
end

function PromoteSelectView:InitNPCIds(  )
	local ids = { };
	for k, v in pairs ( mConfigSyspromote ) do
		local have = false;
		local examiner_id = v.examiner_id;

		for key, value in pairs( ids ) do
			if value == examiner_id then
				have = true;
				break;
			end
		end
		if not have and examiner_id ~= 0 then
			table.insert( ids, examiner_id )
		end
	end
	return ids;
end

function PromoteSelectView:AddListener(  )
	self:SetParent(self.mGoParent);
end

function PromoteSelectView:OnViewShow()
	self:UpdateJoinBtn();
	local npcList = self.mNpcItemList;
	for k, v in pairs(npcList) do
		v:ShowView();
	end
end

function PromoteSelectView:OnViewHide( )
	local npcList = self.mNpcItemList;
	for k, v in pairs(npcList) do
		v:HideView();
	end
end

function PromoteSelectView:Dispose(  )
	local npcList = self.mNpcItemList;
	for k, v in pairs(npcList) do
		v:CloseView();
	end
end

function PromoteSelectView:GetRoleOffice( )
	return mGameModelManager.RoleModel:GetOffice();
end

function PromoteSelectView:GetExamState( )
	local pbSignInfo = mGameModelManager.PromoteModel.mPbSignInfo;
	return pbSignInfo == nil and 0 or pbSignInfo.status;
end

--当前考官id
function PromoteSelectView:GetExaminerId(  )
	local sysPromote = mConfigSyspromote[self:GetRoleOffice()];
	return sysPromote.examiner_id;
end

--0未报考，1已报考, 2评分完
function PromoteSelectView:UpdateJoinBtn(  )
	local examState = self:GetExamState();
	local examinerId = self:GetExaminerId();
	if ( examState == 0 or examState == 1 ) and  examinerId ~= 0 then
		self:ShowExamButton( examinerId );
	end
end

function PromoteSelectView:ShowExamButton( npc_id )
	for k, v in pairs ( self.mNpcItemList ) do
		v:ShowExamButton( k == npc_id );
	end
end

function PromoteSelectView:OnClickExamBtn(  )
	local office = self:GetRoleOffice( );
	local examState = self:GetExamState();

	if examState == 0 then
		if office < 6 then
			mUIManager:HandleUI(mViewEnum.PromoteJoinView, 1);
		else
			mUIManager:HandleUI(mViewEnum.DianfenggongdouChallengeView, 1);
		end
	elseif examState == 1 then
		mUIManager:HandleUI(mViewEnum.PromoteExamView,1, mGameModelManager.PromoteModel:GetCurrentExamVO());
	end
end

return PromoteSelectView;