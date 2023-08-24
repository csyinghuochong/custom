local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local PromoteEvaluateItem = mLuaClass("PromoteEvaluateItem", mBaseView);
local mVector3 = Vector3;

function PromoteEvaluateItem:OnLuaNew( npc_id, npc_vo, go )
	self.mNpcId = npc_id;
	self.mNpcVO = npc_vo;

	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self,go);
end

function PromoteEvaluateItem:Init()
	self.mImageAgress = self:Find('Image_agree').gameObject;
	self.mButtonOppose = self:Find('Button_oppose').gameObject;
	self:AddBtnClickListener(self.mButtonOppose, function() self:OnClickFriendly() end);
	
	local npcVO = self.mNpcVO;
	local modelView = ModelRenderTexture.LuaNew(self:Find('model'));
	modelView:OnUpdateUI( npcVO.model );
	self.mModelShowView = modelView;

	self:UpdatePosition();
end

function PromoteEvaluateItem:UpdatePosition(  )
	local npcVO = self.mNpcVO;
	local pos = npcVO.position;
	local scale = npcVO.scale ~= 0 and npcVO.scale or 1;
	local m_transform = self.mTransform;
	m_transform.localPosition = mVector3.New(pos[1], pos[2], pos[3]);
	m_transform.localScale = Vector3.one * scale ;
end

function PromoteEvaluateItem:OnViewShow( )
	self.mModelShowView:ShowView( );
end

function PromoteEvaluateItem:OnViewHide( )
	self.mModelShowView:HideView( );
end

function PromoteEvaluateItem:Dispose(  )
	self.mModelShowView:Dispose( );
end

function PromoteEvaluateItem:OnClickFriendly( )
	if self.mAllOppose ~= true then
		mUIManager:HandleUI(mViewEnum.PromoteFriendlyView,  1, self.mNpcId);
	end
end

function PromoteEvaluateItem:SetData()
	
end

--1同意  2反对
function PromoteEvaluateItem:UpdateState( state , all_oppose)
	self.mAllOppose = all_oppose;
	self.mImageAgress:SetActive( state == 1 );
	self.mButtonOppose:SetActive( state == 0 );
end

function PromoteEvaluateItem:ResetState(  )
	self.mImageAgress:SetActive( false );
	self.mButtonOppose:SetActive( false );
end

return PromoteEvaluateItem;