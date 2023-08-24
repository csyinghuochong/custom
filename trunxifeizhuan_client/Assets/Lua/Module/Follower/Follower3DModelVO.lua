local mLuaClass = require "Core/LuaClass"
local Follower3DModelVO = mLuaClass("Follower3DModelVO");
local mGameModelManager = require "Manager/GameModelManager"
local Quaternion = Quaternion;
local mFaces = {
	{asset = "zj_nanxing_tou_01";position = 0;sex = 1};
	{asset = "zj_nvxing_tou_01";position = 0;sex = 2};
};

function Follower3DModelVO:GetFashions(fashions,sex)
	if not fashions then
		fashions = mGameModelManager.FashionModel:CreateDefaultSuit(sex);
	end
	return fashions;
end

function Follower3DModelVO:GetModelVO( model, lead, sex, location,fashions )
	local model3d = {};
	model3d.mFile = model;
	if location then
		model3d.mRotation = Quaternion.Euler(location.rotation.x, 0, location.rotation.z);
	end

	if lead then
		model3d.mFashions = self:GetFashions(fashions,sex);
		model3d.mFace = mFaces[sex];
		model3d.mSex = sex;
		model3d.mIsCombineModel = true;
	end

	return model3d;
end

function Follower3DModelVO:GetLeadModelVO( model,sex,fashions )
	local model3d = {};
	model3d.mFile = model;
	model3d.mFashions = self:GetFashions(fashions,sex);
	model3d.mFace = mFaces[sex];
	model3d.mSex = sex;
	model3d.mIsCombineModel = true;
	return model3d;
end

return Follower3DModelVO;