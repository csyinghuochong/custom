local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum";
local mGameObjectUtil = require "Utils/GameObjectUtil"
local CommonTabBaseView = mLuaClass("CommonTabBaseView", mBaseView);


function CommonTabBaseView:OnViewShow(logicParams)
	self:OnUpdateUI(logicParams);
end

function CommonTabBaseView:OnUpdateUI(data)
	
end

return CommonTabBaseView;