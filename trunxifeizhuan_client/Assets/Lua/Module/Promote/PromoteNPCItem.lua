local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local PromoteNPCItem = mLuaClass("PromoteNPCItem", mBaseView);
local mVector3 = Vector3;

function PromoteNPCItem:OnLuaNew( go, npc_vo, callBack )
	self.mNpcVO = npc_vo;
	self.mCallBack = callBack;

	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self,go);
end

function PromoteNPCItem:Init()
	self.mButtonTip = self:Find( 'tanhao' ).gameObject;
	self:FindAndAddClickListener("button_1",function() self:OnClickExam() end);

	local npcVO = self.mNpcVO;
	local textName = self:FindComponent( 'Text_1' , 'Text' );
	local modelView = ModelRenderTexture.LuaNew(self:Find('model'));
	textName.text = npcVO.name;
	modelView:OnUpdateUI(npcVO.model);
	self.mModelShowView = modelView;
end

function PromoteNPCItem:OnClickExam(  )
	if self.mCanExam then
		self.mCallBack( );
	end
end

function PromoteNPCItem:ShowExamButton( show )
	self.mCanExam = show;
	self.mButtonTip:SetActive( show );
end

function PromoteNPCItem:OnViewShow( )
	self.mModelShowView:ShowView( );
end

function PromoteNPCItem:OnViewHide( )
	self.mModelShowView:HideView( );
end

function PromoteNPCItem:Dispose(  )
	self.mModelShowView:Dispose( );
end

return PromoteNPCItem;