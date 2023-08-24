local mBaseView = require "Core/BaseView"
local mLuaClass = require "Core/LuaClass"
local CombatActorInfoView = mLuaClass("CombatActorInfoView",mBaseView);
local mGameTimer = require "Core/Timer/GameTimer"
local ExtraAttribute = require"Battle/Attribute/ExtraAttribute"
local Time = UnityEngine.Time;
function CombatActorInfoView:InitViewParam()
	return {
		["viewPath"] = "ui/combat/",
		["viewName"] = "combat_actor_info_view",
		["ParentLayer"] = mBattleLayer,
	};
end
function  CombatActorInfoView:Init()

	self.mTextName = self:FindComponent("info_view/name","Text");
	self.mTextInfo = self:FindComponent("info_view/desc","Text");
	self:FindAndAddClickListener("Close",function() self:HideView() end);

	local inputFields = {}
	for i = 1,8 do
		inputFields[i] = self:FindComponent(string.format("settings/items/SetAttribute (%d)/InputField/Text",i),"Text");
		self:FindAndAddClickListener(string.format("settings/items/SetAttribute (%d)/Button",i),function() self:AddAttribute(i,self:GetTextValue(i)); end);
	end
	self.mInputFields = inputFields;

end

local mIncreaseText = "<color=#00ff00>( + %d)</color>";
local mDecreaseText = "<color=#ff0000>(  %d)</color>";
local mBaseText = " = %d %s\n";
local mGreenText = "<color=#00ff00>%s = %d</color>\n";
local mRedText = "<color=#ff0000>[属性 %s] = %s(是否配出属性ID?)</color>\n";

local function GetExtraText(value)
	if value == 0 then
		return "";
	end
	if value > 0 then
		return string.format(mIncreaseText,value);
	end

	return string.format(mDecreaseText,value);
end

local mGetAttributeTexts = 
{
	[1] = function (v,extraValue) return string.format("生命上限"..mBaseText,v,GetExtraText(extraValue)) end;
	[2] = function (v,extraValue) return string.format("攻击"..mBaseText,v,GetExtraText(extraValue)) end;
	[3] = function (v,extraValue) return string.format("防御"..mBaseText,v,GetExtraText(extraValue)) end;
	[4] = function (v,extraValue) return string.format("暴击率"..mBaseText,v*100,GetExtraText(extraValue*100)) end;
	[5] = function (v,extraValue) return string.format("暴击伤害"..mBaseText,v*100,GetExtraText(extraValue*100)) end;
	[6] = function (v,extraValue) return string.format("效果命中"..mBaseText,v*100,GetExtraText(extraValue*100)) end;
	[7] = function (v,extraValue) return string.format("效果抵抗"..mBaseText,v*100,GetExtraText(extraValue*100)) end;
	[8] = function (v,extraValue) return string.format("攻速"..mBaseText,v,GetExtraText(extraValue)) end;

	[9] = function (v,extraValue) return "" end;
	[10] = function (v,extraValue) return "" end;
	[11] = function (v,extraValue) return "" end;

	[20101] = function (v,extraValue) return string.format("治愈效果"..mBaseText,v*100,GetExtraText(extraValue*100)) end;
	[20102] = function (v,extraValue) return string.format("反伤"..mBaseText,v*100,GetExtraText(extraValue*100)) end;
	[20103] = function (v,extraValue) return string.format("减伤"..mBaseText,v*100,GetExtraText(extraValue*100)) end;
	[20106] = function (v,extraValue) return string.format("暴击抵抗"..mBaseText,v*100,GetExtraText(extraValue*100)) end;
	[20105] = function (v,extraValue) return string.format("精准"..mBaseText,v*100,GetExtraText(extraValue*100)) end;

	[10100] = function (v,extraValue) return "" end;
	[20100] = function (v,extraValue) return string.format(mGreenText,"当前生命",v+extraValue) end;
}


function CombatActorInfoView:GetInfo(actor)

	local info = "";
	local attributes = actor:FindAndAddComponent("AttributeSystem").mAttributes;
	for k,v in pairs(attributes) do
		local func = mGetAttributeTexts[k];
		local baseValue = actor:GetBaseAttribute(k);
		if func then
			info = info..func(baseValue,v-baseValue);
		elseif type(k) == number then
			info = info..string.format(mRedText,k,v);
		end
	end

	return info;
end

function CombatActorInfoView:OnViewShow(actor)
	self.mTextInfo.text = self:GetInfo(actor);
	self.mTextName.text = actor.mName;
	self.mActor = actor;
	self.mCombat.mPlayerController.mDisable = true;
end

function CombatActorInfoView:OnViewHide()
	self.mCombat.mPlayerController.mDisable = nil;
end

function CombatActorInfoView:GetTextValue(index)
	return tonumber(self.mInputFields[index].text) or 0;
end

function CombatActorInfoView:GetExtraAttribute(actor,valueType)

	local extraAttributes = self.mExtraAttributes;
	if not extraAttributes then
		extraAttributes = {};
		self.mExtraAttributes = extraAttributes;
	end

	local actorExtraAttributes = extraAttributes[actor];
	if not actorExtraAttributes then
		actorExtraAttributes = {};
		extraAttributes[actor] = actorExtraAttributes;
	end

	local extraAttribute = actorExtraAttributes[valueType];
	if not extraAttribute then
		extraAttribute = ExtraAttribute.LuaNew(10102,valueType,value);
		actorExtraAttributes[valueType] = extraAttribute;
	end

	return extraAttribute;
end

function CombatActorInfoView:AddAttribute(valueType,value)
	local actor = self.mActor;
	if actor then
		local extraAttribute = self:GetExtraAttribute(actor,valueType);
		if value < 0 then
			extraAttribute.mValue = -value;
			extraAttribute.mBlendType = 20102;
			extraAttribute:SetPlusOrMinus(2);
		else
			extraAttribute.mValue = value;
			extraAttribute.mBlendType = 10102;
			extraAttribute:SetPlusOrMinus(1);
		end
		actor:FindAndAddComponent("AttributeSystem"):AddExtraAttribute(extraAttribute);
		self.mTextInfo.text = self:GetInfo(actor);
	end
end

function CombatActorInfoView:Dispose()
	self.mExtraAttributes = nil;
end

return CombatActorInfoView;