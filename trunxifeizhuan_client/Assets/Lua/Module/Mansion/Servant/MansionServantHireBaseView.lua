local mViewEnum = require "Enum/ViewEnum"
local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mUIManager = require "Manager/UIManager"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local MansionController = require "Module/Mansion/MansionController"
local MansionServantHireBaseView = mLuaClass("MansionServantHireBaseView",mBaseView);

function MansionServantHireBaseView:Init()
	self.mTextIntro = self:FindComponent( 'Text_intro', 'Text' );
	self.mTextFunction = self:FindComponent( 'Text_function', 'Text' );
	self.mTextHire = self:FindComponent( 'Text_hire', 'Text' );

	self:FindAndAddClickListener("button_hire", function() self:OnClickHire() end);
end

function MansionServantHireBaseView:OnUpdateData( data )
	self.mData = data;
	local sysVO = data.mSysVO;
	self.mTextIntro.text = sysVO.intro;
	self.mTextFunction.text = string.gsub(sysVO.function_intro,"\\n","\n");
	self.mTextHire.text = sysVO.hire_money;
end

function MansionServantHireBaseView:OnClickHire(  )
	local data = self.mData;
	local open, tip = data:IsCanHire( );
	if open then
		MansionController:SendServantHire( data.mID );
	else
		mCommonTipsView.Show( tip );
	end
end

return MansionServantHireBaseView;