local worship_queen1={
                                      goods_id = 1000002,
                                      goods_num = 10000,
                                      goods_rate = 1600,
                                    }
local worship_queen2={
                                      goods_id = 1000002,
                                      goods_num = 150000,
                                      goods_rate = 1000,
                                    }
local worship_queen3={
                                      goods_id = 1000003,
                                      goods_num = 10,
                                      goods_rate = 1000,
                                    }
local worship_queen4={
                                      goods_id = 1000003,
                                      goods_num = 100,
                                      goods_rate = 100,
                                    }
local worship_queen5={
                                      goods_id = 1010402,
                                      goods_num = 1,
                                      goods_rate = 100,
                                    }
local worship_queen6={
                                      goods_id = 1011102,
                                      goods_num = 1,
                                      goods_rate = 1000,
                                    }
local worship_queen7={
                                      goods_id = 1010501,
                                      goods_num = 1,
                                      goods_rate = 800,
                                    }
local worship_queen8={
                                      goods_id = 1010502,
                                      goods_num = 1,
                                      goods_rate = 400,
                                    }
local worship_queen9={
                                      goods_id = 1010503,
                                      goods_num = 1,
                                      goods_rate = 200,
                                    }
local worship_queen10={
                                      goods_id = 1000010,
                                      goods_num = 1,
                                      goods_rate = 1500,
                                    }
local worship_queen11={
                                      goods_id = 1010202,
                                      goods_num = 1,
                                      goods_rate = 800,
                                    }
local worship_queen12={
                                      goods_id = 1000009,
                                      goods_num = 20,
                                      goods_rate = 1500,
                                    }

local ConfigSysworship_queen={
              [1] = {
                      type = 1,
                      times_limit = 10,
                      gold_cost = 20,
                      reward = {
                              worship_queen1,
                              worship_queen2,
                              worship_queen3,
                              worship_queen4,
                              worship_queen5,
                              worship_queen6,
                              worship_queen7,
                              worship_queen8,
                              worship_queen9,
                              worship_queen10,
                              worship_queen11,
                              worship_queen12,
                            },
                    },
              [2] = {
                      type = 2,
                      times_limit = 10,
                      gold_cost = 100,
                      reward = {
                              worship_queen1,
                              worship_queen2,
                              worship_queen3,
                              worship_queen4,
                              worship_queen5,
                              worship_queen6,
                              worship_queen7,
                              worship_queen8,
                              worship_queen9,
                              worship_queen10,
                              worship_queen11,
                              worship_queen12,
                            },
                    },
            }
return ConfigSysworship_queen;