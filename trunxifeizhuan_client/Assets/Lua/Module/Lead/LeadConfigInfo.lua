local mLeadConfigInfo = {};

local mActorIds = { 11001, 11002, 11003, 11004, 11005, 12001, 12002, 12003, 12004, 12005 };

local mLeadBaseConfig = {
		[mActorIds[1]] = { miniIcon = "role_10101", combatModel = "zj_nanxing_hq",   uiModel = "zj_nanxing" },
        [mActorIds[2]] = { miniIcon = "role_10102", combatModel = "zj_nanxing_wq",uiModel = "zj_nanxing" },
        [mActorIds[3]] = { miniIcon = "role_10103", combatModel = "zj_nanxing_qc",   uiModel = "zj_nanxing"},
        [mActorIds[4]] = { miniIcon = "role_10103", combatModel = "zj_nanxing_dg",   uiModel = "zj_nanxing"},
        [mActorIds[5]] = { miniIcon = "role_10103", combatModel = "zj_nanxing_xg",   uiModel = "zj_nanxing"},
        [mActorIds[6]] = { miniIcon = "role_10201", combatModel = "zj_nvxing_hq",    uiModel = "zj_nvxing"},
        [mActorIds[7]] = { miniIcon = "role_10201", combatModel = "zj_nvxing_wq", uiModel = "zj_nvxing" },
        [mActorIds[8]] = { miniIcon = "role_10202", combatModel = "zj_nvxing_qc",    uiModel = "zj_nvxing"},
        [mActorIds[9]] = { miniIcon = "role_10202", combatModel = "zj_nvxing_dg",    uiModel = "zj_nvxing"},
        [mActorIds[10]] = { miniIcon = "role_10202", combatModel = "zj_nvxing_xg",   uiModel = "zj_nvxing"},
    }

local mActorToPower = {  { mActorIds[1], mActorIds[2], mActorIds[3], mActorIds[4], mActorIds[5] }, 
                         { mActorIds[6], mActorIds[7], mActorIds[8], mActorIds[9], mActorIds[10] }  };

mLeadConfigInfo.mLeadBaseConfig = mLeadBaseConfig;
mLeadConfigInfo.mActorToPower = mActorToPower;

return mLeadConfigInfo;