local mansion_events1=[[回访]]

local ConfigSysmansion_events={
              [1] = {
                      big_type = 1,
                      small_type = 102,
                      msg = [[<size=20><color=#a0de70>您正在 %s 的府邸中进行拜访。</color></size>]],
                      button = [[查看]],
                    },
              [2] = {
                      big_type = 1,
                      small_type = 101,
                      msg = [[<size=20><color=#a0de70>%s在%s对您进行了拜访。</color></size>]],
                      button = mansion_events1,
                    },
              [3] = {
                      big_type = 2,
                      small_type = 200,
                      msg = [[<size=20><color=#a0de70>%s在%s偷走了你的一个%s。</color></size>]],
                      button = mansion_events1,
                    },
              [4] = {
                      big_type = 2,
                      small_type = 201,
                      msg = [[<size=20><color=#a0de70>%s在%s对您种植的%s进行捣乱。</color></size>]],
                      button = mansion_events1,
                    },
              [5] = {
                      big_type = 2,
                      small_type = 202,
                      msg = [[<size=20><color=#a0de70>%s在%s对您种植的%s浇了一次水。</color></size>]],
                      button = mansion_events1,
                    },
              [6] = {
                      big_type = 2,
                      small_type = 201,
                      msg = [[<size=20><color=#a0de70>%s在%s对您种植的%s进行的捣乱行为被仆人阻止了。</color></size>]],
                      button = mansion_events1,
                    },
            }
return ConfigSysmansion_events;