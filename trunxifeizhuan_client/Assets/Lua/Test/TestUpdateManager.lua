require "Test/TableUtil"
local mUpdateManager = require "Manager/UpdateManager"

function TestUpdateManager()
	local obj = {OnUpdate = function ( ... )
		print("OnUpdate");
	end,OnFixedUpdate = function ( ... )
		print("OnFixedUpdate");
	end,OnLateUpdate = function ( ... )
		print("OnLateUpdate");
	end}

	mUpdateManager:AddFixedUpdate(obj);
	--mUpdateManager:RemoveFixedUpdate(obj);
end

TestUpdateManager();