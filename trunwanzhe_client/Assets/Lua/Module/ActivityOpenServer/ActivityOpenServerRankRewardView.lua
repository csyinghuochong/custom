local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local SysSoundConst = Assets.Scripts.Com.Game.Config.SysSoundConst;
local mSpecialButton = Assets.Scripts.Com.Game.Mono.UI.SpecialButton;
local MainSceneControl = Com.Game.Manager.CSharpToLuaInterface.GetMainSceneControl();
local mActivityOpenServerVO = require "Module/ActivityOpenServer/ActivityOpenServerVO";
local mActivityOpenServerType = require "Module/ActivityOpenServer/ActivityOpenServerType"
local mActivityOpenServerModel = require 'Module/ActivityOpenServer/ActivityOpenServerModel';
local mCommonGoodsItem = Assets.Scripts.Com.Game.Module.CommonComponent.CommonGoodsItem;
local ActivityOpenServerRankRewardView = mLuaClass("ActivityOpenServerRankRewardView",mBaseView);
local UIManager = Com.Game.Manager.CSharpToLuaInterface.GetUIManager();
local mString = require 'string'
local mMath = require 'math'
local mVector3 = Vector3;

function ActivityOpenServerRankRewardView:InitViewParam()
	return {
		["viewPath"] = "UI/Activity/ActivityOpenServerRankRewardView",
		["viewName"] = "ActivityOpenServerRankRewardView",
		["ParentLayer"] = UIManager.mNormalLayer1.transform,
	};
end

local mRankRewardNumber = 2;
local mRankPlayerNumber = 3;
local mExtraRewardNumber = 4;
function ActivityOpenServerRankRewardView:Init()
    local text_btn = self:FindComponent('get_btn/Label', 'UILabel');
	local btn_get = mSpecialButton.New(self:FindComponent('get_btn', 'UISprite'), text_btn);
	CSharpInterface.GameUIEventListenerGet(btn_get.gameObject,function ()
		self:OnClickGetReward();
	end,SysSoundConst.S_UI_OKBUTTON_BGM);
	self.mButtonGet = btn_get;
    self.mTextButton = text_btn;
	self.mTextCondition = self:FindComponent("extra/txt_1", 'UILabel');
    self.mTextCondition2 = self:FindComponent("extra/txt_2", 'UILabel');

    local name_list = {};
    for i = 1, mRankPlayerNumber  do
    	local path = mString.format('player%d/txt_name', i - 1);
        label_name= self:FindComponent(path, 'UILabel');
        name_list[i] = label_name;
 		CSharpInterface.GameUIEventListenerGet(label_name.gameObject, function ()
			self:OnClickName(i);
		end, SysSoundConst.S_UI_OKBUTTON_BGM);
    end
    self.mTextNameList = name_list;

    local welfare_rewards = {};
    for i = 1, mExtraRewardNumber do
    	local path = mString.format('extra/item%d', i - 1);
    	local goods_item = mCommonGoodsItem.New();
    	goods_item:InjectGameObject(self:FindChild(path));
    	welfare_rewards[i] = goods_item;
    end
    self.mWelfareRewardList = welfare_rewards;

    local rank_rewards = {};
    for i = 1, mExtraRewardNumber do
    	local path = mString.format('rank/item%d', i - 1);
    	local goods_item = mCommonGoodsItem.New();
    	goods_item:InjectGameObject(self:FindChild(path));
    	rank_rewards[i] = goods_item;
    end
    self.mRankRewardList = rank_rewards;

    local rank_rewards_dic = {};
    for i = 1, mRankPlayerNumber do
    	local goods_list = {};
    	for k = 1, mRankRewardNumber  do
    		local path = mString.format('player%d/item%d', i - 1, k - 1);
	    	local goods_item = mCommonGoodsItem.New();
	    	goods_item:InjectGameObject(self:FindChild(path));
	    	goods_list[k] = goods_item;
    	end 
    	rank_rewards_dic[i] = goods_list;
    end
    self.mRankRewardDic = rank_rewards_dic;

    local Activity_to_billboard = {};
    Activity_to_billboard[mActivityOpenServerType.DUNGRON_RANK] = 3;
    Activity_to_billboard[mActivityOpenServerType.COMBAT_RANK] = 1;
    Activity_to_billboard[mActivityOpenServerType.ARENA_RANK] = 6;
    self.mTypeDic = Activity_to_billboard;
    self.mIndex = mActivityOpenServerType.DUNGRON_RANK;
end

function ActivityOpenServerRankRewardView:OnClickName(index)
	local current_players = self.mCurrentList;
	if current_players ~= nil and current_players[index - 1] ~= nil then
		MainSceneControl:SendLookOtherPlayerInfo(current_players[index - 1].player_id, 0);
	end
end

function ActivityOpenServerRankRewardView:OnClickGetReward()
    local mActivityOpenServerController = require "Module/ActivityOpenServer/ActivityOpenServerController"
    mActivityOpenServerController:SendGetActiveOpenServerReward(self.mIndex);
end

function ActivityOpenServerRankRewardView:SetData(index)
	self.mIndex = index;
end

function ActivityOpenServerRankRewardView:GetRoleModel()
    return CSharpInterface.GetRoleModel();
end

function ActivityOpenServerRankRewardView:GetBillboardModel()
    return CSharpInterface.GetBillboardModel();
end

function ActivityOpenServerRankRewardView:GetBillboardControl()
    return CSharpInterface.GetBillboardControl();
end

function ActivityOpenServerRankRewardView:FreshUI()
   self:ShowRewardInfo();
   self:UpdateButton();

   local bill_type = self.mTypeDic[self.mIndex];
   local role_model = self:GetRoleModel();
   local bill_model = self:GetBillboardModel();
   if  not bill_model:CheckAllRankingOpen() 
    or not bill_model:CheckRankingOpenByType(bill_type)
    or bill_model:CheckRankingList(bill_type) then
        self:ChangeRanking(bill_type);
    else
        self:GetBillboardControl():SendGetRankingMsg(bill_type);
   end
end

function ActivityOpenServerRankRewardView:OnViewShow()
	self:FreshUI();
    self:GetBillboardModel().mActivityUpdateRankingCallback = function(index) self:ChangeRanking(index) end;
end

function ActivityOpenServerRankRewardView:OnViewHide()
    self:GetBillboardModel().mActivityUpdateRankingCallback = nil;
end

function ActivityOpenServerRankRewardView:ChangeRanking(index)
    local rank_list = self:GetBillboardModel():GetRankingList(index);
    local name_list = self.mTextNameList;
    self.mCurrentList = rank_list;

    for i = 1, mRankPlayerNumber do
        local name = name_list[i];
        if rank_list ~= nil and rank_list[i - 1] ~= nil then
            name.text = rank_list[i - 1].name;
        else
            name.text = "虚位以待";
        end
    end
end

function ActivityOpenServerRankRewardView:ShowRewardInfo()
    self:ShowReward();
    self:ShowCondition();
end

function ActivityOpenServerRankRewardView:ShowReward()
    local mType = self.mIndex;
    local goods_list = nil;
    for k, v in pairs(self.mRankRewardDic) do
        goods_list = mActivityOpenServerVO:GetRankRewardList(k, mType);
        local vo_number = table.getn(goods_list);
        local item_number = table.getn(v);
        for i = 1, item_number do
            local item = v[i];
            if i <= vo_number then
                item:ShowView();
                item:SetData(goods_list[i]);
            else
                item:HideView();
            end
        end
    end

    goods_list = mActivityOpenServerVO:GetRankRewardList(4, mType);
    local rand_rewards = self.mRankRewardList;
    for i = 1, mExtraRewardNumber do
        local item = rand_rewards[i];
        if i <= mExtraRewardNumber then
            item:ShowView();
            item:SetData(goods_list[i]);
        else
            item:HideView();
        end
    end

    goods_list = mActivityOpenServerVO:GetWelfareReward(mType);
    local welfare_rewards = self.mWelfareRewardList;
    for i = 1, mExtraRewardNumber do
        local item = welfare_rewards[i];
        if i <= mExtraRewardNumber then
            item:ShowView();
            item:SetData(goods_list[i]);
        else
            item:HideView();
        end
    end
end

function ActivityOpenServerRankRewardView:ShowCondition()
    local condition =  mActivityOpenServerVO:GetWelfareCondition(self.mIndex);
    local text_conditon = self.mTextCondition;
    local text_conditon2 = self.mTextCondition2;
    text_conditon.text = condition[1];
    text_conditon2.text = condition[2];
    local total_length = text_conditon.width + text_conditon2.width;
    text_conditon.transform.localPosition = mVector3.New(200 - mMath.ceil(total_length / 2) + mMath.ceil(text_conditon.width / 2), 20, 0);
    text_conditon2.transform.localPosition = mVector3.New(200 + mMath.ceil(total_length / 2) - mMath.ceil(text_conditon2.width / 2), 20, 0);
end

function ActivityOpenServerRankRewardView:UpdateButton()
    local mType = self.mIndex;
    self.mButtonGet.isEnabled = mActivityOpenServerModel:CheckActivityOpenServerNotitfyByType(mType);
    self.mTextButton.text = mActivityOpenServerModel:CheckActivityOpenServerRewardIsGet(mType) and "已领取" or "领取";
end

return ActivityOpenServerRankRewardView;