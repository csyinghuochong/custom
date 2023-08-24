local mLuaClass = require "Core/LuaClass"
local mBagView = require "Module/Bag/BagView"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameModelManager = require "Manager/GameModelManager"
local MansionBagView = mLuaClass("MansionBagView", mBagView);
local mSuper = nil;

function MansionBagView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_bag_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
    	["cost"] = {"gold","silver", 'mansion_cion'},
	};
end

function MansionBagView:Init()
	mSuper = self:GetSuper(mBagView.LuaClassName);
    mSuper.Init(self);
end

function MansionBagView:GetGoodsTypeByIndex(  )
    return self.mSelectIndex + mGameModelManager.BagModel.mTypeEnum.Seed - 1;
end

return MansionBagView;