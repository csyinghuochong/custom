local mLuaClass = require "Core/LuaClass"
local TalentItemEquipView = require "Module/Talent/TalentItemEquipView"
local TalentItemBaseView = mLuaClass("TalentItemBaseView", TalentItemEquipView);

local mSuper=nil;

function TalentItemBaseView:OnLuaNew(go,bg,kuang)
	self.mGoodsBgIcon = bg;
	self.mGoodsKuang = kuang;

	mSuper = self:GetSuper(TalentItemEquipView.LuaClassName);
	mSuper.OnLuaNew(self, go);
end

function TalentItemBaseView:Init( )
   	self.mTransformColor = self:Find( 'color' );
	mSuper.Init(self);
end

function TalentItemBaseView:InitGameImage( )
 	self.mGoodsColor = self:FindComponent("color", 'Image');
 	if self.mGoodsBgIcon == nil then
		self.mGoodsBgIcon = self:FindComponent("bg", 'Image');
	end

	if self.mGoodsKuang == nil then
    	self.mGoodsKuang = self:FindComponent("kuang", 'Image');
    end
end

function TalentItemBaseView:UpdateGameImage( data )
	self.mGameObjectUtil:SetImageSprite(self.mGoodsKuang,data:GetKuangIcon( ));
    self.mGameObjectUtil:SetImageSprite(self.mGoodsBgIcon,data:GetBgIcon( ));
    self.mGameObjectUtil:SetImageSprite(self.mGoodsColor,data:GetColorIcon( ));
end

--外部调用
function TalentItemBaseView:ExternalUpdate(data)
	if data == nil then
		return;
	end
	
	mSuper.ExternalUpdate( self, data );
   
    local t_color = self.mGoodsColor.transform;
    t_color.localScale = data:GetColorScale( );
    self.mTransformColor.localRotation = Quaternion.Euler(0, 0, data:GetRotationZ() );
end

function TalentItemBaseView:OnClickIcon()
	-- do nothing
end

return TalentItemBaseView;