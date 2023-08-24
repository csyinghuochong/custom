local LuaClass = require "Core/LuaClass"
local ModelView = require "Battle/View/ModelView"
local UIModelView = LuaClass("UIModelView",ModelView);
local mResourceUrl = require "AssetManager/ResourceUrl"
local mViewRootTrans = mViewRootTrans;

function UIModelView:GetModelPath()
	return mResourceUrl.GetUIRolePath("");
end

function UIModelView:ResetGameObject(go)
	if go then
		go.transform:SetParent(mViewRootTrans);
	end
end

return UIModelView;