local CombatWordView = require "Module/Combat/CombatWordView"
local mLuaClass = require "Core/LuaClass"
local CombatTextWordView = mLuaClass("CombatTextWordView",CombatWordView);
local math = math;
local Color = UnityEngine.Color;
function CombatTextWordView:InitViewParam()
	return {
		["viewPath"] = "ui/combat/",
		["viewName"] = "text_word_view",
		["ParentLayer"] = mBattleLayer,
	};
end

function CombatTextWordView:Awake()
	self.mText = self:FindComponent('view/word', 'Text');
end

function CombatTextWordView:OnViewShow()
	local data = self.mData;
	if not data then 
		return;
	end
	local text = self.mText;
	text.text = data.mText;
	self:SetPosition(data.mPosition);
end

function CombatTextWordView:FillData(src,dst)
	dst.mText = src.word;
	dst.mPosition = src.actor.mPosition;
end

return CombatTextWordView;