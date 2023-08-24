local mLuaClass = require "Core/LuaClass"
local Object = UnityEngine.Object;
local GuideObject = mLuaClass("GuideObject");

function GuideObject:OnLuaNew(obj)
    self:Init(obj);
end

function GuideObject:Init(obj)
    self.mBtnComponent = obj:GetComponent('Button');
    self.mFindObj = obj;
end

--设置置顶
function GuideObject:SetTop()
	local obj = self.mFindObj;
    local ray = obj:GetComponent(typeof(UnityEngine.UI.GraphicRaycaster));
    if ray == nil then
        obj:AddComponent(typeof(UnityEngine.UI.GraphicRaycaster));
    end
    local canvas = obj:GetComponent(typeof(UnityEngine.Canvas));
    canvas.overrideSorting = true;
    canvas.sortingOrder = 200;
end

--取消置顶
function GuideObject:SetNormal()
	local obj = self.mFindObj;
	Object.Destroy(obj:GetComponent(typeof(UnityEngine.UI.GraphicRaycaster)));
    Object.Destroy(obj:GetComponent(typeof(UnityEngine.Canvas)));
end

function GuideObject:AddClickListener(listener)
	if self.mBtnComponent ~= nil then
       self.mBtnComponent.onClick:AddListener(listener);
	end
end

function GuideObject:RemoveClickListener(listener)
	if self.mBtnComponent ~= nil then
       self.mBtnComponent.onClick:RemoveListener(listener);
	end
end

return GuideObject