local mLuaClass = require "Core/LuaClass"
local mBaseModel = require "Core/BaseModel"
local mSortTable = require "Common/SortTable"
local mUIManager = require "Manager/UIManager"
local mViewEnum = require "Enum/ViewEnum"
local mChildVO = require "Module/Child/ChildVO"
local ChildModel = mLuaClass("ChildModel",mBaseModel);

function ChildModel:OnLuaNew()
	self.mSelectData = nil;

	self.mDataSoureChild = mSortTable.LuaNew(nil,nil,true);
	for i=1,8 do
		local data = {id = i,child_id = i,star_level_exp = i*10,quality_exp = i*10,name = "子女"..i,quality = i%4 + 1,character = i%4 + 1,star_level = i};
		local childVO = mChildVO.LuaNew(data);
		self.mDataSoureChild:AddOrUpdate(i,childVO);
	end
end

return ChildModel;