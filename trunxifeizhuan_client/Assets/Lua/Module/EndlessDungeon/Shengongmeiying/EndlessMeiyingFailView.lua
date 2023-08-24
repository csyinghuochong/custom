local mLuaClass = require "Core/LuaClass"
local mSceneManager = require "Module/Scene/SceneManager"
local mEndlessMeirenFailView = require "Module/EndlessDungeon/Meirenxinji/EndlessMeirenFailView"
local mEndlessDungeonController = require "Module/EndlessDungeon/EndlessDungeonController"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local EndlessMeiyingFailView = mLuaClass("EndlessMeiyingFailView", mEndlessMeirenFailView);

function EndlessMeiyingFailView:OnClickClose()
	local callBack = function()
		mUIManager:HandleUI(mViewEnum.EndlessDungeonMainView,1);
		mUIManager:HandleUI(mViewEnum.EndlessShengongmeiyingView,1);
	end
	mSceneManager:AddEnterSceneCallBack(callBack);
	mSceneManager:AskForEnterScene(1);
	self:HideView();
end

return EndlessMeiyingFailView;