lua代码规范：

----------1.引用的对象加local修饰为本地变量，变量名前面加m作为前缀,采取驼峰式命名,除了require外，代码后面加上分号;
local mLuaClass = require "Core/LuaClass"               
local mUnityEngineGameObject = UnityEngine.GameObject;  
local mVector3 = Vector3;
local TestClass = mLuaClass("EventDispatcherInterface");



----------2.1.这种方式效率极低，每一步都需要在self查找mGameObject，然后再通过GameObject获取transform
function TestClass:SetParent(parent)                    
	self.mGameObject.transform.parent = parent;
	self.mGameObject.transform.localScale = mVector3.one;
	self.mGameObject.transform.localPosition = mVector3.zero;
end

----------2.2.这种方式是正确的，把需要频繁操作的对象transform使用局部变量缓存起来，后续的操作都是直接引用局部变量
function TestClass:SetParent2(parent)                   
	local transform = self.mGameObject.transform;       
	transform.parent = parent;
	transform.localScale = mVector3.one;
	transform.localPosition = mVector3.zero;
end

-----------3.1这种情况跟2.1类似，第一步都要从self里面查找到mTransform
function TestClass:SetParent3(parent)
	if self.mTransform then
	   self.mTransform.parent = parent;
	   self.mTransform.localScale = mVector3.one;
	   self.mTransform.localPosition = mVector3.zero;
	end
end

----------3.2正确的方式是只要引用一个table里面的变量有超过两次以上（包括两次），就需要使用局部变量缓存起来
function TestClass:SetParent4(parent)
	local transform = self.mTransform;
	if transform then
	   transform.parent = parent;
	   transform.localScale = mVector3.one;
	   transform.localPosition = mVector3.zero;
	end
end
	