local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local mUpdateManager = require "Manager/UpdateManager"
local mConfigSysnpc = require "ConfigFiles/ConfigSysnpc"
local mGameModelManager = require "Manager/GameModelManager"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local StoryNpcItem = mLuaClass("StoryNpcItem", mBaseView);
local mVector2 = Vector2;
local mColor = Color;

function StoryNpcItem:OnLuaNew( index, vo, npc_id, go )
	self.mIndex = index;
	self.mSysVO = vo;
	self.mNpcId = npc_id;
	self.mNpcVO = mConfigSysnpc[npc_id];
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self,go);
end

function StoryNpcItem:Init()
	self.mImageModel = self.mTransform:GetComponent('RawImage');
	self.mRectTransform =self.mTransform:GetComponent('RectTransform');
end

function StoryNpcItem:LoadModelView( npcVO )
	local modelView = ModelRenderTexture.LuaNew( self.mTransform );
	if self.mNpcId == 0 then
		local data = mGameModelManager.FollowerModel:GetLeadVO();
		modelView:OnUpdateVO(data);
	else
		modelView:OnUpdateUI(npcVO.model);
	end
	self.mModelShowView = modelView;
end

function StoryNpcItem:InitModelView( )
	self:LoadModelView( self.mNpcVO );
	self:UpdatePosition( self.mSysVO );
end

function StoryNpcItem:UpdatePosition( vo )
	local transform = self.mTransform;
	self.mRectTransform.sizeDelta = mVector2.New(vo.scale, vo.scale);
	transform.localPosition = Vector3.New(  vo.position_x, vo.position_y, 0 );
	self.mModelShowView:SetDirectionY( vo.direction );
end

function StoryNpcItem:OnViewShow( )
	if self.mModelShowView == nil then
		self:InitModelView( );
	end	
	self.mModelShowView:ShowView( );
end

function StoryNpcItem:Dispose(  )
	self:DisposeModelView( );
end

function StoryNpcItem:OnViewHide( )
	self:HideModelView( );
	mUpdateManager:RemoveUpdate(self);
end

function StoryNpcItem:SetData()
	
end

--[[1 出现
2 消失
3 转向（角度）
4 改变位置
5 动作(动作名称)
6 特效(特效名称)--]]
function StoryNpcItem:UpdateNpcAction( data )
	local action = data.action;
	if action == 1 then
		self:ShowView( );
		self:BeginAlpha( 0, 1, nil );
	elseif action == 2 then
		self:BeginAlpha( 1, 0, function (  )
			self:HideView( );
		end );
	elseif action == 3 then
		self.mModelShowView:SetDirectionY( tonumber(data.param) );
	elseif action == 4 then
		local paraList = { };
		for value in string.gmatch(data.param, "(%d+),*") do
			table.insert( paraList, value );
		end
		self:BeginAlpha( 1, 0, function (  )
			self:BeginAlpha( 0, 1, nil );
			self.mRectTransform.sizeDelta = mVector2.New(paraList[ 3 ], paraList[ 3 ]);
			self.mTransform.localPosition = Vector3.New( paraList[ 1 ], paraList[ 2 ], 0 );
		end );
	elseif action == 5 then
		self.mModelShowView:UpdateNpcAction( data.param );
	end
end

function StoryNpcItem:BeginAlpha( form, to, callBack )
	self.mValueForm = form;
	self.mValueTo = to;
	self.mStarTime = Time.time;
	self.mCallBack = callBack;
	self.mImageModel.color = mColor.New( 1, 1, 1, form );
	mUpdateManager:AddUpdate(self);
end

function StoryNpcItem:OnUpdate()
	local time = Time.time - self.mStarTime;
	if time < 1 then
		self.mImageModel.color = mColor.New( 1, 1, 1, Mathf.Lerp(self.mValueForm, self.mValueTo , time)  )
	else
		self.mImageModel.color = mColor.New( 1, 1, 1, 1 );
		mUpdateManager:RemoveUpdate(self);
		local callBack = self.mCallBack;
		if callBack then
			callBack( );
		end
	end
end

function StoryNpcItem:HideModelView( )
	local modelView = self.mModelShowView;
	if modelView then
		modelView:HideView( );
	end
end

function StoryNpcItem:DisposeModelView(  )
	local modelView = self.mModelShowView;
	if modelView then
		modelView:Dispose( );
	end
end

function StoryNpcItem:UpdateNpcState( vo )
	if vo.show == 1 then
		self:ShowView( );
		self:UpdatePosition( vo );
	else
		self:HideView( );
	end
end

return StoryNpcItem;