local mLuaClass = require "Core/LuaClass"
local mLayoutItem = require "Core/Layout/LayoutItem"
 local mGameObjectUtil = require "Utils/GameObjectUtil"
local FollowerController = require "Module/Follower/FollowerController"
local FollowerCommentItem = mLuaClass("FollowerCommentItem",mLayoutItem);
local mSuper = nil;
local mVector2 = Vector2;

function FollowerCommentItem:InitViewParam()
	return {
		["viewPath"] = "ui/follower/",
		["viewName"] = "follower_comment_item",
	};
end

function FollowerCommentItem:Init( )
	self.mRectTransForm = self.mGameObject:GetComponent('RectTransform');
	self.mBgTransform = self:FindComponent('Image_bg', 'RectTransform');
	self.mNameTransform = self:FindComponent('Image_bg/Button_name', 'RectTransform')
	self.mImageRank = self:FindComponent('Image_bg/Image_rank', 'Image');
	self.mTextName = self:FindComponent('Image_bg/Text_name', 'Text');
	self.mTextContent = self:FindComponent('Image_bg/Text_content', 'Text');
	self.mTextPraise = self:FindComponent('Image_bg/Text_praise', 'Text');

	self:FindAndAddClickListener("Image_bg/Button_name",function() self:OnClickName() end, nil, 1);
	self:FindAndAddClickListener("Image_bg/Button_praise",function() self:OnClickPraise() end, nil, 1);

	mSuper = self:GetSuper(mLayoutItem.LuaClassName);
	mSuper.Init(self);
end

function FollowerCommentItem:OnViewShow( )
	
end

function FollowerCommentItem:OnUpdateData()
	local data = self.mData;
	local vo = self.mData.mPbVO;

	local gameImage = self.mImageRank;
	if data.mIndex < 4 then
		gameImage.gameObject:SetActive(true);
		self.mGameObjectUtil:SetImageSprite(gameImage,"ranking_icon_"..data.mIndex);
	else
		gameImage.gameObject:SetActive(false);
	end

	self.mTextName.text = vo.name;
	self.mTextContent.text = vo.content;
	self.mTextPraise.text = data:GetPraiseNumber();

	--local contentHeight = self.mTextContent.preferredHeight;
	self.mRectTransForm.sizeDelta = mVector2(825, 105 );
	local textWidth = self.mTextName.preferredWidth;
	self.mNameTransform.sizeDelta = mVector2(textWidth, vo.state == 1 and 30 or 0, 0);
end

function FollowerCommentItem:AttachMoreComment( moreComment )
	self.mRectTransForm.sizeDelta = mVector2(825, 155 );

	mGameObjectUtil:SetParent(moreComment, self.mTransform);
	moreComment.localPosition = mVector2(0, 85);
end

function FollowerCommentItem:OnRecvCommentPraise(  )
	self.mData.mPbVO.vote_flag = 1;
	local number = tonumber(self.mTextPraise.text);
	self.mTextPraise.text =  number + 1;
end

function FollowerCommentItem:OnClickName( )
	self:Dispatch(self.mEventEnum.ON_CLICK_COMMENT_ITEM,self.mData);
end

function FollowerCommentItem:OnClickPraise( )
	local vo = self.mData.mPbVO;
	if vo.vote_flag == 0 then
		FollowerController:SendCommentPraise(vo.id);
	end
end

return FollowerCommentItem;