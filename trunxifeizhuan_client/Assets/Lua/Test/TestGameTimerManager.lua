require "Test/TableUtil"
local mGameTimerManager = require "Core/Timer/GameTimerManager"
local mGameTimer = require "Core/Timer/GameTimer"

function TestGameTimerManager()
	print("------beginTimeout:" , Time.realtimeSinceStartup);
	local t = nil;
	local timer = mGameTimer.SetInterval(1,function()
		print("------endTimeout", Time.realtimeSinceStartup);
		t:Dispose();
	end);
	t = timer;

	mGameTimer.SetFrameExecute(2,function( ... )
		print("SetFrameExecute");
	end,function( ... )
		print("SetFrameExecute complete");

		mGameTimer.SetTimeout(1,function( ... )
			print("timeout");
		end)

	end)

	mGameTimer.ExecuteTotalFrames(2,function( ... )
		print("ExecuteTotalFrames");
	end,function( ... )
		print("ExecuteTotalFrames complete");

		
	end)
end

TestGameTimerManager();