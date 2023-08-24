local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mUIManager = require "Manager/UIManager"
local mBaseWindow = require "Core/BaseWindow"
local mGameTimer = require "Core/Timer/GameTimer"
local mCombatSetView = require "Module/Combat/CombatSetView"
local mCameraController = require "Manager/CameraController"
local mCombatSkillView = require "Module/Combat/CombatSkillView"
local CombatSkillView = require "Module/Combat/CombatSkillView"
local mCombatModelManager = require "Module/Combat/CombatModelManager"
local mGameModelManager = require "Manager/GameModelManager"
local CombatView = mLuaClass("CombatView",mBaseWindow);
local GameObject = UnityEngine.GameObject;
local mColor = Color;

require "Module/Face/FaceConfig"
local mCommonChatButton = require "Module/CommonUI/CommonChatButton"
local mSensitiveWordUtil = require "Utils/SensitiveWordUtil"
local mLanguageUtil = require "Utils/LanguageUtil"
local mLgSystem = mLanguageUtil.chat_system;


function CombatView:InitViewParam()
	return {
		["viewPath"] = "ui/combat/",
		["viewName"] = "combat_view",
		["ParentLayer"] = mBattleLayer,
		["AdditionalShaderChannels"] = true,
	};
end

local mPassivitySkillEffect = 'ui_combat_view_bottomright_icon';
function  CombatView:Init()
	--skill
	local effect_node = self:Find( 'bottomRight/skill_bar_view/skill_effect' );
	local skillView = CombatSkillView.LuaNew(self:Find('bottomRight/skill_bar_view').gameObject);
	skillView:HideView();
	skillView:SetSkillEffect( effect_node );
	self.mSkillBar = skillView;
	self:AddUIEffect(mPassivitySkillEffect, effect_node);

	--set--
	local setView = mCombatSetView.LuaNew();
	setView.mGoParent = self:Find('bottomLeft');
	self.mSetView = setView;

	local goChatButton = self:Find("Chat").gameObject;
	self.mChatButton = mCommonChatButton.LuaNew(goChatButton,true);

	self.mTurnRound = function (current) self:OnTurnRound(current) end
	self.mCombatOver = function (combat) self:OnCombatOver(combat) end
	self.mRoundDone = function () self:OnRoundDone() end
	self.mShowNextScene = function(map) self:ShowNextScene(map) end

	self.mSceneMap = mCameraController.mSceneMap;
end

function CombatView:OnViewShow(logicParams)
	self.mSetView:ShowView();

	self:RegisterEventListener(mEventEnum.ON_START_ROUND,self.mTurnRound, false);
	self:RegisterEventListener(mEventEnum.ON_ACTOR_USE_SKILL,self.mRoundDone, false);
	self:RegisterEventListener(mEventEnum.ON_COMBAT_OVER,self.mCombatOver, false);
	self:RegisterEventListener(mEventEnum.ON_SHOW_NEXT_COMBAT_SCENE, self.mShowNextScene, false);
	self.mSceneMap:ShowCombatBg( mCombatModelManager.mCurrentModel:GetSceneMap(1) );

	mUIManager:HandleUI(mViewEnum.CombatStartView,1);
end

function CombatView:OnCombatOver(result)

	if result == 1 then
		mGameTimer.SetTimeout(1, function() self:Dispatch(mEventEnum.ON_SHOW_WIN_POSE,1); end);
	end

	mGameTimer.SetTimeout(result == 1 and 3 or 1, function (  )
		self:HideView();
		mCombatModelManager.mCurrentModel:ShowResultView(result);
	end)

end

function CombatView:ShowNextScene(map)
	
	if map then
		self.mSceneMap:ShowCombatBg( map );
	end

end

function CombatView:OnViewHide(  )
	self.mSkillBar:HideView();
	self.mSetView:HideView();
end

function CombatView:Dispose()
	self.mSkillBar:CloseView();
	self.mSetView:CloseView();
	self.mChatButton:CloseView();
end

function CombatView:OnTurnRound(current)
	local skill_bar = self.mSkillBar;
	local actor = current:IsPlayerControl() and current or nil;
	if actor == nil then
		skill_bar:HideView();
	else
		skill_bar:ShowView();
		skill_bar:UpdateView(actor);
	end
	self.mActor = actor;
end

function CombatView:OnRoundDone()
	local skill_bar = self.mSkillBar;
	if skill_bar then
		skill_bar:HideView();
	end
end

return CombatView;