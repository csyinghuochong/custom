local mViewEnum = require "Enum/ViewEnum";
local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mUIManager = require "Manager/UIManager"
local mDoFileUtil = require "Utils/DoFileUtil";
local mCameraController = require "Manager/CameraController"
local DungeonEntrySelectView = mLuaClass("DungeonEntrySelectView", mQueueWindow);
local CameraClearFlags = UnityEngine.CameraClearFlags;
local GameObject = UnityEngine.GameObject;
local mVector3 = Vector3;

function DungeonEntrySelectView:InitViewParam()
	return {
		["viewPath"] = "ui/dungeon/",
		["viewName"] = "dungeon_entry_select_view",
		["ParentLayer"] = mMainLayer,
	};
end

function DungeonEntrySelectView:Init()
	self.mSceneMap = mCameraController.mSceneMap;
	self:FindAndAddClickListener("Button_close",function() self:ReturnPrevQueueWindow() end);

	self:InitConfigInfo();
	self:InitSubView ( );
end

function DungeonEntrySelectView:InitSubView(  )

end

function DungeonEntrySelectView:InitConfigInfo(  )
	self.mModelInfoList = 
		{
			{ lead = false, path = 'r_200221', pos_x = -2.7,  pos_y = 4.74, pos_z = 10.47, rotation_y = 111.2, gameobject = 'button_1' },
			{ lead = false, path = 'r_200221', pos_x = 2.44,  pos_y = 4.74, pos_z = 10.47, rotation_y = 111.2, gameobject = 'button_2' },
			{ lead = false, path = 'r_200221', pos_x = 0.19,  pos_y = 4.74, pos_z = 10.47, rotation_y = 111.2, gameobject = 'button_3' },
		}
	self.mMapInfo = 'map_008';
end

function DungeonEntrySelectView:InitModelList(  )
	local modelList = {};
	for k, v in pairs( self.mModelInfoList ) do
		local model = {};
		model.mFile = v.path;
		
		local cls = v.lead and "CombineModelView" or "ModelView"
		local modelView = mDoFileUtil:DoFile("Battle/"..cls).LuaNew(model, nil);
		modelView:ShowView();
		modelList[ k ] = modelView;

		local m_positon = mVector3.New( v.pos_x, v.pos_y, v.pos_z )
		modelView:SetPosition( m_positon );
	    modelView:SetRotation(Quaternion.Euler(0, v.rotation_y, 0));

	    local transform = self:Find(v.gameobject );
	    local screen_position = mCameraController:WorldToScreenPoint( m_positon );
	    transform.position = mUICamera:ScreenToWorldPoint(screen_position);
	    local localPosition = transform.localPosition;
		localPosition.z = 0;
		transform.localPosition = localPosition + self:GetModelOffset();
	end
	self.mModelList = modelList;
end

function DungeonEntrySelectView:DisposeModelList( )
	for k, v in pairs( self.mModelList ) do
		v:Dispose( );
	end
	self.mModelList = nil;
end

function DungeonEntrySelectView:GetModelOffset(  )
	return mVector3.New( 50, 150, 0 );
end

function DungeonEntrySelectView:OnViewShow( )
	mCameraController:OnEnterBattleScene();
	mCameraController:SetCameraRotation( Vector3.zero );
	mUIManager:SetCameraClearFlags( CameraClearFlags.Depth );

	self:InitModelList( );
	self.mSceneMap:ShowCombatBg( self.mMapInfo );
end

function DungeonEntrySelectView:OnViewHide( )
	self:DisposeModelList( );

	mCameraController:OnExitBattleScene( );
	mCameraController:SetCameraRotation( Vector3.New(24, 0, 0) );
	mUIManager:SetCameraClearFlags( CameraClearFlags.SolidColor );
end

function DungeonEntrySelectView:Dispose()
	
end

return DungeonEntrySelectView;