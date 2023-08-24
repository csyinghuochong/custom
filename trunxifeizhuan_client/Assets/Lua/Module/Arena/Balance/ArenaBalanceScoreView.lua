local mLuaClass = require "Core/LuaClass"
local BaseView = require "Core/BaseView"
local mUpdateManager = require "Manager/UpdateManager"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mGameModelManager = require "Manager/GameModelManager"
local mArenaRankItemVO = require "Module/Arena/Rank/ArenaRankItemVO"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local mCommonPlayerHeadView = require "Module/CommonUI/CommonPlayerHeadView"
local ArenaBalanceScoreView = mLuaClass("ArenaBalanceScoreView", BaseView);
local mColor = Color;
local mGoodsIconPath = mResourceUrl.goods_icon;

function ArenaBalanceScoreView:Init(  )
	self.mSlider = self:FindComponent('score/Slider', 'Slider');
	self.mTextName = self:FindComponent( 'Name', 'Text' );
	self.mTextScoreAdd = self:FindComponent( 'score/add', 'Text' );
	self.mTextMoneyOld = self:FindComponent( 'money/number', 'Text' );
	self.mTextMoneyAdd = self:FindComponent( 'money/add', 'Text' );
	self.mUpLevel = self:Find( 'score/Image_1' ).gameObject;
	self.mPlayerItem = mCommonPlayerHeadView.LuaNew(self:Find('head').gameObject);

	self.mImageDivision = self:FindComponent('score/icon', 'RawImage');
	self.mImageDivision.color = mColor.clear;
	self.mLoadedDivisionIcon = function (icon)
		self:OnLoadedDivisionIcon(icon);
	end
end

function ArenaBalanceScoreView:OnViewShow( data )

end

function ArenaBalanceScoreView:ShowPlayerHead( data )
	self.mTextName.text = data:GetName( );
	self.mPlayerItem:SetInfo( data:GetPlayerItemVO() );
end

function ArenaBalanceScoreView:ShowPlayerScore( old, add )
	self.mScoreOld = old;
	self.mScoreAdd = add;
	self.mTextScoreAdd.text = string.format( '%s%d', add > 0 and '+' or "", add )
	local newScore = old + add;
	local oldVo = mArenaRankItemVO:GetDivisionVoByScore( old );
	local newVo = mArenaRankItemVO:GetDivisionVoByScore( newScore );
	self.mSlider.value =  ( newScore -  newVo.score[ 1 ] ) / ( newVo.score[ 2 ] - newVo.score[ 1 ] );
	self.mUpLevel:SetActive( oldVo ~= newVo );
	mUITextureManager.LoadTexture(mGoodsIconPath, 'icon_001600',self.mLoadedDivisionIcon);
end

function ArenaBalanceScoreView:OnLoadedDivisionIcon(icon)
	self.mImageDivision.texture = icon;
	self.mImageDivision.color = mColor.white;
end

function ArenaBalanceScoreView:ShowPlayerMoney( old, add )
	self.mTextMoneyOld.text = old;
	self.mTextMoneyAdd.text = add;
end

function ArenaBalanceScoreView:OnUpdate()

end

function ArenaBalanceScoreView:OnViewHide(  )
	
end

function ArenaBalanceScoreView:Dispose( )
	self.mPlayerItem:CloseView( );
end

return ArenaBalanceScoreView;