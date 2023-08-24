local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonTabView = require "Module/CommonUI/TabView/CommonTabView"
local mFollowerController = require "Module/Follower/FollowerController"
local CommonSkillItemView = require "Module/Follower/FollowerSkillItemView"
local mCommonTabBaseView = require "Module/CommonUI/TabView/CommonTabBaseView"
local LeadSkillHuangqinView = mLuaClass("LeadSkillHuangqinView", mCommonTabBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mString = string;
local mSuper = nil;

function LeadSkillHuangqinView:OnLuaNew( index, parent, view )	
	self.mGoParent = parent;
	self.mViewParent = view;

	mSuper = self:GetSuper(mCommonTabBaseView.LuaClassName);
    mSuper.OnLuaNew(self);
end

function LeadSkillHuangqinView:InitViewParam()
	return {
		["viewPath"] = "ui/lead/",
		["viewName"] = "lead_skill_huangqin_view",
	};
end

function LeadSkillHuangqinView:Init()
	self:SetParent(self.mGoParent);

	self.mClickSkillItemBack = function( vo )
		self:OnClickSkillItem(vo);
	end

	self.mClickChangeSkillBack = function(index)
		self:OnClickChangeSkill(index);
	end

	local mEventEnum = self.mEventEnum;
	self:RegisterEventListener(mEventEnum.ON_LEAD_SKILL_UP, function(vo)
		self:PlaySoundName("ty_0207");
		self:OnLeadSkillUp(vo);
	end, true);

	self.mTabView = self:GetTabViewParams( );
	self.mSkillView = self:GetSkillItemList( );
end

function LeadSkillHuangqinView:GetSkillBranch(  )
	return 4;
end

function LeadSkillHuangqinView:OnUpdateUI(data)
	self.mData = data;
	self:UpdateSkillView( data );
end

function LeadSkillHuangqinView:OnLeadSkillUp( data )
	self:OnUpdateUI( data.lead_vo );
	self:ShowUpEffect( data.skill_vo );
end

function LeadSkillHuangqinView:ShowUpEffect( skill_vo )
	local skill_info = skill_vo.mSkillInfo;
	local position = skill_info.position;
	local index = skill_info.index;
	local item = self.mSkillView[position][index];
	if item then
		local effect = self.mViewParent:GetUpEffect( );
		mGameObjectUtil:SetParent(effect, item.mTransform);
		local effect_go = effect.gameObject;
		effect_go:SetActive( false );
		effect_go:SetActive( true );
	end
end

function LeadSkillHuangqinView:GetTabViewParams(  )
	local number = self:GetSkillBranch();

	local view_vo_list = {};
	for i = 1, number do
		local view_vo = {}
		view_vo.luaClass = "Core/BaseView";        
		view_vo.childPath = mString.format('view%d', i);  
		view_vo_list[i] = view_vo;
	end

	local tab_view_go = self:Find(mString.format('tabView'));
	return mCommonTabView.LuaNew(tab_view_go, view_vo_list, self.mClickChangeSkillBack);
end

function LeadSkillHuangqinView:GetSkillItemList(  )
	local skill_item_list = {};
	for i = 1, 4 do
		local skill_list = {};
		for k = 1, 4 do
			local path = mString.format('skill%d_%d', i, k);
			local transform = self:Find(path);
			if transform ~= nil then
				skill_list[k] = CommonSkillItemView.LuaNew(transform.gameObject, self.mClickSkillItemBack);
			end
		end
		skill_item_list[i] = skill_list;
	end
	return skill_item_list;
end

function LeadSkillHuangqinView:UpdateSkillView(data)
	local power = data:GetPowerID();

	local skillView = self.mSkillView;
	local skill_line = data:GetSkillLineByPower(power);
	local skill_to_index = data:GetSkillListByPower(power);
	for k, v in pairs(skill_to_index) do
		local skill_info = v.mSkillInfo;
		local position = skill_info.position;
		local index = skill_info.index;
		skillView[position][index]:ExternalUpdate(v);
	end

	self.mTabView:OnClickToggleButton(skill_line, false);
end

function LeadSkillHuangqinView:OnClickSkillItem( vo )
	mUIManager:HandleUI(mViewEnum.LeadSkillActiveView, 1, { vo, 2 } );
end

function LeadSkillHuangqinView:OnClickChangeSkill(index)
	mFollowerController:SendLeadSkillChange(self.mViewParent.mPowerID, index);
end

function LeadSkillHuangqinView:Dispose( )
	for k, v in pairs ( self.mSkillView ) do
		for key, value in pairs( v ) do
			value:CloseView( );
		end
	end	
	self.mSkillView = nil;
end

return LeadSkillHuangqinView;