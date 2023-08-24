local mLuaClass = require "Core/LuaClass"
local mBaseWindow = require "Core/BaseWindow"
local mViewBgEnum = require "Enum/ViewBgEnum"
local mSortTable = require "Common/SortTable"
local mFaceVO = require "Module/Chat/FaceVO"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mVector2 = Vector2
local mLayoutController = require "Core/Layout/LayoutController"
local FaceView = mLuaClass("FaceView", mBaseWindow);

function FaceView.Show(isPrivate)
	mUIManager:HandleUI(mViewEnum.FaceView, 1,isPrivate);
end

function FaceView:InitViewParam()
	return {
		["viewPath"] = "ui/chat/",
		["viewName"] = "face_view",
		["ParentLayer"] = mCommonChatLayer,
		["viewBgEnum"] = mViewBgEnum.transparent_clickable,
	};
end

function FaceView:Init()
	local parent = self:Find("scrollView/Grid");
	self.mGridEx = mLayoutController.LuaNew(parent, require "Module/Chat/FaceItem");
	self.mDataSoure = mSortTable.LuaNew(nil,nil,true);
	for i = 1,54 do
		self.mDataSoure:AddOrUpdate(i,mFaceVO.LuaNew(i));
	end
	self.mGridEx:UpdateDataSource(self.mDataSoure);

	self.mBackTrans = self:FindComponent("BG","RectTransform");
	self.mScrollTrans = self:FindComponent("scrollView","RectTransform");
	self.mScrollGrid = self:FindComponent("scrollView/Grid","GridLayoutGroup");
end

function FaceView:OnViewShow(logicParams)
	if logicParams then
		self.mBackTrans.sizeDelta = mVector2(475,172);
		self.mBackTrans.localPosition = mVector2(370,-216);
		self.mScrollTrans.sizeDelta = mVector2(472,165);
		self.mScrollTrans.localPosition = mVector2(370,-210);
		self.mScrollGrid.constraintCount = 8;
	else
		self.mBackTrans.sizeDelta = mVector2(730,172);
		self.mBackTrans.localPosition = mVector2(345,-216);
		self.mScrollTrans.sizeDelta = mVector2(720,165);
		self.mScrollTrans.localPosition = mVector2(342,-210);
		self.mScrollGrid.constraintCount = 12;
	end
end

function FaceView:Dispose()
end

return FaceView;