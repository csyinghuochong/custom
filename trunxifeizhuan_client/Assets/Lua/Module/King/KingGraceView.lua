local mLuaClass = require "Core/LuaClass"
local mKingInviteView = require "Module/King/KingInviteView"
local mLanguage = require "Utils/LanguageUtil"
local mLayoutController = require "Core/Layout/LayoutController"
local mEventEnum = require "Enum/EventEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mKingController = require "Module/King/KingController"
local KingGraceView = mLuaClass("KingGraceView",mKingInviteView);

function KingGraceView:OnUpdateUI(data)
	local model = mGameModelManager.KingModel;
	if model.mGraceRecv then
       self:InitSkills();
	else
       mKingController:SendGetSkillData(2);
	end
end

function KingGraceView:InitSkills()
	local model = mGameModelManager.KingModel;
	local data_soure = model.mGraceSkillList;
	self:SetSkills(data_soure);
end

function KingGraceView:SetAttribute(skillLevelConfig)
	local attributeList = self.mAttributeList;
	local index = 1;
	for k,v in pairs(skillLevelConfig.king_attri) do
		if v.value ~= 0 and index <= 6 then
		   attributeList[index]:ShowView();
		   attributeList[index]:UpdateUI(v.key,v.value);
           index = index +1;
		end
	end
	for i=index,6 do
		attributeList[i]:HideView();
	end
end

function KingGraceView:SetBtnName()
	self.mBtnName.text = mLanguage.king_grace;
end

return KingGraceView;