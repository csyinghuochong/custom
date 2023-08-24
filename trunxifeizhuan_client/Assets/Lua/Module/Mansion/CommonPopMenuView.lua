local mLuaClass = require "Core/LuaClass"
local mViewEnum = require "Enum/ViewEnum"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mBaseWindow = require "Core/BaseWindow"
local mUIManager = require "Manager/UIManager"
local mGameObjectUtil = require "Utils/GameObjectUtil"
local mGameModelManager = require "Manager/GameModelManager"
local MansionController = require "Module/Mansion/MansionController"
local CommonPopMenuView = mLuaClass("CommonPopMenuView",mBaseWindow);
local GameObject = UnityEngine.GameObject;
local Screen = UnityEngine.Screen;

function CommonPopMenuView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "common_pop_menu_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function CommonPopMenuView:Init()
	self:InitSubView(  );
end

function CommonPopMenuView:InitSubView( )
	self.mToggle = self:Find( 'Toggle' );
	self.mImageBg = self:FindComponent ( 'Toggle/Image_bg', 'RectTransform' );
	self.mBgWidth = self.mImageBg.sizeDelta.x;

	self.mButtonItem = self:Find( 'Toggle/Button' ).gameObject;
	self.mButtonItem:SetActive( false );
end

function CommonPopMenuView:OnViewShow( logicParams )
	local toggle = self.mToggle;
	local btnParams = logicParams.data;
	self.mData =  btnParams;
	toggle.localPosition = logicParams.position;

	local btnItem = self.mButtonItem;
	for k, v in pairs( btnParams ) do
		local go = GameObject.Instantiate(btnItem);
		go:SetActive( true );

		self:AddBtnClickListener( go, function (  )
			self:OnClickMenuItem( k );
		end )

		local go_transform = go.transform;
		mGameObjectUtil:SetParent(go_transform, toggle);
		go_transform:Find('Text'):GetComponent('Text').text = v.btnName;
		go_transform.localPosition = Vector3.New( 0, 10 - (75 * (k - 1) ) , 0 );
	end

	self.mImageBg.sizeDelta = Vector2.New( 120 , 5 + #btnParams * 75 );
end

function CommonPopMenuView:OnClickMenuItem( index )
	self.mData[index].callBack( );
	self:CloseView();
end

function CommonPopMenuView:ObjectToUIPosition( trans )
	local l_position = mUICamera:WorldToScreenPoint( trans.position ); 
	local d_width = mUIManager:GetDeviceWidth();
	local d_height = mUIManager:GetDeviceHeight();
	l_position.x = l_position.x * d_width / Screen.width;
	l_position.y = l_position.y * d_height / Screen.height;
	l_position.x = l_position.x - d_width / 2;
	l_position.y = l_position.y - d_height / 2;
	return l_position;
end

function CommonPopMenuView:OnViewHide( )
	
end

function CommonPopMenuView:Dispose()
	
end

return CommonPopMenuView;