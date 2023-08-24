local mViewEnum = require "Enum/ViewEnum";
local mLuaClass = require "Core/LuaClass"
local mUIManager = require "Manager/UIManager"
local mQueueWindow = require "Core/QueueWindow"
local mLanguageUtil = require "Utils/LanguageUtil"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local MansionComposeEntryView = mLuaClass("MansionComposeEntryView", mQueueWindow);

function MansionComposeEntryView:InitViewParam()
	return {
		["viewPath"] = "ui/mansion/",
		["viewName"] = "mansion_compose_entry_view",
		["ParentLayer"] = mMainLayer,
	};
end

function MansionComposeEntryView:Init(  )
	self:InitSubView( );
end

local mNpcNumber = 4;
function MansionComposeEntryView:InitSubView(  )
	for index = 1, mNpcNumber do 
		local text_btn = self:FindComponent( string.format( 'npc%d/Button_2/Text', index ), 'Text' );
		text_btn.text = mLanguageUtil[ 'mansion_compose_button_'..index ];
		self:FindAndAddClickListener(string.format( 'npc%d/Button_1', index ), function() self:OnClickComposeBtn( index ); end, nil, 0.5);
		self:FindAndAddClickListener(string.format( 'npc%d/Button_2', index ), function() self:OnClickComposeBtn( index ); end, nil, 0.5);
	end

	self.mModelInfos = { 'r_200112', 'r_201211', 'r_202511', 'r_201511' };
	self:FindAndAddClickListener("Button_close",function() self:ReturnPrevQueueWindow() end);

	self:InitNpcModelList( );
end

function MansionComposeEntryView:InitNpcModelList( )
	local npcList = {};
	local sort = self:GetValidSortingOrder( );
	for k, v in pairs( self.mModelInfos ) do
		local modelView = ModelRenderTexture.LuaNew( self:Find( string.format( 'npc%d/model', k ) ) );
		modelView:OnUpdateUI( v,  sort);
		npcList[ k ] = modelView;
	end
	self.mNpcModeList = npcList;
end

function MansionComposeEntryView:ShowNpcModelList( )
	for k, v in pairs( self.mNpcModeList ) do
		v:ShowView( );
	end
end

function MansionComposeEntryView:OnClickComposeBtn( index )
	if index == 1 then
		mCommonTipsView.Show('暂未开启');
	else
		mUIManager:HandleUI(mViewEnum.MansionComposeBaseView, 1, index );
	end
end

function MansionComposeEntryView:OnViewShow(  )
	self:ShowNpcModelList( );
end

function MansionComposeEntryView:OnViewHide(  )
	for k, v in pairs( self.mNpcModeList ) do
		v:HideView( );
	end
end

function MansionComposeEntryView:Dispose(  )
	for k, v in pairs( self.mNpcModeList ) do
		v:Dispose( );
	end
	self.mNpcModeList = nil;
end

return MansionComposeEntryView;