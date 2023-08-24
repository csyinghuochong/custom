local mLuaClass = require "Core/LuaClass"
local mBaseController = require "Core/BaseController"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mEventEnum = require "Enum/EventEnum"
local mGameModelManager = require "Manager/GameModelManager"
local DraftController = mLuaClass("DraftController",mBaseController);

function DraftController:AddNetListeners()
    self.mS2C:DRAFT_REQUEST(function (pbDraftResult)
        local draftType = pbDraftResult.type and pbDraftResult.type or 0;
        --print(pbDraftResult.partner_id[1]);
        local params = {mId = pbDraftResult.partner_id[1],mType = draftType};
        mUIManager:HandleUI(mViewEnum.DraftSuccessView,1,params);
    end)
    self.mS2C:DRAFT_WITH_CHIP(function (pbDraftResult)
    	local draftType = pbDraftResult.type and pbDraftResult.type or 0;
        local params = {mId = pbDraftResult.partner_id[1],mType = draftType};
        mUIManager:HandleUI(mViewEnum.DraftSuccessView,1,params);
    end)
    self.mS2C:DRAFT_GROUP_LIST(function (pbDraftGroup)
    	mGameModelManager.DraftModel:RecvSpecialDraftGroup(pbDraftGroup);
        self:Dispatch(mEventEnum.ON_GET_SPECIAL_GROUP);
    end)
    self.mS2C:DRAFT_SHOW_LIST(function (pbDraftShow)
        mGameModelManager.ArchiveModel:RecvDraftShowList(pbDraftShow);
    end)
end

function DraftController:AddEventListeners()
   
end

function DraftController:SendDraft(draftType)
	self.mC2S:DRAFT_REQUEST(draftType,true);
end

function DraftController:SendChipDrfat(chipId)
	self.mC2S:DRAFT_WITH_CHIP(chipId);
end

function DraftController:SendGetDraftGroup()
	self.mC2S:DRAFT_GROUP_LIST(true);
end

function DraftController:SendGetDraftShowList()
    self.mC2S:DRAFT_SHOW_LIST(true);
end

function DraftController:OpenSpecialListView()
    mUIManager:HandleUI(mViewEnum.DraftSpecialListView,1);
end

return DraftController.LuaNew();