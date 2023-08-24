local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mBaseView = require "Core/BaseView"
local mUIManager = require "Manager/UIManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mConfigSysnpc = require "ConfigFiles/ConfigSysnpc";
local mAlertView = require "Module/CommonUI/AlertBaseView"
local mPromoteController = require "Module/Promote/PromoteController"
local PromoteEvaluateItem = require "Module/Promote/PromoteEvaluateItem"
local PromoteEvaluateView = mLuaClass("PromoteEvaluateView",mBaseView);
local GameObject = UnityEngine.GameObject;

function PromoteEvaluateView:InitViewParam()
	return {
		["viewPath"] = "ui/promote/",
		["viewName"] = "promote_evaluate_view",
	};
end

function PromoteEvaluateView:Init()
	self:InitNPC();
	self:AddListener();
end

function PromoteEvaluateView:InitNPC(  )
	local npcList = {};
	local npcNode = self:Find('group');
	local npcItem = self:Find('group/npc').gameObject;

	for i = 201, 206 do
		local go = GameObject.Instantiate(npcItem);
		mGameObjectUtil:SetParent(go.transform, npcNode);
		npcList[i] = PromoteEvaluateItem.LuaNew(i, mConfigSysnpc[i], go);
	end
	self.mNpcItemList = npcList;
end

function PromoteEvaluateView:AddListener(  )
	self:SetParent(self.mGoParent);
	self.mButtonGiveUp = self:Find('button/1').gameObject;
	self.mButtonPromote = self:Find('button/2').gameObject;
	
	self:AddBtnClickListener(self.mButtonGiveUp, function() self:OnClickGiveUp() end);
	self:AddBtnClickListener(self.mButtonPromote,function() self:OnClickPromote() end);

	self.mSendGiveUp = function (  )
		mPromoteController:SendGiveUpExam( );
	end
end

function PromoteEvaluateView:OnViewShow( vo )
	self.mData = vo;
	self:OnRecvNpcResult( vo );

	local npcList = self.mNpcItemList;
	for k, v in pairs(npcList) do
		v:ShowView();
	end
end

function PromoteEvaluateView:OnViewHide( )
	self:ResetNpcResult( );
	local npcList = self.mNpcItemList;
	for k, v in pairs(npcList) do
		v:HideView();
	end
end

function PromoteEvaluateView:Dispose(  )
	local npcList = self.mNpcItemList;
	for k, v in pairs(npcList) do
		v:CloseView();
	end
	self.mNpcItemList = nil;
end

function PromoteEvaluateView:CheckIsAllOppose(vo)
	local results = vo.npc_result;
	for k, v in ipairs(results) do
		if v.result == 1 then
			return false;
		end
	end
	return true;
end

function PromoteEvaluateView:CheckIsAllAgree( vo )
	local results = vo.npc_result;
	for k, v in ipairs(results) do
		if v.result == 0 then
			return false;
		end
	end
	return true;
end

function PromoteEvaluateView:OnRecvNpcResult( vo )
	self:UpdateNpcState( vo );
	self:UpdateButtonPos(  vo );
end

function PromoteEvaluateView:UpdateNpcState( vo )
	local results = vo.npc_result;
	local npcList = self.mNpcItemList;
	local allOppose = self:CheckIsAllOppose(vo);
	for k, v in ipairs(results) do
		local npcItem = npcList[v.id];
		if npcItem then
			npcItem:UpdateState(v.result, allOppose);
		else
			print( 'PromoteEvaluateView:UpdateNpcState---'..v.id )
		end
	end
end

function PromoteEvaluateView:UpdateButtonPos( vo )
	local allAgree = self:CheckIsAllAgree( vo );
	local btnGiveUp = self.mButtonGiveUp;
	local btnPromote = self.mButtonPromote;
	btnGiveUp:SetActive ( not allAgree );
	btnPromote:SetActive( allAgree );
end

function PromoteEvaluateView:ResetNpcResult(  )
	local npcList = self.mNpcItemList;
	for k, v in pairs(npcList) do
		v:ResetState();
	end

	self.mButtonGiveUp:SetActive(false);
	self.mButtonPromote:SetActive(false);
end

function PromoteEvaluateView:OnRecvGiveUpExam( )
	self:ResetNpcResult();
end

function PromoteEvaluateView:OnRecvRolePromote( )
	self:ResetNpcResult();
end

local mLanguageUtil = require "Utils/LanguageUtil"
local mTip = mLanguageUtil.promote_stop_exam;
function PromoteEvaluateView:OnClickGiveUp( )
	if self:CheckIsAllOppose( self.mData ) then
		self.mSendGiveUp( );
	else
		mAlertView.Show({title=nil, desc1=mTip, btnName= nil,CallBack = self.mSendGiveUp});
	end
end

function PromoteEvaluateView:OnClickPromote( )
	mPromoteController:SendRolePromote();
end

return PromoteEvaluateView;