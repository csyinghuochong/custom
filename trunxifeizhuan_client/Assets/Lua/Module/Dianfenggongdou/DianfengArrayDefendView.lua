local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mLanguageUtil = require "Utils/LanguageUtil"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local DianfengArrayBattleView = require "Module/Dianfenggongdou/DianfengArrayBattleView"
local DianfengArrayDefendView = mLuaClass("DianfengArrayDefendView", DianfengArrayBattleView);
local mTable = require 'table'

function DianfengArrayDefendView:InitViewParam()
	return {
		["viewPath"] = "ui/dianfenggongdou/",
		["viewName"] = "dianfeng_array_defend_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
		["cost"] = {"energy"},
	};
end

function DianfengArrayDefendView:InitEnemyItemList( )
	
end

function DianfengArrayDefendView:InitSubComponent(  )
	self:FindAndAddClickListener('button_challenge', function() self:OnClickSaveTeam() end,'ty_0205');
end
 
function DianfengArrayDefendView:OnClickSaveTeam()
	local pbDefensePos = self:GetDefensePos();
	if mTable.getn(pbDefensePos.partner_pos_list) == 0 then
		mCommonTipsView.Show( mLanguageUtil.dianfeng_defend_team_tip );
		return;
	end
	local callBack = self.mData.mCallBack;
	if callBack ~= nil then
		callBack(pbDefensePos);
	end
	self:OnClickHideView();
end

function DianfengArrayDefendView:GetDefensePos( )
	local selfHeros = self.mData.mSelfHeros;
	local pbDefensePos = {};
	local parterList = {};
	for index, hero in pairs(selfHeros) do
		if hero:IsFollower() then
			local pbPartnerPosList = {}
			pbPartnerPosList.partner_id = tonumber(hero.mUID);
			pbPartnerPosList.pos = hero.mPos;
			pbPartnerPosList.team = hero.mWave;

			mTable.insert(parterList, pbPartnerPosList);
		end
	end
	pbDefensePos.partner_pos_list = parterList;
	return pbDefensePos;
end

function DianfengArrayDefendView:ShowBaseInfo( data )
	--self.mTextTitle.text = data.mLevelName;	
end

function DianfengArrayDefendView:ShowEnemyTeam( enemyHeros )

end

return DianfengArrayDefendView;