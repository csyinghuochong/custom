local promote_question_yi1=[[增加经验]]
local promote_question_yi2=[[增加属性]]
local promote_question_yi3=[[增加亲密度]]
local promote_question_yi4=[[增加中国男足出线概率]]
local promote_question_yi5=[[商城]]
local promote_question_yi6=[[副本]]
local promote_question_yi7=[[种植]]
local promote_question_yi8=[[勤务房]]
local promote_question_yi9=[[1]]
local promote_question_yi10=[[2]]
local promote_question_yi11=[[3]]
local promote_question_yi12=[[4]]

local ConfigSyspromote_question_yi={
              [1] = {
                      title = [[在本游戏中，菜肴有哪些作用？]],
                      options = {
                              {
                                      option_id = 1,
                                      option = promote_question_yi1,
                                    },
                              {
                                      option_id = 2,
                                      option = promote_question_yi2,
                                    },
                              {
                                      option_id = 3,
                                      option = promote_question_yi3,
                                    },
                              {
                                      option_id = 4,
                                      option = promote_question_yi4,
                                    },
                            },
                      answer = {
                              1,
                              2,
                              3,
                            },
                    },
              [2] = {
                      title = [[在本游戏中，丹药有哪些作用？]],
                      options = {
                              {
                                      option_id = 1,
                                      option = promote_question_yi1,
                                    },
                              {
                                      option_id = 2,
                                      option = promote_question_yi2,
                                    },
                              {
                                      option_id = 3,
                                      option = promote_question_yi3,
                                    },
                              {
                                      option_id = 4,
                                      option = promote_question_yi4,
                                    },
                              {
                                      option_id = 5,
                                      option = [[永生]],
                                    },
                            },
                      answer = {
                              1,
                              2,
                            },
                    },
              [3] = {
                      title = [[在本游戏中，装扮有哪些功能及作用？]],
                      options = {
                              {
                                      option_id = 6,
                                      option = [[获得繁荣度]],
                                    },
                              {
                                      option_id = 7,
                                      option = [[点赞]],
                                    },
                              {
                                      option_id = 8,
                                      option = [[出售]],
                                    },
                              {
                                      option_id = 9,
                                      option = [[赠送]],
                                    },
                            },
                      answer = {
                              6,
                              7,
                              8,
                              9,
                            },
                    },
              [4] = {
                      title = [[在本游戏中，菜肴的获取途径有哪些？]],
                      options = {
                              {
                                      option_id = 10,
                                      option = promote_question_yi5,
                                    },
                              {
                                      option_id = 11,
                                      option = promote_question_yi6,
                                    },
                              {
                                      option_id = 12,
                                      option = promote_question_yi7,
                                    },
                              {
                                      option_id = 13,
                                      option = promote_question_yi8,
                                    },
                            },
                      answer = {
                              13,
                            },
                    },
              [5] = {
                      title = [[在本游戏中，丹药的获取途径有哪些？]],
                      options = {
                              {
                                      option_id = 10,
                                      option = promote_question_yi5,
                                    },
                              {
                                      option_id = 11,
                                      option = promote_question_yi6,
                                    },
                              {
                                      option_id = 12,
                                      option = promote_question_yi7,
                                    },
                              {
                                      option_id = 13,
                                      option = promote_question_yi8,
                                    },
                            },
                      answer = {
                              13,
                            },
                    },
              [6] = {
                      title = [[在本游戏中，装扮的获取途径有哪些？]],
                      options = {
                              {
                                      option_id = 10,
                                      option = promote_question_yi5,
                                    },
                              {
                                      option_id = 11,
                                      option = promote_question_yi6,
                                    },
                              {
                                      option_id = 12,
                                      option = promote_question_yi7,
                                    },
                              {
                                      option_id = 13,
                                      option = promote_question_yi8,
                                    },
                            },
                      answer = {
                              10,
                              13,
                            },
                    },
              [7] = {
                      title = [[在本游戏府邸中，有哪些仆人？]],
                      options = {
                              {
                                      option_id = 14,
                                      option = [[贴身侍婢]],
                                    },
                              {
                                      option_id = 15,
                                      option = [[打扫仆人]],
                                    },
                              {
                                      option_id = 16,
                                      option = [[种植仆人]],
                                    },
                              {
                                      option_id = 17,
                                      option = [[宴会仆人]],
                                    },
                            },
                      answer = {
                              14,
                              15,
                              16,
                            },
                    },
              [8] = {
                      title = [[在本游戏府邸中，有哪些建筑？]],
                      options = {
                              {
                                      option_id = 18,
                                      option = [[客厅]],
                                    },
                              {
                                      option_id = 19,
                                      option = [[卧室]],
                                    },
                              {
                                      option_id = 20,
                                      option = [[偏厅]],
                                    },
                              {
                                      option_id = 21,
                                      option = [[暖阁]],
                                    },
                              {
                                      option_id = 22,
                                      option = [[大殿]],
                                    },
                            },
                      answer = {
                              18,
                              19,
                              20,
                            },
                    },
              [9] = {
                      title = [[在本游戏府邸中，以下哪些活动能获得繁荣度？]],
                      options = {
                              {
                                      option_id = 23,
                                      option = [[打扫]],
                                    },
                              {
                                      option_id = 24,
                                      option = promote_question_yi7,
                                    },
                              {
                                      option_id = 25,
                                      option = [[举办宴会]],
                                    },
                              {
                                      option_id = 26,
                                      option = [[参加宴会]],
                                    },
                              {
                                      option_id = 27,
                                      option = [[装扮府邸]],
                                    },
                            },
                      answer = {
                              23,
                              24,
                              25,
                              27,
                            },
                    },
              [10] = {
                      title = [[在本游戏府邸中，每天能对一个好友拜访几次？]],
                      options = {
                              {
                                      option_id = 28,
                                      option = promote_question_yi9,
                                    },
                              {
                                      option_id = 29,
                                      option = promote_question_yi10,
                                    },
                              {
                                      option_id = 30,
                                      option = promote_question_yi11,
                                    },
                              {
                                      option_id = 31,
                                      option = promote_question_yi12,
                                    },
                            },
                      answer = {
                              28,
                            },
                    },
              [11] = {
                      title = [[在本游戏府邸中，最多能开辟多少块土地？]],
                      options = {
                              {
                                      option_id = 32,
                                      option = [[8]],
                                    },
                              {
                                      option_id = 33,
                                      option = [[10]],
                                    },
                              {
                                      option_id = 34,
                                      option = [[12]],
                                    },
                              {
                                      option_id = 35,
                                      option = [[14]],
                                    },
                            },
                      answer = {
                              34,
                            },
                    },
              [12] = {
                      title = [[在本游戏府邸中，每人每天能举办几次宴会？]],
                      options = {
                              {
                                      option_id = 28,
                                      option = promote_question_yi9,
                                    },
                              {
                                      option_id = 29,
                                      option = promote_question_yi10,
                                    },
                              {
                                      option_id = 30,
                                      option = promote_question_yi11,
                                    },
                              {
                                      option_id = 31,
                                      option = promote_question_yi12,
                                    },
                            },
                      answer = {
                              28,
                            },
                    },
            }
return ConfigSyspromote_question_yi;