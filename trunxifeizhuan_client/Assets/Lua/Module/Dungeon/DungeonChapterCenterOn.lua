local mLuaClass = require "Core/LuaClass"
local mUpdateManager = require "Manager/UpdateManager"
local GameCenterOnChild = require "Module/CommonUI/GameCenterOnChild";
local DungeonChapterCenterOn = mLuaClass("DungeonChapterCenterOn", GameCenterOnChild);
local mGameUIEventListener = GameUIEventListener;
local mSuper = nil;

function DungeonChapterCenterOn:OnLuaNew(go, onCenter)
    mSuper = self:GetSuper(GameCenterOnChild.LuaClassName);
    mSuper.OnLuaNew(self, go, onCenter);
end

function DungeonChapterCenterOn:AddUIEventListener(  )
   local listener = mGameUIEventListener.Get(self.mGameObject);

    listener.onBeginDrag = function ()
    	self.mEndDrag  = false;
        self.mStarPosX = self.mContainer.localPosition.x;
        mUpdateManager:AddUpdate(self);
    end

    listener.onEndDrag = function ()
   		self.mEndDrag  = true;
        self.mTargetPos = self:FindClosestPos(self.mStarPosX, self.mContainer.localPosition.x);
        mUpdateManager:AddUpdate(self);
    end
end

function DungeonChapterCenterOn:InitChildPos( number )
    --计算第一个子物体位于中心时的位置
    local container = self.mContainer;
    local childCount = container.childCount;
    if childCount == 0 then
        return;
    end
    local posList = {};
    local childPosX = 0;
   	local cell_x = container:GetChild( 0 ):GetComponent('RectTransform').rect.width;
    local spacing = self.mGrid.spacing;
    for i = 1, number do
        childPosX = i == 1 and -88 or ( childPosX - ( cell_x + spacing ) );
        posList[i] = childPosX;
    end

    self.mChildrenPos = posList;
end

function DungeonChapterCenterOn:OnUpdate()
    
    if self.mEndDrag then
        mSuper.OnUpdate( self );
    end

    self:UpdateItemScale( );
end

function DungeonChapterCenterOn:UpdateItemScale(  )
	local container = self.mContainer;
    local v = container.localPosition;
	local v_x = v.x;
    for i = 1, container.childCount do
    	 local gird_tran = container:GetChild( i - 1 );
    	 local ads_dis   = Mathf.Abs(v_x + gird_tran.localPosition.x);
    	 local scale = ads_dis / 2000;
    	 scale = math.min( scale, 1 );
         scale = 1 - scale;
    	 gird_tran.localScale = Vector3.one * scale;
         --local rectTransform = gird_tran:GetComponent( 'RectTransform' );
         --rectTransform.sizeDelta = Vector2.New( 176 * scale, 575 * scale );
    end
    --container.gameObject:SetActive( false );
    --container.gameObject:SetActive( true  );
end

function DungeonChapterCenterOn:FindClosestPos(startPos, currentPos)
        local closest = 0;
        local childIndex = 0;
        local childPos = self.mChildrenPos;

        if startPos < currentPos then
            for i = 1, #childPos do
                local p = childPos[i];

                if currentPos <= p   then
                    closest = p;
                    childIndex = i;
                end

                if childIndex == 0  then
                    closest = childPos[1];
                    childIndex = 1;
                    break;
                end
            end
        else   
            for i = #childPos, 1, -1  do
                local p = childPos[i];
                if currentPos >= p  then
                    closest = p;
                    childIndex = i;
                end

                if childIndex == 0  then
                    closest = p;
                    childIndex = i;
                    break;
                end
            end
        end
        self:OnCenterOnBack( childIndex );
        return closest;
end

return DungeonChapterCenterOn;