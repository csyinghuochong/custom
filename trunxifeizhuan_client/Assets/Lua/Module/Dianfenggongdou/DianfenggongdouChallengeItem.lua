local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mLeadBaseVO = require "Module/Lead/LeadBaseVO"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local DianfenggongdouController = require "Module/Dianfenggongdou/DianfenggongdouController"
local DianfenggongdouChallengeItem = mLuaClass("DianfenggongdouChallengeItem",mBaseView);
local mColor = Color;

function DianfenggongdouChallengeItem:Init()
	self.mTextlevel = self:FindComponent('Text_2', 'Text');
	self.mTextRank = self:FindComponent('Text_4', 'Text');
	self.mTextOffice = self:FindComponent('Text_6', 'Text');
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mTextScore = self:FindComponent('Text_score', 'Text');
	self.mDefeatObj = self:Find( 'Image_15' ).gameObject;

	local clickChallenge = function (  )
		self:OnClickChallenge();
	end
	self:FindAndAddClickListener('Button_Challenge', clickChallenge);

	self.mRoleMode = ModelRenderTexture.LuaNew( self:Find('model') );
end

function DianfenggongdouChallengeItem:OnUpdateUI( vo )
	self.mData = vo;
	self.mTextlevel.text = vo.lv;
	self.mTextRank.text = vo.rank;
	self.mTextName.text = vo.name;
	self.mTextScore.text = vo.score;
	self.mTextOffice.text = mLeadBaseVO:GetOfficeName( vo.position, vo.sex);
	local color = vo.defeated == 0 and mColor.white or mColor.gray;
	self.mRoleMode:OnUpdateLead(  vo.sex  );
	self.mRoleMode:SetColor( color); 
	self.mDefeatObj:SetActive( vo.defeated == 1);
end

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgTip = mLanguageUtil.promote_arena_cannot_challenge
function DianfenggongdouChallengeItem:OnClickChallenge(  )
	local data = self.mData;
	if data.defeated == 0 then
		DianfenggongdouController:SendPrepareArenaBattle(self.mData.player_id);
	else
		mCommonTipsView.Show(mLgTip);
	end
end

function DianfenggongdouChallengeItem:OnViewShow( data )
	self.mRoleMode:ShowView( );
	if data then
		self:OnUpdateUI( data );
	end
end

function DianfenggongdouChallengeItem:OnViewHide(  )
	self.mRoleMode:HideView( );
end

function DianfenggongdouChallengeItem:Dispose(  )
	self.mRoleMode:Dispose( );
end

return DianfenggongdouChallengeItem;