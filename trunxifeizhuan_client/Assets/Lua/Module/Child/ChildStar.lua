local mLuaClass = require "Core/LuaClass"
local mBaseView = require "Core/BaseView"
local ChildStar = mLuaClass("ChildStar",mBaseView);
local MAX_STAR = 20;

function ChildStar:Init()
	local goList = {};
	local imgList = {};
	for i=1,5 do
		local star = self:Find(tostring(i)).gameObject;
		local img = self:FindComponent(tostring(i),"GameImage");
		goList[i] = star;
		imgList[i] = img;
	end
	self.mGoList = goList;
	self.mImgList = imgList;
end

function ChildStar:SetInfo(level)
	if level > MAX_STAR then
		level = MAX_STAR;
	end
	if level ~= nil then
		local goList =self.mGoList;
		local imgList = self.mImgList;
		if level < 5 then
			for i=1,5 do
				goList[i]:SetActive(i <= level); 
				imgList[i]:SetSprite("children_star1");
			end
		else
			for i=1,5 do
				goList[i]:SetActive(true); 
				local color;
				local stage,stage2 = math.modf(level/5);
				local residue = level%5;
				if residue >= i then
					color = stage + 1;
				else
					color = stage;
				end
				imgList[i]:SetSprite("children_star"..color);
			end
		end
	end
end

return ChildStar;