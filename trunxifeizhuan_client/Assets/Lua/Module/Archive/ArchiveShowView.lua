local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mCommonToggleGroup = require "Module/CommonUI/TabView/CommonToggleGroup"
local mLayoutController = require "Core/Layout/LayoutController"
local mConfigSysactor = require "ConfigFiles/ConfigSysactor"
local mConfigSysfollower_office_up = require "ConfigFiles/ConfigSysfollower_office_up"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mCommonSkillVO = require "Module/CommonUI/CommonSkillVO"
local mSortTable = require "Common/SortTable"
local mResourceUrl = require "AssetManager/ResourceUrl"
local mUITextureManager = require "Manager/UITextureManager"
local mColor = Color
local mModelShowView = require "Module/Story/ModelRenderTexture"
local mViewEnum = require "Enum/ViewEnum"
local mUIManager = require "Manager/UIManager"
local ArchiveShowView = mLuaClass("ArchiveShowView", mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgTable = {mLanguageUtil.follower_type_name_1,mLanguageUtil.follower_type_name_2,mLanguageUtil.follower_type_name_3,mLanguageUtil.follower_type_name_4,mLanguageUtil.follower_type_name_5}
local MAX = 5;
local MAX_STAR = 6;
local mIconPath = mResourceUrl.role_icon;

function ArchiveShowView:InitViewParam()
	return {
		["viewPath"] = "ui/archive/",
		["viewName"] = "archive_show_view",
		["ParentLayer"] = mMainLayer2,
		["viewBgEnum"] = mViewBgEnum.gray,
	};
end

function ArchiveShowView:Init()
	self:FindAndAddClickListener("BtnClose",function() self:ReturnPrevQueueWindow(); end);
	self:FindAndAddClickListener("BtnLeft",function() self:OnClickLeft(); end);
	self:FindAndAddClickListener("BtnRight",function() self:OnClickRight(); end);
	self:FindAndAddClickListener("BtnTalk",function() self:OnClickTalk(); end);
	self:FindAndAddClickListener("BtnChange",function() self:OnClickChange(); end);

	self.mModelShowViewFollower = mModelShowView.LuaNew(self:Find('model'),true);

	local parent = self:Find("Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/CommonUI/CommonSkillBaseItemView");

	self.mTextName = self:FindComponent("text/Name","Text");
	self.mTextType = self:FindComponent("text/Type","Text");
	local textAttriTable = {};
	for i=1,5 do
		local text = self:FindComponent("text/Attri"..i,"Text");
		textAttriTable[i] = text;
	end
	textAttriTable[1].text = mConfigSysglobal_value[mConfigGlobalConst.PLAYER_MAX_LV];
	self.mTextAttriTable = textAttriTable;

	local goStars = {};
	for i=1,6 do
		local star = self:Find("Star/star"..i).gameObject;
		goStars[i] = star;
	end
	self.mGoStars = goStars;

	self.mGameImgType1 = self:FindComponent("TypeIcon1","Image");
	self.mGameImgType2 = self:FindComponent("TypeIcon2","Image");
	self.mGameImgChangeBack = self:FindComponent("BtnChange/back","Image");

	local callBack = function( index )
		   self:OnClickTypeButton(index);
	 end
	local go = self:Find('buttonView');
	self.mToggleGroup = mCommonToggleGroup.LuaNew(go,callBack,1);
    self.mSelectIndex = 1;

    self.mLoadedIcon = function(icon) self:OnLoadedIcon(icon); end
    self.mImgIcon = self:FindComponent('BtnChange/icon','RawImage');
	self.mImgIcon.color = mColor.clear;
end

function ArchiveShowView:OnClickLeft()
	local model = mGameModelManager.ArchiveModel;
	local id = model:GetLastID(self.mSelectIndex);
	self:ChangeData(id,self.mIsMax);
end

function ArchiveShowView:OnClickRight()
	local model = mGameModelManager.ArchiveModel;
	local id = model:GetNextID(self.mSelectIndex);
	self:ChangeData(id,self.mIsMax);
end

function ArchiveShowView:OnClickTalk()
	local data = {mID = self.mActorID};
	mUIManager:HandleUIWithParent(mMainLayer2,mViewEnum.FollowerCommentView, 1, data);
end

function ArchiveShowView:OnClickChange()
	self.mIsMax = not self.mIsMax;
	self:ChangeData(self.mActorID,self.mIsMax);
end

function ArchiveShowView:OnClickTypeButton(index)
	self.mSelectIndex = index;
	local idTable = self.mIdTable;
	local id = idTable[index];
	self:ChangeData(id,self.mIsMax);
end

function ArchiveShowView:OnViewShow(param)
	self:ChangeData(param,false);
	self.mModelShowViewFollower:ShowView();
end

function ArchiveShowView:ChangeData(actor_id,isMax)
	if actor_id ~= nil then
		self.mIsMax = isMax;
		self.mActorID = actor_id;
		local office;
		local config = mConfigSysactor[actor_id];
		self.mSelectIndex = config.camp;
		self.mTextName.text = config.name;
		self.mGameObjectUtil:SetImageSprite(self.mGameImgType1,"common_power_"..config.camp);
		self.mGameObjectUtil:SetImageSprite(self.mGameImgType2,"common_icon_genre"..config.type);
		self.mTextType.text = mLgTable[config.type];
		self:SetToggleState(config);
		if isMax then
			office = actor_id.."_"..MAX;
		else
			office = actor_id.."_"..config.position;
		end
		local configOffice = mConfigSysfollower_office_up[office];
		self:CreateData(configOffice);
		self:CreateAttri(config,configOffice);
		self:CreateStar(config.star);
		self:CreateSkill(configOffice.all_skill);
		self:CreateChangeBtn(configOffice.mini_icon);
	end
end

function ArchiveShowView:SetToggleState(config)
	local idTable = {};
	for k,v in ipairs(config.actors) do
		local index = mConfigSysactor[v].camp;
		idTable[index] = v;
	end
	self.mIdTable = idTable;

	for i=1,5 do
		local btn = self:FindComponent("buttonView/Button"..i,"Button");
		local img = self:FindComponent("buttonView/Button"..i.."/on_normal","Image");
		if idTable[i] ~= nil then
			img.color = mColor.New(1,1,1,1);
			btn.enabled = true;
		else
			img.color = mColor.New(0.45,0.45,0.45,1);
			btn.enabled = false;
		end
	end

	self.mToggleGroup:OnClickToggleButton(config.camp,false);
end

function ArchiveShowView:CreateData(configOffice)
	self.mModelShowViewFollower:OnUpdateUI(configOffice.model );
end

function ArchiveShowView:CreateAttri(config,configOffice)
	for i=2,5 do
		if i == 5 then
			local speedLastAdd = configOffice.addition_attri[4];
			if speedLastAdd ~= nil then
				self.mTextAttriTable[i].text = self:GetAttriSingleData(config.base_attri[8].value,config.addition_attri[8].value,speedLastAdd.value);
			else
				self.mTextAttriTable[i].text = self:GetAttriSingleData(config.base_attri[8].value,config.addition_attri[8].value,0);
			end
		else
			self.mTextAttriTable[i].text = self:GetAttriSingleData(config.base_attri[i-1].value,config.addition_attri[i-1].value,configOffice.addition_attri[i-1].value);
		end
	end
end

function ArchiveShowView:GetAttriSingleData(baseNum,addNum,lastAdd)
	local num = 0;
	local maxLevel = mConfigSysglobal_value[mConfigGlobalConst.PLAYER_MAX_LV];
	if self.mIsMax then
		return math.ceil(baseNum + addNum*(maxLevel-1) + lastAdd);
	else
		return math.ceil(baseNum + lastAdd);
	end
end

function ArchiveShowView:CreateStar(star)
	if self.mIsMax then
		star = MAX_STAR;
	end
	for k, v in pairs(self.mGoStars) do
		v:SetActive(k <= star);
	end
end

function ArchiveShowView:CreateSkill(skills)
	local data_soure = mSortTable.LuaNew(nil,nil,true);
	for k,v in ipairs(skills) do
		local skillVO = mCommonSkillVO.LuaNew(v,1,true);
		data_soure:AddOrUpdate(v,skillVO);
	end
	self.mGridEx:UpdateDataSource(data_soure);
end

function ArchiveShowView:CreateChangeBtn(icon)
	mUITextureManager.LoadTexture(mIconPath, icon,self.mLoadedIcon);
	if self.mIsMax then
		self.mGameObjectUtil:SetImageSprite(self.mGameImgChangeBack,"common_bag_iconframe_8s");
	else
		self.mGameObjectUtil:SetImageSprite(self.mGameImgChangeBack,"common_bag_iconframe_9s");
	end
end

function ArchiveShowView:OnLoadedIcon(icon)
	self.mImgIcon.texture = icon;
	self.mImgIcon.color = mColor.white;
end

function ArchiveShowView:OnViewHide(param)
	self.mModelShowViewFollower:HideView();
end

function ArchiveShowView:Dispose()
	self.mModelShowViewFollower:Dispose();
end

return ArchiveShowView;