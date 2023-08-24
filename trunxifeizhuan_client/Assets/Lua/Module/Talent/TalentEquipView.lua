local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local TalentItemEquipView = require "Module/Talent/TalentItemEquipView"
local TalentEquipView = mLuaClass("TalentEquipView",mBaseView);
local mSuper = nil;

function TalentEquipView:Init()
	local equip_list = {};
	local select_list = {};

	for i = 1, 6 do
		local path = string.format( 'talen_%d/talent', i);
		local path2 = string.format( 'talen_%d/select', i);
		equip_list[i] = TalentItemEquipView.LuaNew( self:Find( path ).gameObject , i);
		select_list[ i ] = self:Find( path2 ).gameObject;
	end
	self.mEquipItemList = equip_list;
	self.mSelectItemList = select_list;
end
 
function TalentEquipView:OnUpdateFollower(data)
	self.mData = data;
	self:UpdateEquipList( data.mTalentListToIndex);
	self:SetSelected( nil );
end

function TalentEquipView:UpdateEquipList( list )
	local equip_list = self.mEquipItemList;
	for k, v in pairs(equip_list) do
		local vo = list[k];
		if vo then
			v:ShowView( );
			v:ExternalUpdate( vo );
		else
			v:HideView( );
		end
	end
end

function TalentEquipView:OnWearEquip( data )
	self:OnUpdateTalent( data );
end

function TalentEquipView:OnUpdateTalent( data )
	local pos = data:GetPosition( );
	local view = self.mEquipItemList[ pos ];
	view:ShowView( );
	view:ExternalUpdate( data );
end

function TalentEquipView:OnRemoveEquip( pos )
	local view = self.mEquipItemList[ pos ];
	view:HideView( );
end

function TalentEquipView:OnSelectEquipItem( vo )
	if vo then
		self:SetSelected( vo:GetPosition() );
	end
end

function TalentEquipView:SetSelected(index)
	local last_select = self.mLastIndex;
	local select_list = self.mSelectItemList;
	if last_select then
		select_list[ last_select ]:SetActive( false );
	end
	if index then
		select_list[ index ]:SetActive( true );
	end
	self.mLastIndex = index;
end

function TalentEquipView:Dispose(  )
	self.mEquipItemList = nil;
	self.mSelectItemList = nil;
end

return TalentEquipView;