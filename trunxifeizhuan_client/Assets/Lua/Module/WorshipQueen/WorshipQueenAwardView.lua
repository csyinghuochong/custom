local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mCommonGoodItemView = require "Module/CommonUI/CommonGoodsItemView"
local mGameLuaInterface = GameLuaInterface;
local mVector3 = Vector3
local mVector2 = Vector2
local mCommonGoodsVO = require "Module/CommonUI/CommonGoodsVO"
local WorshipQueenAwardView = mLuaClass("WorshipQueenAwardView", mBaseWindow);
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mSuper = nil;

function WorshipQueenAwardView.Show(param,callBack,posX,posY)
	local Data = {data = param,CallBack = callBack,x=posX,y=posY};
	mUIManager:HandleUI(mViewEnum.WorshipQueenAwardView, 1, Data);
end

function WorshipQueenAwardView:InitViewParam()
	return {
		["viewPath"] = "ui/worship_queen/",
		["viewName"] = "worship_queen_award_view",
		["ParentLayer"] = mPopLayer,
		["ForbitSound"] = true
	};
end

function WorshipQueenAwardView:Init()
	self.mTransItem = self:Find("item");
	self.mItem = mCommonGoodItemView.LuaNew(self.mTransItem.gameObject);
	self:FindAndAddClickListener("Back", function() self:OnClickBack() end);
end

function WorshipQueenAwardView:OnClickBack()
	if self.mIsPlaying then
		return;
	end
	self:HideView();
	local callBack = self.mCallBack;
	if callBack ~= nil then
		callBack();
	end
end

function WorshipQueenAwardView:OnViewShow(Data)
	if Data ~= nil then
		local data = mCommonGoodsVO.LuaNew(Data.data.id,Data.data.num,nil,false);
		self.mItem:ExternalUpdate(data);
		self.mIsPlaying = true;
		mGameLuaInterface.DOScale(self.mTransItem,mVector3(1.4,1.4,1.4),0.3, function()
			mGameLuaInterface.DOScale(self.mTransItem,mVector3.one,0.3, function()
				self.mIsPlaying = false;
			end)
		end)
		self.mCallBack = Data.CallBack;
		local posX = Data.x;
		local posY = Data.y;
		if posX ~= nil and posY ~= nil then
			self.mTransItem.localPosition = mVector2(posX,posY);
		else
			self.mTransItem.localPosition = mVector2.zero;
		end
	end
	mSuper = self:GetSuper(mBaseWindow.LuaClassName);
	mSuper.OnViewShow(self,Data);
end

function WorshipQueenAwardView:Dispose()
end

return WorshipQueenAwardView;