local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local PromoteTopButtonView = require "Module/Promote/PromoteTopButtonView";
local mDianfenggongdouController = require "Module/Dianfenggongdou/DianfenggongdouController"
local mDianfenggongdouChallengeItem = require "Module/Dianfenggongdou/DianfenggongdouChallengeItem"
local DianfenggongdouChallengeView = mLuaClass("DianfenggongdouChallengeView",mQueueWindow);
local GameObject = UnityEngine.GameObject;

function DianfenggongdouChallengeView:InitViewParam()
	return {
		["viewPath"] = "ui/dianfenggongdou/",
		["viewName"] = "dianfenggongdou_challenge_view",
		["ParentLayer"] = mMainLayer,
	};
end

function DianfenggongdouChallengeView:Init()
	local playerList = {};
	for i = 1, 5 do
		playerList[i] = mDianfenggongdouChallengeItem.LuaNew(self:Find('group/player'..i).gameObject);
	end
	self.mPlayerItemList = playerList;

	self.mTextMyScore = self:FindComponent('Top/Text_score', 'Text');
	self.mTextMyRank = self:FindComponent('Top/Text_rank', 'Text');
	self.mTextNextOffice = self:FindComponent('Top/Text_office', 'Text');
	self.mTextCost = self:FindComponent('Top/Text_energy', 'Text');

	self.mButtonView = PromoteTopButtonView.LuaNew( self:Find( 'TopLeft' ).gameObject , 2 );
	self:FindAndAddClickListener("Button_close",function() self:ReturnPrevQueueWindow() end);
	
	self:FindAndAddClickListener("Top/button_add",function() self:OnClickAddButton() end);
	self:FindAndAddClickListener("button_fresh",function() self:OnClickRefresh() end, nil, 0.5);

	local fresh_cost = self:FindComponent('Text_cost', 'Text');
	fresh_cost.text = mConfigSysglobal_value[mConfigGlobalConst.PROMOTE_ARENA_REFRESH_COST];
	self.mCostNumber = mConfigSysglobal_value[mConfigGlobalConst.PROMOTE_ARENA_COST_ENERGY];

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_RECV_PROMOTE_ARENA, function(data)
		self:OnRecvArenaData( data );
	end, true);
end

function DianfenggongdouChallengeView:OnViewShow(  )
	mDianfenggongdouController:SendReqOpenArena();
	self:UpdateEnergy();
end

function DianfenggongdouChallengeView:UpdateEnergy( )
	self.mTextCost.text = string.format('%d/%d', self.mCostNumber, mGameModelManager.RoleModel.mPlayerBase.energy);
end

function DianfenggongdouChallengeView:OnClickRefresh(  )
	mDianfenggongdouController:SendArenaRefresh();
end

function DianfenggongdouChallengeView:OnClickAddButton(  )
	mUIManager:HandleUI( mViewEnum.StoreView,1);
end

local mLanguage = require "Utils/LanguageUtil"
local mTip = mLanguage.arena_no_rank;
function DianfenggongdouChallengeView:OnRecvArenaData(  data )
	local voList = data.vs_list;

	for k, v in pairs(self.mPlayerItemList) do
		local vo = voList[k];
		if vo ~= nil then
			v:ForceShowView(vo);
		else
			v:HideView();
		end
	end

	self.mTextMyScore.text = data.score;
	self.mTextMyRank.text = data.rank ~= 0 and data.rank or mTip;
	self.mTextNextOffice.text = mGameModelManager.FollowerModel:GetOfficeName( );
end

function DianfenggongdouChallengeView:OnViewHide(  )
	for k, v in pairs(self.mPlayerItemList) do
		v:HideView();
	end
end

function DianfenggongdouChallengeView:Dispose(  )
	for k, v in pairs(self.mPlayerItemList) do
		v:CloseView();
	end
	self.mPlayerItemList = nil;
end

return DianfenggongdouChallengeView;