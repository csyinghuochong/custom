require "Test/TableUtil"
local mLinkedList = require "Common/LinkedList"

function TestLinkedList( )
	local list = mLinkedList.LuaNew();

	local t1 = {1};
	local t5 = {5};
	local t6 = {6};
	local t7 = {7};

	list:AddFirst({2});
	list:AddFirst(t1);
	list:AddLast(t6);
	list:AddLast({4});
	list:AddFirst({0});
	list:AddBefore(t1,t5);
	list:AddAfter(t6,{9});
	list:Remove(t1);

	local first = list.mFirst;
	while first do
		local prev = first.mLinkedPrevNode;
		local n = first.mLinkedNextNode;

		if prev then
			print("prev:",prev[1]);
		else
			print("prev:",nil);
		end

		print("-----------------value:",first[1]);

		if n then
			print("next:",n[1]);
		else
			print("next:",nil);
		end

		first = first.mLinkedNextNode;
	end
end

TestLinkedList();