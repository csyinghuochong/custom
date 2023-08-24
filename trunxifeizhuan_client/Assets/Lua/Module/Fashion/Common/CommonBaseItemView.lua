local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local CommonBaseItemView = mLuaClass("CommonBaseItemView", mBaseView);
local Vector3 = Vector3;
local mVector3One = Vector3.one;
local mVector3Zero = Vector3.zero;
function CommonBaseItemView:Init()
	local itemRoot = self.mItemRoot;
	if itemRoot then
		self:OnSetItemRoot(itemRoot);
	end
	self:OnAwake();
end

function CommonBaseItemView:OnAwake()
end

function CommonBaseItemView:SetIndex(index)
	self.mIndex = index;
end

function CommonBaseItemView:SetItemRoot(root)
	self.mItemRoot = root;
	if self.mGameObject then
		self:OnSetItemRoot(root);
	end
end

function CommonBaseItemView:GetPosition()
	return mVector3Zero;
end

function CommonBaseItemView:OnSetItemRoot(root)

	local transform = self.mTransform;
	transform:SetParent(root);
	transform.localScale = mVector3One;
	transform.localPosition = self:GetPosition();
end

return CommonBaseItemView;