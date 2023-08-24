local Colors = 
{
    --white
     "<color=#888888>%s</color>",
    --green
     "<color=#4C9243>%s</color>",
    --bule
     "<color=#406290>%s</color>",
    --purple
     "<color=#A53B8E>%s</color>",
    --orange
     "<color=#A44F10>%s</color>",
    --yellow
     "<color=#B89817>%s</color>",
    --red
     "<color=#A11717>%s</color>",
}

local mColor = Color
local ColorWorld = mColor.New(230/255,121/255,15/255);
local ColorSystem = mColor.New(1,1,1);
local ColorFamily = mColor.New(58/255,134/255,79/255);
local ColorTeam = mColor.New(166/255,72/255,114/255);
local ColorPrivate = mColor.New(48/255,20/255,15/255);
local ChatColorTable = 
{
    ColorWorld,ColorSystem,ColorFamily,ColorTeam,ColorPrivate,
}

local t = {};
t["Colors"] = Colors;
t["ChatColorTable"] = ChatColorTable;
t["MaxLand"] = 12;
t['RobotMaxId'] = 1000000;
t['FollowerStar'] = 6;
return t;