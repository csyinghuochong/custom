local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mGlobalUtil = require "Utils/GlobalUtil"
local mRobotBaseVO = require "Module/Follower/RobotBaseVO"
local mConfigSysrobot = require "ConfigFiles/ConfigSysrobot"
local ArenaController = require "Module/Arena/ArenaController"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local ArenaRankItemVO = require "Module/Arena/Rank/ArenaRankItemVO"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local ArenaPlayerItem = mLuaClass("ArenaPlayerItem",mBaseView);
local mLanguageUtil = require "Utils/LanguageUtil"
local mTip = mLanguageUtil.arena_no_rank;
local mColor = Color;
local mSuper = nil;

function ArenaPlayerItem:OnLuaNew(go, index)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);
end

function ArenaPlayerItem:Init()
	self.mModelParent = self:Find('model');
	self.mImageBeat = self:Find('Image_15').gameObject;
	self.mTextLv = self:FindComponent( 'Text_2', 'Text' );
	self.mTextRank = self:FindComponent( 'Text_4', 'Text' );
	self.mTextName = self:FindComponent('Text_name', 'Text');
	self.mTextScore = self:FindComponent('Text_score', 'Text');
	self.mTextDivision = self:FindComponent( 'Text_6', 'Text' );

	self.mModelShowView = ModelRenderTexture.LuaNew(self:Find('model'));

	local clickChallenge = function (  )
		self:OnClickChallenge();
	end

	self:FindAndAddClickListener('Button_Challenge', clickChallenge);
end

function ArenaPlayerItem:InitRobotVo( vo )
	local player_id = tonumber(vo.player_id);
	if ArenaRankItemVO:IsRobotPlayer(player_id)  then
		local robot = mConfigSysrobot[player_id];
		vo.sex = mRobotBaseVO:GetRobotSex(player_id);
		vo.lv = mRobotBaseVO:GetRobotLevel(player_id);
		vo.name = robot.name;
	end
end
      
--小于1000000 机器人
function ArenaPlayerItem:OnUpdateUI( vo )
	if vo ~= nil then
		self:InitRobotVo( vo );

		self.mTextLv.text = vo.lv;
		self.mTextName.text = vo.name;
		self.mTextScore.text = vo.score;
		self.mTextRank.text = vo.rank ~= 0 and vo.rank or mTip;
		self.mTextDivision.text = ArenaRankItemVO:GetDivisionVoByScore( vo.score ).name;
		self.mImageBeat:SetActive(vo.defeated == 1);
		self:CreateModel(vo);
	end
	self.mData = vo;
end

function ArenaPlayerItem:OnClickChallenge(  )
	local data = self.mData;
	if data == nil then
		return;
	end
	if data.defeated == 0 then
		ArenaController:SendPrepareArenaBattle(self.mData.player_id);
	else
		mCommonTipsView.Show(mTip);
	end
end

local mPropertyName = "_Color";
function ArenaPlayerItem:CreateModel( vo )
	local sex = vo.sex;
	local color = vo.defeated == 0 and mColor.white or mColor.gray;

	local modelView = self.mModelShowView;
	modelView:OnUpdateLead( sex );
	modelView:SetColor(color); 
end

function ArenaPlayerItem:OnViewShow( vo  )
	self.mModelShowView:ShowView( );
	if vo then
		self:OnUpdateUI( vo );
	end
end

function ArenaPlayerItem:OnViewHide(  )
	self.mModelShowView:HideView( );
end

function ArenaPlayerItem:Dispose(  )
	self.mModelShowView:Dispose( );
end

return ArenaPlayerItem;