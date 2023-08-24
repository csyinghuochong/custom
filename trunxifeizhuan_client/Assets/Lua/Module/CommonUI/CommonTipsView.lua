local mLuaClass = require "Core/LuaClass"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mGameLuaInterface = GameLuaInterface;
local mDoFileUtil = require "Utils/DoFileUtil";
local ObjectPool = require "Common/ObjectPool"

local function CommonTipsCallback()
	return mDoFileUtil:DoFile(mViewEnum.CommonTipsView).LuaNew();
end

local CommonTipsPool = ObjectPool.LuaNew(CommonTipsCallback,nil,nil);

local CommonTipsView = mLuaClass("CommonTipsView", mBaseWindow);

function CommonTipsView:InitViewParam()
	return {
		["viewPath"] = "ui/common/",
		["viewName"] = "common_tips_view",
		["ParentLayer"] = mPopLayer,
		["ForbitSound"] = true,
	};
end

function CommonTipsView:Init()
    self.mTipsText = self:Find("tips"):GetComponent('Text');
end

function CommonTipsView:OnViewShow(logicParams)
    self.mTipsText.text = logicParams;
    local transform = self.mTransform;
    transform.localPosition = Vector3.zero;
    mGameLuaInterface.DOLocalMoveY(transform, 100, 1, function() self:OnFade() end);
end

function CommonTipsView:OnFade()
	self:HideView()
	CommonTipsPool:Put(self);
end

function CommonTipsView.Show(params)
    local obj = CommonTipsPool:Get();
	obj:ShowView(params);
    --mUIManager:HandleUI(mViewEnum.CommonTipsView, 1, params);
end

return CommonTipsView;