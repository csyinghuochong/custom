local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local mPromoteController = require "Module/Promote/PromoteController"
local PromoteBeginView = mLuaClass("PromoteBeginView",mBaseView);

function PromoteBeginView:Init()
	self.mTextExamName = self:FindComponent('Text_1', 'Text');
	self.mTextExamDesc = self:FindComponent('Text_desc', 'Text');

	self:FindAndAddClickListener("button_ok",function() self:OnClickBeginExam() end);
end

function PromoteBeginView:OnViewShow( logicParams )
	self:OnUpdateUI(logicParams);
end

function PromoteBeginView:OnViewHide( logicParams )
end

function PromoteBeginView:OnUpdateUI(vo)
	self.mData = vo;
	local type_vo =  vo:GetExamTypeInfo();
	local name, desc = type_vo.title, type_vo.desc;
	self.mTextExamName.text = name;
	self.mTextExamDesc.text = desc;
end

function PromoteBeginView:OnClickBeginExam(  )
	mPromoteController:SendBeginExam( self.mData.mSysVO.type );
end

return PromoteBeginView;