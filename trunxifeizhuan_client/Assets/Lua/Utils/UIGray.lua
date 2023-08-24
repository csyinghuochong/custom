local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local Material = UnityEngine.Material;
local GraphicType = typeof(UnityEngine.UI.Graphic);
local mGrayShader = nil;
local UIGray = mLuaClass("UIGray",mBaseLua);

function UIGray:OnLuaNew()
	self.gray = false;
end

function UIGray:InitGraphics(graphics)
	self.graphics = graphics;

	if graphics.Length == 1 then
		error("graphic数量只有一个");
	end

	return self;
end

function UIGray:InitGraphic(graphic)
	self.graphic = graphic;
	return self;
end

function UIGray:InitGoGraphic(go)
	return self:InitGraphic(go:GetComponent(GraphicType));
end

function UIGray:InitGoGraphics(go)
	return self:InitGraphics(go:GetComponentsInChildren(GraphicType));
end

function UIGray:SetGray(value)
	if value == self.gray then
		return;
	end
	self.gray = value;

	if self.graphics then
		self:SetGraphicsGray(value);
	else
		self:SetGraphicGray(value);
	end
end

function UIGray:SetGraphicsGray(value)
	local selfGraphics = self.graphics;
	local normalMaterials = self.normalMaterials;
	local grayMaterials = self.grayMaterials;

	if normalMaterials == nil then
		normalMaterials = {};
		self.normalMaterials = normalMaterials;
	end

	if grayMaterials == nil then
		grayMaterials = {};
		self.grayMaterials = grayMaterials;
	end

	for i = 0 , selfGraphics.Length - 1  do
		local graphic = selfGraphics[i];
		if value then
			local grayMaterial = grayMaterials[i];

			if grayMaterial == nil then
				normalMaterials[i] = graphic.material;
				mGrayShader = mGrayShader or UnityEngine.Shader.Find("UI/Gray");
				grayMaterial = Material.New(mGrayShader);
				grayMaterials[i] = grayMaterial;
			end

			graphic.material = grayMaterial;
		else
			graphic.material = normalMaterials[i];
		end
	end

end

function UIGray:SetGraphicGray(value)
	local selfGraphic = self.graphic;

	if value then
		local grayMaterial = self.grayMaterial;
		if grayMaterial == nil then
			self.normalMaterial = selfGraphic.material;
			mGrayShader = mGrayShader or UnityEngine.Shader.Find("UI/Gray");
			grayMaterial = Material.New(mGrayShader);
			self.grayMaterial = grayMaterial;
		end

		selfGraphic.material = grayMaterial;
	else
		selfGraphic.material = self.normalMaterial;
	end
end

return UIGray;