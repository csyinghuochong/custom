local mLuaClass = require "Core/LuaClass"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local DungeonRenderTexture = mLuaClass("DungeonRenderTexture", ModelRenderTexture);
local mSuper = nil;

function DungeonRenderTexture:OnLuaNew( parent )
	mSuper = self:GetSuper(ModelRenderTexture.LuaClassName);

	self:InitTextureParams( parent );
end

function DungeonRenderTexture:UpdateModelView( lead, vo, texture )
	self.mExternalTexture = texture;
	if texture == nil then
		if self.mModelNode == nil then
			self:LoadTextureRoot( );
		end
		if lead then
			self:OnUpdateVO( vo );
		else
			self:OnUpdateUI( vo );
		end
	end

	self:ShowView( );
end

function DungeonRenderTexture:SetRenderTextureVisible(value)
	if self.mExternalTexture then
		if not value then
			self.mExternalTexture = nil;
		end

		self.mImageTexture.texture = self.mExternalTexture;
		self.mImageTexture.color = Color.white;
	else
		mSuper.SetRenderTextureVisible( self, value );
	end
end

function DungeonRenderTexture:CheckCreateModel()
	if self.mExternalTexture == nil then
		mSuper.CheckCreateModel( self );
	end
end

return DungeonRenderTexture;