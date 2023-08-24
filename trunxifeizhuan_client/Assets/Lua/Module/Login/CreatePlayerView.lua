local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mLanguageUtil = require "Utils/LanguageUtil"
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mLoginController = require "Module/Login/LoginController"
local mGameNameManager = require "Module/GameName/GameNameManager"
local mFollowerBaseVO = require "Module/Follower/FollowerBaseVO"
local LoginTypewriterView = require "Module/Login/LoginTypewriterView"
local CreatePlayerView = mLuaClass("CreatePlayerView",mBaseWindow);
local mColor = Color;

function CreatePlayerView:InitViewParam()
	return {
		["viewPath"] = "ui/login/",
		["viewName"] = "create_player_view",
		["ParentLayer"] = mLoginLayer,
		["ForbitSound"] = true,
	};
end

local Text_1 = mLanguageUtil.login_create_player_1;
local Text_2 = mLanguageUtil.login_create_player_2;
local Text_3 = mLanguageUtil.login_create_player_3;
local Text_4 = mLanguageUtil.login_create_player_4;
function CreatePlayerView:Init()
	self.mChooseSex = nil;    --1男性 2女性--
	self.mInputname = self:FindComponent('Bottom/InputField_name', 'InputField');

	local roleMan = self:Find( 'RoleMan' );
	local roleWoman = self:Find( 'RoleWomen' );
	self:AddBtnClickListener(roleMan.gameObject, function() self:OnClickSelectMan() end,"ty_0204");
	self:AddBtnClickListener(roleWoman.gameObject,function() self:OnClickSelectWoman() end,"ty_0204");
	self:FindAndAddClickListener('Bottom/Button_random',function() self:OnClickRandomName() end,"ty_0208");
	self:FindAndAddClickListener('Bottom/Button_enter',function() self:OnClickEnterGame() end,"ty_0205");

	local modelView1 = mModelShowView.LuaNew(roleMan,  true,650,650);
	local modelView2 = mModelShowView.LuaNew(roleWoman,true,650,650);
	modelView1:OnUpdateLead( 1 );
	modelView2:OnUpdateLead( 2 );
	self.mModelShowView1 = modelView1;
	self.mModelShowView2 = modelView2;

	self.mTypewriterView1 =  LoginTypewriterView.LuaNew( self:Find('Left').gameObject, Text_1, Text_2 );
	self.mTypewriterView2 = LoginTypewriterView.LuaNew( self:Find('Right').gameObject, Text_3, Text_4  );
end

function CreatePlayerView:OnClickSelectMan()
	self:OnSelectSex(1);

	self:SetImageSelect(self.mTypewriterView1, self.mModelShowView1,true);
	self:SetImageSelect(self.mTypewriterView2, self.mModelShowView2,false);
end

function CreatePlayerView:OnClickSelectWoman()
	self:OnSelectSex(2);

	self:SetImageSelect(self.mTypewriterView1,self.mModelShowView1,false);
	self:SetImageSelect(self.mTypewriterView2,self.mModelShowView2,true);
end

function CreatePlayerView:OnSelectSex(sex)
	if self.mChooseSex == sex then
		return;
	end
	self.mChooseSex = sex;
	self:OnClickRandomName();
end

function CreatePlayerView:SetImageSelect(textView, modelView,selected)
	modelView:SetColor(selected and mColor.white or mColor.gray); 
	if selected then
		textView:ShowView( );
	else
		textView:HideView( );
	end
end

function  CreatePlayerView:OnClickRandomName()
	local sex = self.mChooseSex;
	self.mInputname.text = mGameNameManager:GetRoleName(sex);
end

function  CreatePlayerView:OnClickEnterGame()
	local name = self.mInputname.text;
	if mGameNameManager:CheckName(name) then
		mLoginController:CreatePlayer(name,self.mChooseSex);
	end
end

function CreatePlayerView:OnViewShow()
	self:OnClickSelectMan();
	self.mModelShowView1:ShowView();
	self.mModelShowView2:ShowView();
end

function CreatePlayerView:Dispose()
	self.mModelShowView1:Dispose();
	self.mModelShowView2:Dispose();
	self.mTypewriterView1:CloseView( );
	self.mTypewriterView2:CloseView( );
end

return CreatePlayerView;