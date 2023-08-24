local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mGameTimer = require "Core/Timer/GameTimer"
local mConfigSysnpc = require "ConfigFiles/ConfigSysnpc"
local mStoryBaseView = require "Module/Story/StoryBaseView"
local mGameModelManager = require "Manager/GameModelManager"
local mTypewriterEffectView = require "Module/Story/TypewriterEffectView"
local DungeonRenderTexture = require "Module/Dungeon/DungeonRenderTexture"
local StoryDialogView = mLuaClass("StoryDialogView",mStoryBaseView);
local mTable = require "table"

function StoryDialogView:InitViewParam()
	return {
		["viewPath"] = "ui/story/",
		["viewName"] = "story_dialog_view",
		["ParentLayer"] = mCommonStoryLayer,
	};
end

function StoryDialogView:Init()
	self.mNameObj = self:Find( 'Image_Title' ).gameObject;
	self.mText_name = self:FindComponent('Text_name', 'Text');

	local go = self:Find("TypewriteView").gameObject;
	self.mTypeWriteView = mTypewriterEffectView.LuaNew();
	self.mTypeWriteView :InjectGameObject(go);

	local ClickNextCallBack = function() self:OnClickNext() end;
	local ClickEndCallBack = function() self:OnEndDialog() end;
	local ClickReturnBack = function() self:OnClickReturn() end;
	self:FindAndAddClickListener('button_bg', ClickNextCallBack);
	self:FindAndAddClickListener('button_skip', ClickEndCallBack);
	self:FindAndAddClickListener('button_return', ClickReturnBack);
	self.mButtonReturn = self:Find( 'button_return' ).gameObject;

	self.mModelLeft = DungeonRenderTexture.LuaNew( self:Find('role_left') );
	self.mModelRight = DungeonRenderTexture.LuaNew( self:Find('role_right') );

	self:SetBgWidth( );
end

function StoryDialogView:SetBgWidth(  )
	local rTransform1 = self:FindComponent('dialog_bg2', 'RectTransform');
	local rTransform2 = self:FindComponent('dialog_bg3', 'RectTransform');
	local width = mUIManager:GetDeviceWidth( ) / 2;
	rTransform1.sizeDelta = Vector2.New( width, 130);
	rTransform2.sizeDelta = Vector2.New( width, 130);
end

function StoryDialogView:OnViewShow( data )
	local sysStory = data.sys_story;
	self.mDialogList = sysStory.story_dialogs;
	self.mCallBack = data.callBack;
	self.mbeginBack = data.beginBack;
	self.mReturnBack = data.returnBack;
	self.mButtonReturn:SetActive(data.returnBack ~= nil );
	self.mDialogIndex = 1;
	self:OnClickNext();
end

function StoryDialogView:OnViewHide()
	self.mModelRight:HideView( );
	self.mModelLeft:HideView( );
end

function StoryDialogView:Dispose()
	self.mModelRight:Dispose( );
	self.mModelLeft:Dispose( );
	self.mTypeWriteView:CloseView();
end

function StoryDialogView:OnEndDialog()
	self:CloseView();

	local call_back = self.mCallBack;
	if call_back ~= nil then
		call_back();
	end
end

function StoryDialogView:OnClickReturn( )
	self:CloseView();
	self.mReturnBack( );
end

function StoryDialogView:OnClickNext()
	local view = self.mTypeWriteView;
	local dialog_list = self.mDialogList;
	local dialog_index = self.mDialogIndex;

	if view and view.mIsActive then
		view:ShowAllText();
	elseif mTable.getn(dialog_list) < dialog_index then
		self:OnEndDialog();
	else
		local npcAction = dialog_list[dialog_index].npc_action;
		if npcAction and #npcAction > 0 then
			self:SetGlobalClickEnable( false );
			local callBack = self.mbeginBack;
			if callBack ~= nil then
				callBack( npcAction ); 
			end
			mGameTimer.SetTimeout(1, function()
	    		self:OnBeginDialog( );
	    		self:SetGlobalClickEnable( true );
	    	end);
		else
			self:OnBeginDialog( );
		end
	end
end

function StoryDialogView:OnBeginDialog(  )
	local view = self.mTypeWriteView;
	local dialog_index = self.mDialogIndex;
	local dialog_list = self.mDialogList;

	if view and view.mIsActive then
		view:ShowAllText();
	elseif dialog_index <= mTable.getn(dialog_list) then
		local data = dialog_list[dialog_index];
		self:ShowBustPicture(data);
		self:ShowDialogContent(data);
	else
		self:OnEndDialog();
	end
end

function StoryDialogView:GetUIModelInfo(npc_id)
	if npc_id == -1 then
		return false, "", "";
	elseif npc_id == 0 then
		local playerBase = mGameModelManager.RoleModel.mPlayerBase;
		return true, mGameModelManager.FollowerModel:GetLeadVO(), playerBase.name;
	else
		local npc = mConfigSysnpc[npc_id];
		if npc == nil then
			print('无效的Npc  '..tostring(npc_id));
		end
		return false, npc.model, npc.name;
	end
end

function StoryDialogView:ShowLeft(lead, npc_id, vo)
	self:UpdateModelView ( self.mModelLeft, lead, npc_id, vo );
	self.mModelRight:HideView( );
end

local StoryNpcView = require "Module/Story/StoryNpcView"
function StoryDialogView:UpdateModelView( modelView, lead, npc_id, vo )
	local texture = nil;
	local npcItem = NpcTextureList[ npc_id ];
	if npcItem and npcItem.mModelShowView then
		texture = npcItem.mModelShowView.mRenderTexture;
	end
	if modelView.mIsShow then
		modelView:HideView( );
	end
	modelView:UpdateModelView( lead, vo, texture);
end

function StoryDialogView:ShowRigth(lead, npc_id, vo)
	self:UpdateModelView ( self.mModelRight, lead, npc_id, vo );
	self.mModelLeft:HideView( );
end

function StoryDialogView:ShowBustPicture(data)
	--  -1/0中间  1左右  2右边
	local npc_id = data.npc_id;
	local direction = data.direction;
	local lead, model, npc_name = self:GetUIModelInfo(npc_id);

	if npc_id == -1 then
		self.mModelLeft:HideView( );
		self.mModelRight:HideView( );
	elseif direction == 1 then
		self:ShowLeft(lead,npc_id, model);
	else
		self:ShowRigth(lead,npc_id, model);
	end
	self:UpdateRoleName( npc_name );
end

function StoryDialogView:UpdateRoleName( npc_name )
	self.mText_name.text = npc_name;
	self.mNameObj:SetActive( npc_name ~= '' );
end

function StoryDialogView:CurrentDialogComplete()
	self.mDialogIndex = self.mDialogIndex + 1;
end

function StoryDialogView:ShowDialogContent(data)
	local content = string.gsub(data.chinese_content, "{0}",  mGameModelManager.RoleModel.mPlayerBase.name);
	self.mTypeWriteView:SetData({text = content, callback = function() self:CurrentDialogComplete() end, charsPerSecond = 20});
	self:PlaySoundName(data.sound_id);
end

return StoryDialogView;