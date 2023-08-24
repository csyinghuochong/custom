local mLuaClass = require "Core/LuaClass"
local mQueueWindow = require "Core/QueueWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mGameModelManager = require "Manager/GameModelManager"
local mChatController = require "Module/Chat/ChatController"
local mVector2 = Vector2
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mFaceView = require "Module/Chat/FaceView"
local mCommonTipsView = require "Module/CommonUI/CommonTipsView"
local mCommonTabView = require "Module/CommonUI/TabView/CommonTabView"
local mConfigSysglobal_value = require "ConfigFiles/ConfigSysglobal_value"
local mConfigGlobalConst = require "ConfigFiles/ConfigSysglobal_valueConst"
local mColor = Color
local mGlobalUtil = require "Utils/GlobalUtil"
local mChatColorTable = mGlobalUtil.ChatColorTable;
local mGameTimer = require "Core/Timer/GameTimer"
local mLayoutController = require "Core/Layout/LayoutController"
local ChatView = mLuaClass("ChatView", mQueueWindow);

local mLanguageUtil = require "Utils/LanguageUtil"
local mLgTime = mLanguageUtil.chat_time_less_3;
local mLgNoneSelectPlayer = mLanguageUtil.chat_none_select_player;

local CHAT_CD = mConfigSysglobal_value[mConfigGlobalConst.CHAT_CD];

local FEAST = "feast";

function ChatView:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "chat_view",
		["ParentLayer"] = mMainLayer,
		["viewBgEnum"] = mViewBgEnum.gray,
		["PlayAnimation"] = true,
		["AdditionalShaderChannels"] = true,
	};
end

function ChatView:Init()
	self.mLastSendTime = 0;
	self.mObjTab = self:Find('tabView');
	self.mGoBottom = self:Find('bottom');
	self.mInput = self:FindComponent('bottom/InputField','InputField');
	self.mRectTrance = self:FindComponent('bottom/InputField','RectTransform');
	self.mTextTrance = self:FindComponent('bottom/InputField/Text','RectTransform');
	self.mBackTrance = self:FindComponent('c_bg/bg11','RectTransform');
	self.mImgAlpha1 = self:FindComponent('c_bg/bg7','Image');
	self.mImgAlpha2 = self:FindComponent('c_bg/bg11','Image');
	self.mTextInput = self:FindComponent('bottom/InputField/Text','Text');
	self:FindAndAddClickListener("c_bg/Button_close",function() self:ClickClose(); end);
	self:FindAndAddClickListener("bottom/btnSend",function() self:SendMsg(); end,"ty_0203");
	self:FindAndAddClickListener("bottom/btnFace",function() self:OpenFace(); end);
	self:CreateScroll();
	self:InitData();
	self:InitSubView();
	self:CreateFlag();
	local mEvent = self.mEventEnum;
	self:RegisterEventListener(mEvent.ON_CHAT_TO_PLAYER,function(data) self:OnChatToPlayer(data);end,true);
	self:RegisterEventListener(mEvent.ON_CLICK_FACE,function(data) self:OnClickFace(data);end,true);
	self:RegisterEventListener(mEvent.ON_REFRESH_CHAT_FLAG,function(index) self:OnRefreshFlag(index);end,false);
	self:RegisterEventListener(mEvent.ON_CHAT_MAIN_SYSTEM_ADD,function(data) self:OnRefreshMainSystemHeight(data);end,false);
	self:RegisterEventListener(mEvent.ON_CHAT_CLICK_LINK,function(linkData) self:OnClickLink(linkData);end,false);
end

function ChatView:OnClickLink(linkData)
	if linkData ~= nil then
		if linkData.linkStr == FEAST then
			local id = tonumber(linkData.data.value[1]);
			local feast_id = linkData.data.feast_id;
			local MansionController = require "Module/Mansion/MansionController"
			if mGameModelManager.RoleModel:GetPlayerID() == id then
				self:OnClickHideView();
				MansionController:OnClickJoinFeast(id,  feast_id);
			end
		end
	end
end

function ChatView:OnRefreshMainSystemHeight(data)
	mGameTimer.SetTimeout(0.2,function()self:RefreshHeight()end);
end

function ChatView:CreateScroll()
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Chat/ChatSysItem");
	self.mRectTranceGrid = self:FindComponent("scrollView/Grid","RectTransform");
	local model = mGameModelManager.ChatModel;
	self.mGridEx:UpdateDataSource(model.mMainSystemDataSoure);
	self.mGoScroll = self:Find("scrollView").gameObject;
	self:RefreshHeight();
end

function ChatView:RefreshHeight()
	local height = self.mRectTranceGrid.sizeDelta.y;
	local vector2 = mVector2.New(790,height);
	local rectTranceScroll = self:Find("scrollView","RectTransform");
	rectTranceScroll.sizeDelta = vector2;
	local model = mGameModelManager.ChatModel;
	model.mMainSystemHeight = height;
	self:Dispatch(self.mEventEnum.ON_CHANGE_CHAT_SCROLL_POS_AND_HEIGHT);
end

function ChatView:OnRefreshFlag(index)
	self:ChangeFlag(index,true);
end

function ChatView:CreateFlag()
	local model = mGameModelManager.ChatModel;
	local flagTable = model.mFlags;
	for k,v in ipairs(flagTable) do
		self:ChangeFlag(k,v);
	end
end

function ChatView:ChangeFlag(index,state)
	self.mTabView:SetRedPointForIndex(index,state);
end

function ChatView:ClickClose()
	self:CheckPrivate();

	if self:GetViewCurParent() == mMainLayer then
		self:ReturnPrevQueueWindow();		
	else
		self:OnClickHideView();
	end
	
end

function ChatView:OnClickFace(data)
	local text = self.mInput.text;
	if data.id > 9 then
		self.mInput.text = text.."["..data.id.."]";
	else
		self.mInput.text = text.."[0"..data.id.."]";
	end
	local model = mGameModelManager.ChatModel;
	mUIManager:HandleUI(mViewEnum.FaceView, 0);
end

function ChatView:InitData()
	self.mChatModel = mGameModelManager.ChatModel;
end

function ChatView:InitSubView()
	local view_vo_list = {
		{luaClass="Module/Chat/ChatWorldView"},
		{luaClass="Module/Chat/ChatSysView"},
		{luaClass="Module/Chat/ChatFamilyView"},
		{luaClass="Module/Chat/ChatTeamView"},
		{luaClass="Module/Chat/ChatPrivateView"},	
	}

	local getDataBack = function()
		return self.mChatModel;
	end

	self.mTabView = mCommonTabView.LuaNew(self.mObjTab, view_vo_list, function(index)self:ChangeInput(index);end, getDataBack);
	self.mTabView:OnClickToggleButton(1, true);
end

function ChatView:ChangeInput(index)
	local model = mGameModelManager.ChatModel;
	model.mChannel = index;
	model.mFlags[index] = false;
	self:ChangeFlag(index,false);
	if index == 2 then
		self.mGoBottom.gameObject:SetActive(false);		
	else
		self.mGoBottom.gameObject:SetActive(true);
		if index == 5 then
			self.mRectTrance.sizeDelta = mVector2(323,42);
			self.mTextTrance.sizeDelta = mVector2(300,23);
		else
			self.mRectTrance.sizeDelta = mVector2(630,42);
			self.mTextTrance.sizeDelta = mVector2(610,23);
		end
	end
	self:CheckPrivate();
	self:SetBackSize(index);
	self.mTextInput.color = mChatColorTable[index];
	self:SetMainSystemState(index);
end

function ChatView:SetMainSystemState(index)
	if index == 2 or index == 5 then
		self.mGoScroll:SetActive(false);
	else
		self.mGoScroll:SetActive(true);
	end
end

function ChatView:SetBackSize(index)
	if index == 5 then
		self.mBackTrance.sizeDelta = mVector2(492,455);
	else
		self.mBackTrance.sizeDelta = mVector2(800,455);
	end
end

function ChatView:CheckPrivate()
	local model = self.mChatModel;
	if model.mIsEverGetPlayer then
		model:CheckDelete();
	end
end

function ChatView:OnChatToPlayer(data)
	local model = self.mChatModel;
	self.mTabView:OnClickToggleButton(5, true);
	if model.mIsEverGetPlayer then
		model:ChatToPlayer(data);
	else
		mGameTimer.SetTimeout(0.2,function()model:ChatToPlayer(data);end);
	end
	self.mRectTrance.sizeDelta = mVector2(323,42);
	self.mTextTrance.sizeDelta = mVector2(300,23);
end

function ChatView:SendMsg()
	local text = self.mInput.text;
	if text ~= "" then
		if self:CheckChatCD() then
			local model = mGameModelManager.ChatModel;
			if model.mChannel ~= 5 then
				mChatController:SendChat(model.mChannel,text,0);
			else
				if model.mSelectData ~= nil then
					mChatController:SendChat(model.mChannel,text,model.mSelectData.base.player_id);
				else
					mCommonTipsView.Show(mLgNoneSelectPlayer);
				end
			end
			self.mInput.text = "";
			self.mLastSendTime = mGameModelManager.LoginModel:GetCurrentTime();
		else
			mCommonTipsView.Show(mLgTime);
		end
	end
end

function ChatView:CheckChatCD()
	local currentTime = mGameModelManager.LoginModel:GetCurrentTime();
	if currentTime - self.mLastSendTime > CHAT_CD then
		return true;
	else
		return false;
	end
end

function ChatView:OpenFace()
	local model = mGameModelManager.ChatModel;
	mFaceView.Show(model.mChannel == 5);
end

function ChatView:OnViewShow(data)
	local color;
	local isAlpha = mGameModelManager.ChatModel.mIsOpenByBattle;
	if isAlpha then
		color = mColor.New(1,1,1,100/255);
	else
		color = mColor.New(1,1,1,1);
	end
	self.mImgAlpha1.color = color;
	self.mImgAlpha2.color = color;
	if data.isChatToFriend then
		self:OnChatToPlayer(data.param);
	end
	 self:OnRefreshMainSystemHeight(nil);
end

function ChatView:Dispose()
	self.mTabView:CloseView();
end

return ChatView;