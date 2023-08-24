local mViewEnum = require "Enum/ViewEnum"
local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mUIManager = require "Manager/UIManager"
local MansionController = require "Module/Mansion/MansionController"
local mGameNameManager = require "Module/GameName/GameNameManager"
local MansionServantHireNewView = mLuaClass("MansionServantHireNewView",mBaseView);

function MansionServantHireNewView:Init()
	self.mInputname = self:FindComponent('InputField_name', 'InputField');

	self:FindAndAddClickListener('button_cancel',function() self:OnClickCancel() end);
	self:FindAndAddClickListener('button_confirm',function() self:OnClickConfirm() end);
end

function MansionServantHireNewView:OnUpdateData( data )
	self.mData = data;
end

function MansionServantHireNewView:OnClickCancel(  )
	MansionController:SendServantSkipAlterName( self.mData.mID );
end

local mLanguage = require "Utils/LanguageUtil"
local mTip = mLanguage.invalid_name_tip;
function MansionServantHireNewView:OnClickConfirm(  )
	local name = self.mInputname.text;
	if mGameNameManager:CheckName(name) then
		MansionController:SendServantAlterName( self.mData.mID, name );
	end
end

function MansionServantHireNewView:OnViewHide(  )
	self.mInputname.text = '';
end

return MansionServantHireNewView;