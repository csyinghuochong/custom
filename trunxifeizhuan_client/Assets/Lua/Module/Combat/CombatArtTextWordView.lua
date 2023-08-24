local CombatImageWordView = require "Module/Combat/CombatImageWordView"
local mLuaClass = require "Core/LuaClass"
local CombatArtTextWordView = mLuaClass("CombatArtTextWordView",CombatImageWordView);
function CombatArtTextWordView:InitViewParam()
	return {
		["viewPath"] = "ui/combat/",
		["viewName"] = "art_text_word_view",
		["ParentLayer"] = mBattleLayer,
	};
end

function CombatArtTextWordView:OnViewShow()
	local data = self.mData;
	if not data then 
		return;
	end
	
	local graphic = self.mGameGraphic;
	graphic:SetFontByIndex(data.mFont);
	graphic.graphic.text = data.mText;
	self:SetPosition(data.mPosition);
end

function CombatArtTextWordView:FillData(src,dst)
	dst.mFont = src.type - 1;
	dst.mText = src.word;
	dst.mPosition = src.actor.mPosition;
end

return CombatArtTextWordView;