local mLuaClass = require "Core/LuaClass"
local mEventEnum = require "Enum/EventEnum"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBattleArrayView = require "Module/BattleArray/BattleArrayView"
local mBattleArrayViewVO = require "Module/BattleArray/BattleArrayViewVO"
local mBattleActorItemView = require "Module/BattleArray/BattleActorItemView"
local DianfengArrayBattleView = mLuaClass("DianfengArrayBattleView", mBattleArrayView);
local mTable = require 'table'
local mString = require 'string'
local mVector3 = Vector3;
local mPairs = pairs;
local mSuper;

function DianfengArrayBattleView:InitViewParam()
	return {
		["viewPath"] = "ui/dianfenggongdou/",
		["viewName"] = "dianfeng_array_battle_view",
		["ParentLayer"] = mMainLayer1,
		["viewBgEnum"] = mViewBgEnum.gray,
		["cost"] = {"energy"},
	};
end

function DianfengArrayBattleView:InitSubComponent(  )
	self.mImageCost2 = self:FindComponent('button_challenge/Image_ss', 'Image');
	self.mTextCost = self:FindComponent('button_challenge/Text_cost', 'Text');
	self:FindAndAddClickListener('button_challenge', function() self:CheckBattleArray() end,'ty_0205');
end

local mTeamPerNumber = {1, 4, 4};
function DianfengArrayBattleView:GetValidWaveAndPos( selfHeros )
	local waveNumber = { {}, { }, {} };
	for k, v in mPairs(mTeamPerNumber) do
		for i = 1, v do
			waveNumber[ k ][ i ] = 0;
		end
	end

	for k, v in mPairs( selfHeros ) do
		local wave = v.mWave;
		local pos = v.mPos;
		waveNumber[ wave ][ pos ] = 1;
	end

	for team, v in mPairs( waveNumber ) do
		for pos,  value in mPairs( v ) do
			if value == 0 then
				return team, pos;
			end
		end 
	end 
end

function DianfengArrayBattleView:InsertArrayFollower(  selfHeros, followerVO )
	local team, pos = self:GetValidWaveAndPos( selfHeros );
	followerVO.mWave = team;
	followerVO.mPos  = pos;
	mTable.insert(selfHeros, followerVO);
end

function DianfengArrayBattleView:ShowBaseInfo( data )
	self.mTextCost.text = data.mCostStrength;
	local last_number, icon =  self:GetLastResource(data);
	self.mGameObjectUtil:SetImageSprite(self.mImageCost2, icon);
end

function DianfengArrayBattleView:GetTeamPosByIndex( index )
	local totalNumber = 0;
	local team, pos;
	for k, v in mPairs(mTeamPerNumber) do
		if index <= totalNumber + v then
			team = k;
			pos = totalNumber + v - index;
			break;
		end
		totalNumber = totalNumber + v;
	end

	if team == nil then
		print('无效的位置索引__'..index);
	end
	return team, pos;
end

function DianfengArrayBattleView:GetTeamIndexByPos( team, pos )
	local index = 0;
	for k, v in mPairs( mTeamPerNumber ) do
		if k < team then
			index = index + v;
		else
			index = index + pos;
			break;
		end
	end
	return index;
end

function DianfengArrayBattleView:ShowSelfTeam( selfHeros )
	local selfArray = self.mSelfArray;
	for i = 1, self.mTeamMaxNumber do
		selfArray[ i ]:SetData( nil );
	end

	for k, v in mPairs ( selfHeros ) do
		local wave = v.mWave;
		local pos = v.mPos;
		local index = self:GetTeamIndexByPos( wave, pos );
		selfArray[ index ]:SetData( v );
	end
end

function DianfengArrayBattleView:ShowEnemyTeam( enemyHeros )
	local enemyArray = self.mEnemyArray;
	for i = 1, self.mTeamMaxNumber do
		enemyArray[ i ]:HideView(  );
	end

	for k, v in mPairs ( enemyHeros ) do
		local wave = v.mWave;
		local pos = v.mPos;
		local index = self:GetTeamIndexByPos( wave, pos );
		enemyArray[ index ]:ShowView( );
		enemyArray[ index ]:SetData( v );
	end
end

return DianfengArrayBattleView;