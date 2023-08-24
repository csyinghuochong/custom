local dungeon_play1=[[知道在商店购买体力的人都是聪明人。]]
local dungeon_play2=[[满级的随从可以进阶升星，小太监也可以变成6星哦！]]
local dungeon_play3=[[不同的随从佩戴不同的才艺，效果会完全不同哦！]]
local dungeon_play4=[[给随从佩戴能最大化其特点的才艺是聪明的做法！]]
local dungeon_play5=[[听说皇上今日又去了慧贵妃那里，真是盛宠不衰啊！]]
local dungeon_play6=[[逆风如解意……咦，下一句是什么来着？]]
local dungeon_play7=[[他们老是在聊天频道里说胎5，胎5到底是谁！]]
local dungeon_play8=[[只要使用方法得当，胎2的随从也能有用武之地哦！]]
local dungeon_play9=[[剧情副本是最基础的副本系统。]]
local dungeon_play10=[[想要获得新的随从，就去招贤吧！]]
local dungeon_play11=[[不知道做什么的时候，可以看看任务系统的任务。]]
local dungeon_play12=[[记得时不时去查看一下邮件哦，很多奖励都通过邮件发送呢！]]
local dungeon_play13=[[在商城可以快速方便的获取需要的物品。]]
local dungeon_play14=[[培养主角、随从、才艺是提升实力的必经之路。]]
local dungeon_play15={
                              reset_cd = 1,
                              remove_buff = 1,
                              recover_hp = 0.2,
                            }

local ConfigSysdungeon_play={
              [1] = {
                      load_tips = {
                              dungeon_play1,
                              dungeon_play2,
                              dungeon_play3,
                              dungeon_play4,
                              dungeon_play5,
                              dungeon_play6,
                              dungeon_play7,
                              dungeon_play8,
                              dungeon_play9,
                              dungeon_play10,
                              dungeon_play11,
                              dungeon_play12,
                              dungeon_play13,
                              dungeon_play14,
                            },
                      king_skill = nil,
                      combat_setting = dungeon_play15,
                      play_name = [[剧情副本]],
                    },
              [2] = {
                      load_tips = {
                              [[想要提升实力，挑战副本会给你意外惊喜哦！]],
                              [[侍帝心得副本的大总管，每被攻击7次被进行一次反击！]],
                              [[小心大总管旁边的人给他加状态！]],
                              [[皇城秘闻中的宫令身边的小宫女可不能随便欺负，她会发怒的！]],
                              [[皇城秘闻中的宫令擅长给人施加负面状态，没有清除状态或免疫的随从前不要轻易招惹她！]],
                              [[八旗宵禁中的禁军统领每个回合会生成抵挡多次伤害的护盾，使用多段攻击的随从将有效克制他！]],
                              [[每天会有不同的势力副本出现，赢得胜利将给你提供随从晋封的证明！]],
                              [[实力到了的时候记得去晋封哦！]],
                            },
                      king_skill = nil,
                      combat_setting = dungeon_play15,
                      play_name = [[挑战副本]],
                    },
              [3] = {
                      load_tips = {
                              dungeon_play1,
                              dungeon_play2,
                              dungeon_play3,
                              dungeon_play4,
                              dungeon_play5,
                              dungeon_play6,
                              dungeon_play7,
                              dungeon_play8,
                              dungeon_play9,
                              dungeon_play10,
                              dungeon_play11,
                              dungeon_play12,
                              dungeon_play13,
                              dungeon_play14,
                            },
                      king_skill = nil,
                      combat_setting = dungeon_play15,
                      play_name = [[传记副本]],
                    },
              [4] = {
                      load_tips = {
                              dungeon_play1,
                              dungeon_play2,
                              dungeon_play3,
                              dungeon_play4,
                              dungeon_play5,
                              dungeon_play6,
                              dungeon_play7,
                              dungeon_play8,
                              dungeon_play9,
                              dungeon_play10,
                              dungeon_play11,
                              dungeon_play12,
                              dungeon_play13,
                              dungeon_play14,
                            },
                      king_skill = nil,
                      combat_setting = dungeon_play15,
                      play_name = [[深宫魅影]],
                    },
              [5] = {
                      load_tips = {
                              dungeon_play1,
                              dungeon_play2,
                              dungeon_play3,
                              dungeon_play4,
                              dungeon_play5,
                              dungeon_play6,
                              dungeon_play7,
                              dungeon_play8,
                              dungeon_play9,
                              dungeon_play10,
                              dungeon_play11,
                              dungeon_play12,
                              dungeon_play13,
                              dungeon_play14,
                            },
                      king_skill = nil,
                      combat_setting = dungeon_play15,
                      play_name = [[宫深似海]],
                    },
              [6] = {
                      load_tips = {
                              dungeon_play1,
                              dungeon_play2,
                              dungeon_play3,
                              dungeon_play4,
                              dungeon_play5,
                              dungeon_play6,
                              dungeon_play7,
                              dungeon_play8,
                              dungeon_play9,
                              dungeon_play10,
                              dungeon_play11,
                              dungeon_play12,
                              dungeon_play13,
                              dungeon_play14,
                            },
                      king_skill = nil,
                      combat_setting = dungeon_play15,
                      play_name = [[美人心计]],
                    },
              [7] = {
                      load_tips = {
                              [[竞技场是个验证实力的好地方。]],
                              [[也有利用防御高的随从配合皇上进行防守的方法]],
                            },
                      king_skill = {
                              10021,
                            },
                      combat_setting = dungeon_play15,
                      play_name = [[竞技场]],
                    },
              [8] = {
                      load_tips = {
                              [[想要证明自己的实力，就来参加巅峰宫斗吧！]],
                            },
                      king_skill = {
                              10022,
                            },
                      combat_setting = dungeon_play15,
                      play_name = [[巅峰宫斗]],
                    },
              [9] = {
                      load_tips = {
                              dungeon_play1,
                              dungeon_play2,
                              dungeon_play3,
                              dungeon_play4,
                              dungeon_play5,
                              dungeon_play6,
                              dungeon_play7,
                              dungeon_play8,
                              dungeon_play9,
                              dungeon_play10,
                              dungeon_play11,
                              dungeon_play12,
                              dungeon_play13,
                              dungeon_play14,
                            },
                      king_skill = nil,
                      combat_setting = dungeon_play15,
                      play_name = [[内务府]],
                    },
            }
return ConfigSysdungeon_play;