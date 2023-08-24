--阵型
local Vector3 = Vector3;
local mCombatPosition = {};
local mFormations = {{},{},{},{},{}};
local mLeftRotation = Vector3.New(0,90,10);
local mRightRotation = Vector3.New(0,-90,-10);

mFormations[1].mLeft = {
    {position = Vector3.New(-2.5,0,10),rotation = mLeftRotation,blood_scale = 0.65}
}

mFormations[1].mRight = {
    {position = Vector3.New(2.5,0,10),rotation = mRightRotation,blood_scale = 0.65}
}

mFormations[2].mLeft = {
    {position = Vector3.New(-2.5,0,11.5),rotation = mLeftRotation,blood_scale = 0.8},
    {position = Vector3.New(-2.9,0,7.5),rotation = mLeftRotation,blood_scale = 0.65}
}

mFormations[2].mRight = {
    {position = Vector3.New(2.5,0,11.5),rotation = mRightRotation,blood_scale = 0.8},
    {position = Vector3.New(2.9,0,7.5),rotation = mRightRotation,blood_scale = 0.65}
}

mFormations[3].mLeft = {
    {position = Vector3.New(-2.9,0,7.5),rotation = mLeftRotation,blood_scale = 0.55},
    {position = Vector3.New(-5,0,10),rotation = mLeftRotation,blood_scale = 0.65},
    {position = Vector3.New(-2.1,0,12.5),rotation = mLeftRotation,blood_scale = 0.8}
}

mFormations[3].mRight = {
    {position = Vector3.New(2.9,0,7.5),rotation = mRightRotation,blood_scale = 0.55},
    {position = Vector3.New(5,0,10),rotation = mRightRotation,blood_scale = 0.65},
    {position = Vector3.New(2.1,0,12.5),rotation = mRightRotation,blood_scale = 0.8}
}

mFormations[4].mLeft = {
    {position = Vector3.New(-2.5,0,10),rotation = mLeftRotation,blood_scale = 0.7},
    {position = Vector3.New(-2,0,13.2),rotation = mLeftRotation,blood_scale = 0.8},
    {position = Vector3.New(-2.9,0,6.6),rotation = mLeftRotation,blood_scale = 0.6},
    {position = Vector3.New(-5,0,10),rotation = mLeftRotation,blood_scale = 0.7}
}

mFormations[4].mRight = {
    {position = Vector3.New(2.5,0,10),rotation = mRightRotation,blood_scale = 0.7},
    {position = Vector3.New(2,0,13.2),rotation = mRightRotation,blood_scale = 0.8},
    {position = Vector3.New(2.9,0,6.6),rotation = mRightRotation,blood_scale = 0.6},
    {position = Vector3.New(5,0,10),rotation = mRightRotation,blood_scale = 0.7}
}

mFormations[5].mLeft = {
    {position = Vector3.New(-2.5,0,10),rotation = mLeftRotation,blood_scale = 0.7},
    {position = Vector3.New(-2,0,13.2),rotation = mLeftRotation,blood_scale = 0.8},
    {position = Vector3.New(-2.9,0,6.6),rotation = mLeftRotation,blood_scale = 0.55},
    {position = Vector3.New(-5,0,8.8),rotation = mLeftRotation,blood_scale = 0.65},
    {position = Vector3.New(-4.5,0,12.3),rotation = mLeftRotation,blood_scale = 0.8}
}

mFormations[5].mRight = {
    {position = Vector3.New(2.5,0,10),rotation = mRightRotation,blood_scale = 0.7},
    {position = Vector3.New(2,0,13.2),rotation = mRightRotation,blood_scale = 0.8},
    {position = Vector3.New(2.9,0,6.6),rotation = mRightRotation,blood_scale = 0.55},
    {position = Vector3.New(5,0,8.8),rotation = mRightRotation,blood_scale = 0.65},
    {position = Vector3.New(4.5,0,12.3),rotation = mRightRotation,blood_scale = 0.8}
}

mCombatPosition.mFormations = mFormations;
mCombatPosition.mBossIndices = {1,1,2,4,4,5};
mCombatPosition.mLeadIndices = {1,1,2,1,1,2};

mCombatPosition.mCenter = Vector3.New(0,0,10);
mCombatPosition.mTeamPositions = {
 [1] = Vector3.New(-3.5, 0, 10),
 [2] = Vector3.New(3.5, 0, 10)
}

return mCombatPosition;