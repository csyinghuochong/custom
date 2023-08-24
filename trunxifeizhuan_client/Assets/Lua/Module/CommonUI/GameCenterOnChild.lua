local mBaseLua = require "Core/BaseLua"
local mLuaClass = require "Core/LuaClass"
local mUpdateManager = require "Manager/UpdateManager"
local GameCenterOnChild = mLuaClass("GameCenterOnChild", mBaseLua);
local mGameUIEventListener = GameUIEventListener;

function GameCenterOnChild:OnLuaNew(go, onCenter)
    self.mGameObject = go;
	self.mTransform = go.transform;
    self.mOnCenterBack = onCenter;
    self.mCenterSpeed = 9;
    self:Init();
end

function GameCenterOnChild:Init(  )
	local scorllRect = self.mTransform:GetComponent('ScrollRect');
	local container = scorllRect.content;

	self.mRTContainer = container:GetComponent('RectTransform');
	self.mGrid = container:GetComponent('HorizontalLayoutGroup');
    self.mRTScrollView = scorllRect:GetComponent('RectTransform');
    self.mContainer = container;

    self:AddUIEventListener( );
end

function GameCenterOnChild:AddUIEventListener(  )
   local listener = mGameUIEventListener.Get(self.mGameObject);

    listener.onBeginDrag = function ()
        self.mStarPosX = self.mContainer.localPosition.x;
        mUpdateManager:RemoveUpdate(self);
    end

    listener.onEndDrag = function ()
        self.mTargetPos = self:FindClosestPos(self.mStarPosX, self.mContainer.localPosition.x);
        mUpdateManager:AddUpdate(self);
    end
end

function GameCenterOnChild:BeginLoad(  )
    self.mLoadComplete = false;
end

function GameCenterOnChild:EndLoad( number )
    self.mLoadComplete = true;

    self:InitChildPos( number );
end

function GameCenterOnChild:InitChildPos( number )
    --计算第一个子物体位于中心时的位置
    local container = self.mContainer;
    local gird_tran = container:GetChild(0);
    if gird_tran == nil then
        print('CenterOnChild: No Child on the ScrollRects content')
    end

    local cell_x = gird_tran:GetComponent('RectTransform').rect.width;
    local posList = {};
    local childPosX = 0;
    posList[1] = childPosX;

    local spacing = self.mGrid.spacing;
    for i = 1, container.childCount do
        childPosX = childPosX - ( cell_x + spacing );
        posList[i + 1] = childPosX;
    end
    self.mChildrenPos = posList;
end

function GameCenterOnChild:OnUpdate()
    local container = self.mContainer;
    local targePos = self.mTargetPos;

	local v = container.localPosition;
    v.x = Mathf.Lerp(container.localPosition.x, targePos, self.mCenterSpeed * Time.deltaTime);
    container.localPosition = v;
    if Mathf.Abs(container.localPosition.x - targePos) < 0.1 then
        container.localPosition = Vector3.New( targePos,  v.y, 0);
    	mUpdateManager:RemoveUpdate(self);
    end
end

function GameCenterOnChild:ShowView( )
    
end

function GameCenterOnChild:RemoveUpdate( )
    mUpdateManager:RemoveUpdate(self);
end

function GameCenterOnChild:MoveToNextPage()
    if self.mLoadComplete ~= true then
        return;
    end
    local positon = self.mContainer.localPosition.x;
    local offset = self.mRTScrollView.rect.width + self.mGrid.spacing;
    self.mTargetPos = self:FindClosestPos(positon, positon - offset);

    mUpdateManager:AddUpdate(self);
end

function GameCenterOnChild:MoveToPrevPage()
    if self.mLoadComplete ~= true then
        return;
    end
    local positon = self.mContainer.localPosition.x;
    local offset = self.mRTScrollView.rect.width + self.mGrid.spacing;
    self.mTargetPos = self:FindClosestPos(positon, positon + offset);

    mUpdateManager:AddUpdate(self);
end

function GameCenterOnChild:MoveToItemByIndex( index, tween )
    local targetPos = self.mChildrenPos[ index ];
    if tween then
        self.mTargetPos = targetPos;
        self.mEndDrag = true;
        mUpdateManager:AddUpdate(self);
    else
        local container = self.mContainer;
        local v_position = container.localPosition;
        container.localPosition = Vector3.New( targetPos,  v_position.y, 0);
    end 
    self:OnCenterOnBack( index );
end

function GameCenterOnChild:FindClosestPos(startPos, currentPos)
        local closest = 0;
        local childIndex = 0;
        local distance = Mathf.Infinity;
        local childPos = self.mChildrenPos;

        local width1 = self.mRTContainer.rect.width;
        local width2 = self.mRTScrollView.rect.width;
        local minLimit = width2 - width1;
        minLimit = math.min(minLimit, 0);
        if startPos < currentPos then
            for i = 1, #childPos do
                local p = childPos[i];

                if currentPos <= p and minLimit <= p  then
                    closest = p;
                    childIndex = i;
                end

                if childIndex == 0 and p == minLimit then
                    closest = childPos[1];
                    childIndex = 1;
                    break;
                end

            end
        else   
            for i = #childPos, 1, -1  do
                local p = childPos[i];
                if currentPos >= p and minLimit <= p then
                    closest = p;
                    childIndex = i;
                end

                if childIndex == 0 and p == minLimit then
                    closest = p;
                    childIndex = i;
                    break;
                end
            end
        end
        self:OnCenterOnBack( childIndex );
        return closest;
end

function GameCenterOnChild:OnCenterOnBack( childIndex )
    local centerOn = self.mOnCenterBack;
    if centerOn ~= nil then
        centerOn(  self.mContainer:GetChild(childIndex - 1) );
    end
end

function GameCenterOnChild:CorrectPositon( pos)
    local width1 = self.mRTContainer.rect.width;
    local width2 = self.mRTScrollView.rect.width;
    local offset = width2 - width1;
    if offset >= 0 then
     offset = 0;
    end
    pos = Mathf.Clamp(pos, offset, 0);
    return pos;
end

return GameCenterOnChild;