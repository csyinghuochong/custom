local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local CSharpInterface = Com.Game.Manager.CSharpToLuaInterface;
local ActivityItemBaseVO = mLuaClass("ActivityItemBaseVO", mBaseLua);

function ActivityItemBaseVO:OnLuaNew(id, activity_type)
    self.mID = id;
    self.mType = activity_type;
end

function ActivityItemBaseVO:GetRoleModel()
    return CSharpInterface.GetRoleModel();
end

function ActivityItemBaseVO:GetActivityModel( )
    local mActivityModel = self.mActivityModel;
    if mActivityModel == nil then
        mActivityModel = require "Module/Activity/ActivityModel";
        self.mActivityModel = mActivityModel;
    end
    return mActivityModel;
end

function ActivityItemBaseVO:IsGet()
    return self:GetActivityModel():GetGetState(self.mType, self.mID);
end

return ActivityItemBaseVO;