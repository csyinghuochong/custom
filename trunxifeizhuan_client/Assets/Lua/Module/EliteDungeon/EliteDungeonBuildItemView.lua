local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local mGameModelManager = require "Manager/GameModelManager"
local mConfigSysdungeon = require "ConfigFiles/ConfigSysdungeon"
local mColor = Color
local EliteDungeonBuildItemView = mLuaClass("EliteDungeonBuildItemView", mBaseView);
local mSuper = nil;

function EliteDungeonBuildItemView:OnLuaNew(go,data,callback)
	mSuper = self:GetSuper(mBaseView.LuaClassName);
	mSuper.OnLuaNew(self, go);

	self.mData = data;
	self.mCallback = callback;
end

function EliteDungeonBuildItemView:Init()
	self.mImgBuild = self:FindComponent("BtnBuild/Build","Image");
	self.mBtnBuild = self:FindComponent("BtnBuild","Button")
	self.mGoFlag = self:Find("Name").gameObject;
	self:FindAndAddClickListener("BtnBuild",function() self:OnClickBuild() end)
	self:FindAndAddClickListener("Name",function() self:OnClickBuild() end)
end

function EliteDungeonBuildItemView:OnClickBuild()
	local callBack = self.mCallback;
	if callBack ~= nil then
		if self.mIsOpen then
			local Data = {data=self.mData;transform = self.mTransform};
			callBack(Data);
		end
	end
end

function EliteDungeonBuildItemView:SetState(state)
	if state ~= nil then
		self:SetObjectState(state);
	else
		local data = self.mData;
		local nowID = mGameModelManager.EliteDungeonModel.mNowDungeonID;
		local nowBuildID = mConfigSysdungeon[nowID].chapter_id;
		self:SetObjectState(nowBuildID >= data.mID);
	end
end

function EliteDungeonBuildItemView:SetObjectState(state)
	self.mIsOpen = state;
	self.mBtnBuild.enabled = state;
	self.mGoFlag:SetActive(state);
	if state then
		self.mImgBuild.color = mColor.white;
	else
		self.mImgBuild.color = mColor.gray;
	end
end

return EliteDungeonBuildItemView;