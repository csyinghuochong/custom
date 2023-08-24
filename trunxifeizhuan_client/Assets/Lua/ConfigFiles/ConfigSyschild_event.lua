local child_event1=[[遇见三阿哥，和三阿哥结伴游玩]]
local child_event2=[[获得三阿哥赠送xx道具]]
local child_event3=[[被皇后看见，训斥了一顿]]
local child_event4={
                                      character = 1,
                                      rate = 80,
                                    }
local child_event5={
                                      character = 2,
                                      rate = 70,
                                    }
local child_event6={
                                      character = 3,
                                      rate = 60,
                                    }

local ConfigSyschild_event={
              [1] = {
                      content = child_event1,
                      good_result = child_event2,
                      bad_result = child_event3,
                      reward = {
                              {
                                      goods_id = 100001,
                                      goods_num = 1,
                                    },
                            },
                      reward_exp = 1,
                      rate = {
                              child_event4,
                              child_event5,
                              child_event6,
                              {
                                      character = 4,
                                      rate = 50,
                                    },
                            },
                    },
              [2] = {
                      content = child_event1,
                      good_result = child_event2,
                      bad_result = child_event3,
                      reward = {
                              {
                                      goods_id = 100001,
                                      goods_num = 2,
                                    },
                            },
                      reward_exp = 2,
                      rate = {
                              child_event4,
                              child_event5,
                              child_event6,
                              {
                                      character = 4,
                                      rate = 51,
                                    },
                            },
                    },
              [3] = {
                      content = child_event1,
                      good_result = child_event2,
                      bad_result = child_event3,
                      reward = {
                              {
                                      goods_id = 100001,
                                      goods_num = 3,
                                    },
                            },
                      reward_exp = 3,
                      rate = {
                              child_event4,
                              child_event5,
                              child_event6,
                              {
                                      character = 4,
                                      rate = 52,
                                    },
                            },
                    },
              [4] = {
                      content = child_event1,
                      good_result = child_event2,
                      bad_result = child_event3,
                      reward = {
                              {
                                      goods_id = 100001,
                                      goods_num = 4,
                                    },
                            },
                      reward_exp = 4,
                      rate = {
                              child_event4,
                              child_event5,
                              child_event6,
                              {
                                      character = 4,
                                      rate = 53,
                                    },
                            },
                    },
            }
return ConfigSyschild_event;