local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mGameModelManager = require "Manager/GameModelManager"
local ModelRenderTexture = require "Module/Story/ModelRenderTexture"
local mConfigSyschapter = require "ConfigFiles/ConfigSysdungeon_chapter"
local mEndlessController = require "Module/EndlessDungeon/EndlessDungeonController"
local mFunctionOpenManager = require "Module/MainInterface/FunctionOpenManager"
local mConfigsysfunctionConst = require "ConfigFiles/ConfigSysfunction_openConst"
local mEventEnum = require "Enum/EventEnum"
local mLanguage = require "Utils/LanguageUtil"

local EndlessDungeonMainView = mLuaClass("EndlessDungeonMainView", mQueueWindow);

function EndlessDungeonMainView:InitViewParam()
	return {
		["viewPath"] = "ui/endless_dungeon/",
		["viewName"] = "endless_dungeon_main_view",
		["ParentLayer"] = mMainLayer,
    ["ForbitExternalForceShowSound"] = true,
    ["ForbitExternalForceHideSound"] = true,
	};
end

function EndlessDungeonMainView:Init()
    self:FindAndAddClickListener("Button_return",function() self:ReturnPrevQueueWindow() end);

    local modelList = { };
    for i=1,2 do
      self:FindAndAddClickListener("Button"..i,function() self:EnterEndlessDungeon(i) end);
      modelList[i] = ModelRenderTexture.LuaNew( self:Find('model'..i) );
    end
    self.mNpcModelList = modelList;


    self:RegisterEventListener(mEventEnum.ON_GET_ENDLESS_DATA, function()
         self:InitData();
    end, true);
end

function EndlessDungeonMainView:OnViewShow(logicParams)
    self.mLogicParams = logicParams;
    local chapterEnum = mGameModelManager.EndlessDungeonModel.mChapterEnum;
    self.mChapterEnum = chapterEnum;
    local data = mGameModelManager.EndlessDungeonModel.mShengongmeiyingData;
    if data ~= nil then
       self:InitData();
    else
       
       local chapterList = {chapterEnum.ShengongNormal,chapterEnum.Gongshen,chapterEnum.Meiren};
       mEndlessController:SendGetEndlessInfo(chapterList);
    end

end

function EndlessDungeonMainView:InitData()
    local chapterEnum = self.mChapterEnum;
    local npcModelList = self.mNpcModelList;
    local configChapter = nil;

    configChapter = mConfigSyschapter[chapterEnum.Meiren];
    self:ShowNPCModel( npcModelList[1], configChapter.map, chapterEnum.Meiren);

    configChapter = mConfigSyschapter[chapterEnum.ShengongNormal];
    self:ShowNPCModel( npcModelList[2], configChapter.map, chapterEnum.ShengongNormal);

    -- configChapter = mConfigSyschapter[chapterEnum.Gongshen];
    -- self:ShowNPCModel( npcModelList[3], configChapter.map ,chapterEnum.Gongshen);

    local params = self.mLogicParams;
    if params ~= nil then
       self:EnterEndlessDungeon(tonumber(params));
    end

    local npcModelList = self.mNpcModelList;
    for i,v in ipairs(npcModelList) do
        v:ShowView();
    end
end

function EndlessDungeonMainView:ShowNPCModel(modelView, bustIcon, chapter)
  bustIcon = 'r_200111';

  modelView:OnUpdateUI( bustIcon , true );

  if self:IsPass(chapter) then
    modelView:SetColor( Color.gray );
  elseif not self:IsOpen(chapter) then
    modelView:SetColor( Color.gray );
  else
    modelView:SetColor( Color.white );
  end
	return 
end

function EndlessDungeonMainView:IsPass(chapter)
    local chapterEnum = self.mChapterEnum;
    if chapter == chapterEnum.ShengongNormal or chapter == chapterEnum.ShengongHard then
      local data = mGameModelManager.EndlessDungeonModel.mShengongmeiyingData;
      local maxLevel = data:GetMaxLevel();
      local index = data:GetConfig().index;
      if index == maxLevel and data.mStatus == 1 then
        return true;
      end
    end
    return false;
end

function EndlessDungeonMainView:IsOpen(chapter)
    local functionType = self:GetFunctionType(chapter);
    return mFunctionOpenManager:GetFunctionState(functionType);
end

function EndlessDungeonMainView:GetFunctionType(chapter)
    local chapterEnum = self.mChapterEnum;
    if chapter == chapterEnum.ShengongNormal or chapter == chapterEnum.ShengongHard then
       return mConfigsysfunctionConst.SHENGONG;
    elseif chapter == chapterEnum.Gongshen then
       return mConfigsysfunctionConst.BUBU;
    elseif chapter == chapterEnum.Meiren then
       return mConfigsysfunctionConst.MEIREN;
    end
    return nil;
end

function EndlessDungeonMainView:EnterDungeon(chapter)
    if self:IsPass(chapter) then
       mCommonTipsView.Show(mLanguage.endless_pass);
    elseif not self:IsOpen(chapter) then
       mCommonTipsView.Show(mFunctionOpenManager:GetFunctionOpenLevelStr(self:GetFunctionType(chapter)));
    else
       mEndlessController:EnterDungeon(chapter);
    end
end

function EndlessDungeonMainView:EnterEndlessDungeon(index)
  if index == 1 then
    self:EnterDungeon(self.mChapterEnum.Meiren);
  elseif index == 2 then
    self:EnterDungeon(self.mChapterEnum.ShengongNormal);
  elseif index == 3 then
    self:EnterDungeon(self.mChapterEnum.Gongshen);
  end
    
end

function EndlessDungeonMainView:OnViewHide(logicParams)
    local npcModelList = self.mNpcModelList;
    for i,v in ipairs(npcModelList) do
        v:HideView();
    end
end

function EndlessDungeonMainView:Dispose()
    local npcModelList = self.mNpcModelList;
    for i,v in ipairs(npcModelList) do
        v:Dispose();
    end
    self.mNpcModelList = nil;
end

return EndlessDungeonMainView;