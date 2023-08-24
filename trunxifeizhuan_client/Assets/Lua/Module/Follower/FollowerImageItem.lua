local mLuaClass = require "Core/LuaClass"
local mUIGray = require "Utils/UIGray"
local GameObject = UnityEngine.GameObject;
local mLayoutItem = require "Core/Layout/LayoutItem"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local FollowerImageItem = mLuaClass("FollowerImageItem",mLayoutItem);
local mSuper = nil;
local mColor = Color;

function FollowerImageItem:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_image_item",
	};
end

function FollowerImageItem:Init( )
	self.mTextOffice = self:FindComponent('Text_office', 'Text');
	self:FindAndAddClickListener("bg",function() self:OnClick() end);
	self.mUIGray = mUIGray.LuaNew():InitGoGraphics(self.mGameObject);
	self.mModelShowView = ModelRenderTexture.LuaNew(self:Find('model'));

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function FollowerImageItem:OnClick()
	local data = self.mData;
	if not data:IsValidOffice() then
		self:PlaySoundName("ty_0212");
		return;
	end
	local call_back = data.mCallBack;
	if call_back ~= nil then
		call_back(data.mOfficeVO.office);
	end

	self:PlaySoundName("ty_0203");
end

local mPropertyName = "_Color";
function FollowerImageItem:OnUpdateData()
	local data = self.mData;
	local office_ov = data.mOfficeVO;
					
	local modelView = self.mModelShowView;
	modelView:ShowView( );
	modelView:OnUpdateUI(office_ov.model );

	local valied = data:IsValidOffice();
	self.mTextOffice.text = office_ov.office_name;
	self.mUIGray:SetGray( not valied );

	if valied then
		modelView:SetColor(mColor.white); 
	else
		modelView:SetColor(mColor.gray); 
	end
	
end

function FollowerImageItem:OnRemove()
	self.mModelShowView:Dispose()
end

return FollowerImageItem;