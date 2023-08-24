local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"
local mAndroidJavaClassUtil = AndroidJavaClassUtil;
local mIOSUtil = IOSUtil;
local Application = UnityEngine.Application;
local RuntimePlatform = UnityEngine.RuntimePlatform;
local PushManager = mLuaClass("PushManager",mBaseLua);

function PushManager:OnLuaNew()

end

function PushManager:ClearLocalNotification()
	if Application.platform == RuntimePlatform.Android then
		mAndroidJavaClassUtil.ClearLocalNotification();
	else
		mIOSUtil.ClearLocalNotification();
	end
end

function PushManager:AddLocalNotificationAndroid(content,date,hour,minute)
	--print(content,date,hour,minute)
	mAndroidJavaClassUtil.AddLocalNotification(content, date, hour, minute,1,"娴妃传");
end

function PushManager:AddLocalNotificationIos(content,second)
	mIOSUtil.AddLocalNotification(content,second);
end

function PushManager:TestPush()
	self:ClearLocalNotification();

	if Application.platform == RuntimePlatform.Android then
		local time = os.time() + 60;
		self:AddLocalNotificationAndroid("测试",os.date("%Y%m%d",time),os.date("%H",time),os.date("%M",time));
	else
		self:AddLocalNotificationIos("测试",60);
	end
end

return PushManager.LuaNew();