local CombatWordView = require "Module/Combat/CombatWordView"
local mLuaClass = require "Core/LuaClass"
local CombatImageWordView = mLuaClass("CombatImageWordView",CombatWordView);
local mColor = Color;

function CombatImageWordView:InitViewParam()
	return {
		["viewPath"] = "ui/combat/",
		["viewName"] = "image_word_view",
		["ParentLayer"] = mBattleLayer,
	};
end

function CombatImageWordView:Awake()
	self.mGameGraphic = self:FindComponent('view/word', 'GameGraphic');
end

function CombatImageWordView:OnViewShow()
	local data = self.mData;
	if not data then 
		return;
	end
	
	self.mGameGraphic:SetSpriteByIndex(data.mText,true);
	self:SetPosition(data.mPosition);
end

function CombatImageWordView:FillData(src,dst)

	dst.mText = src.word;
	dst.mPosition = src.actor.mPosition;
end

return CombatImageWordView;