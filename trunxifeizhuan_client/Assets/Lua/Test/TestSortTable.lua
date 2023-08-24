require "Test/TableUtil"
local mSortTable = require "Common/SortTable"

function TestSortTable( )
	local table = mSortTable.LuaNew(function(a,b ) return a.key < b.key end,"key");
	table:Init(function( ... )print("add",...);	end,function( ... )print("remove",...);end,function( ... )print("update",...);end,function( ... )print("refresh",...);end);

	table:AddOrUpdate(1,{key = 1,100});
	table:AddOrUpdate(3,{key = 3,60});
	table:AddOrUpdate(5,{key = 5,800});

	table:AddOrUpdate(1,{key = 1,99});

	table:AddOrUpdate(7,{key = 7,40});
	table:AddOrUpdate(9,{key = 9,5});

	table:RemoveKey(7);

	table:AddOrUpdate(10,{key = 10,10});
	table:AddOrUpdate(10,{key = 10,11});

	TableUtil.PrintTable(table.mSortTable);
end

TestSortTable();