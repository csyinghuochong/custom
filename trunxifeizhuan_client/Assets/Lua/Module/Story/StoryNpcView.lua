local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local StoryNpcItem = require "Module/Story/StoryNpcItem"
local StoryNpcView = mLuaClass("StoryNpcView",mBaseView);
local GameObject = UnityEngine.GameObject;
local DebugHelper = DebugHelper;
local mPairs = pairs;
local mSuper = nil;

--测试用npc_id
local mTestNpcInit = {
		{ npc_id = 1, show = 1, position_x = 127, position_y = 38, scale = 300, direction = -60 };
		{ npc_id = 1, show = 1, position_x = 177, position_y = 38, scale = 300, direction = -60 };
		{ npc_id = 1, show = 1, position_x = 200, position_y = 38, scale = 300, direction = -60 };
		{ npc_id = 1, show = 1, position_x = 220, position_y = 38, scale = 300, direction = -60 };
		{ npc_id = 1, show = 1, position_x = 240, position_y = 38, scale = 300, direction = -60 };
		{ npc_id = 1, show = 1, position_x = 260, position_y = 38, scale = 300, direction = -60 };
		{ npc_id = 1, show = 1, position_x = 300, position_y = 38, scale = 300, direction = -60 };
		{ npc_id = 1, show = 1, position_x = 320, position_y = 38, scale = 300, direction = -60 };
		{ npc_id = 1, show = 1, position_x = 340, position_y = 38, scale = 300, direction = -60 };
		{ npc_id = 1, show = 1, position_x = 360, position_y = 38, scale = 300, direction = -60 };
		{ npc_id = 1, show = 1, position_x = 400, position_y = 38, scale = 300, direction = -60 };
	}
NpcTextureList = { };

function StoryNpcView:OnLuaNew(go)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self,go);

	self.mLoadBgComplete = function ( go )
    	self:OnLoadBgComplete(go);
    end
end

function StoryNpcView:Init( )
	self.mNpcModelItem = self:Find('npc_item').gameObject;
end

function StoryNpcView:DisposeModel(  )
	local npcList = self.mNpcItemList;
	if npcList then
		for k, v in pairs( npcList ) do
			v:CloseView( );
		end
	end
	self.mNpcItemList = nil;
	NpcTextureList = { };
end

function StoryNpcView:InitNpcModel( sys_story )
	self:DisposeModel( );
	self.mNpcStory = sys_story;
	local npcList = { };
	local npcItem = self.mNpcModelItem;

	local npcVoList = sys_story.npc_init;
	if DebugHelper.sTestStory == true then
		npcVoList = mTestNpcInit;
	end
	for k, v in mPairs( npcVoList ) do
		if v.show ~= -1 then
			local npc_id = v.npc_id;
			local go = GameObject.Instantiate(npcItem);
			mGameObjectUtil:SetParent(go.transform, self.mTransform);
			npcList[npc_id] = StoryNpcItem.LuaNew(k, v, npc_id, go);

			if v.show == 1 then
				npcList[npc_id]:ShowView();
			end
			NpcTextureList[ npc_id ] = npcList[npc_id];
		end
	end
	self.mNpcItemList = npcList;
end

function StoryNpcView:ShowLastState( npc_state )
	local npcList = self.mNpcItemList;
	local npcItem = nil;
	for k , v in pairs( npc_state ) do
		npcItem = npcList[ k ];
		if npcItem then
			npcItem:UpdateNpcState( v );
		end
	end 
end

function StoryNpcView:GetNpcLastState(  )
	local npc_state = { };
	local sys_story = self.mNpcStory;	
	for k, v in mPairs( sys_story.npc_init ) do
		local npc_vo = { };
		setmetatable(npc_vo, {__index = v});
		npc_state[ v.npc_id ] = npc_vo;
	end

	for k, v in mPairs ( sys_story.story_dialogs) do
		if v.npc_action ~= nil then
			for key, value in mPairs ( v.npc_action ) do
				local action = value.action;
				local npc_vo = npc_state[ value.npc_id ];
				if action == 1 then
					npc_vo.show =  1;
				elseif action == 2 then
					npc_vo.show =  0;
				elseif action == 3 then
					npc_vo.direction = tonumber( value.param );
				elseif action == 4 then
					local paraList = { };
					for vv in string.gmatch(value.param, "(%d+),*") do
						table.insert( paraList, vv );
					end
					npc_vo.position_x = paraList[ 1 ];
					npc_vo.position_y = paraList[ 2 ];
					npc_vo.scale = paraList[ 3 ];
				end
			end
		end
	end
	return npc_state;
end

function StoryNpcView:UpdateNpcAction( npc_action )
	local npcList = self.mNpcItemList;
	if npc_action ~= nil then
		for key, value in mPairs ( npc_action ) do
			local npc_item  = npcList[ value.npc_id ];
			if npc_item then
				npc_item:UpdateNpcAction( value );
			else
				print ( 'error: npc_action: ', value.npc_id)
			end
		end
	end
end

function StoryNpcView:OnViewHide(  )
	self:DisposeModel( );
end

return StoryNpcView;