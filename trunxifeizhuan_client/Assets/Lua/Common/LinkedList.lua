local mLuaClass = require "Core/LuaClass"
local mBaseLua = require "Core/BaseLua"

local LinkedList = mLuaClass("LinkedList",mBaseLua);

function LinkedList:CheckNode(node)
	local nodeList = node.mLinkedList;
	if nodeList == nil then
		return 0;
	end

	if nodeList ~= self then
		error("node是其它LinkedList的结点");
		return 1;
	end

	return 2;
end

function LinkedList:Contains(node)
	if node == nil then
		return false;
	end

	return self:CheckNode(node) == 2;
end

function LinkedList:AddBefore(node,newNode)
	self:Remove(newNode);

	if self:CheckNode(node) ~= 2 then
		return;
	end

	SetNodeLink(newNode,self,node.mLinkedPrevNode,node);
end

function LinkedList:AddAfter(node,newNode)
	self:Remove(newNode);

	if self:CheckNode(node) ~= 2 then
		return;
	end

	SetNodeLink(newNode,self,node,node.mLinkedNextNode);
end

function LinkedList:AddFirst(node)
	if self:CheckNode(node) == 2 then
		self:Remove(node);
	end

	SetNodeLink(node,self,nil,self.mFirst);
end

function LinkedList:AddLast(node)
	if self:CheckNode(node) == 2 then
		self:Remove(node);
	end

	SetNodeLink(node,self,self.mLast,nil);
end

function LinkedList:RemoveFirst()
	local firstNode = self.mFirst;
	self:Remove(firstNode);

	return firstNode;
end

function LinkedList:RemoveLast()
	local lastNode = self.mLast;
	self:Remove(lastNode);

	return lastNode;
end

function LinkedList:Remove(node)
	if node == nil then
		return;
	end

	if self:CheckNode(node) ~= 2 then
		return;
	end

	local prevNode = node.mLinkedPrevNode;
	local nextNode = node.mLinkedNextNode;

	if prevNode then
		prevNode.mLinkedNextNode = nextNode;
	end

	if nextNode then
		nextNode.mLinkedPrevNode = prevNode;
	end

	if node == self.mFirst then
		self.mFirst = nextNode;
	end

	if node == self.mLast then
		self.mLast = prevNode;
	end

	SetNodeLink(node,nil,nil,nil);
end

function SetNodeLink(node,linkedList,prevNode,nextNode)
	if node == nil then
		return;
	end

	node.mLinkedPrevNode = prevNode;
	node.mLinkedNextNode = nextNode;
	node.mLinkedList = linkedList;

	if linkedList ~= nil then
		if prevNode == nil then
			linkedList.mFirst = node;
		else
			prevNode.mLinkedNextNode = node;
		end

		if nextNode == nil then
			linkedList.mLast = node;
		else
			nextNode.mLinkedPrevNode = node;
		end
	end
end

return LinkedList;