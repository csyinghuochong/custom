local mansion_feast_guest1={
                                      goods_id = 1033021,
                                      goods_num = 1,
                                    }
local mansion_feast_guest2={
                                      goods_id = 1033022,
                                      goods_num = 1,
                                    }
local mansion_feast_guest3={
                                      goods_id = 1010501,
                                      goods_num = 1,
                                    }

local ConfigSysmansion_feast_guest={
              [1] = {
                      type = 8,
                      price = 120,
                      boom = 8,
                      reward = {
                              mansion_feast_guest1,
                            },
                    },
              [2] = {
                      type = 8,
                      price = 600,
                      boom = 9,
                      reward = {
                              mansion_feast_guest2,
                            },
                    },
              [3] = {
                      type = 8,
                      price = 1440,
                      boom = 12,
                      reward = {
                              mansion_feast_guest3,
                            },
                    },
              [4] = {
                      type = 3,
                      price = 10,
                      boom = 10,
                      reward = {
                              mansion_feast_guest1,
                            },
                    },
              [5] = {
                      type = 3,
                      price = 50,
                      boom = 12,
                      reward = {
                              mansion_feast_guest2,
                            },
                    },
              [6] = {
                      type = 3,
                      price = 120,
                      boom = 15,
                      reward = {
                              mansion_feast_guest3,
                            },
                    },
              [7] = {
                      type = 3,
                      price = 20,
                      boom = 20,
                      reward = {
                              {
                                      goods_id = 1010701,
                                      goods_num = 1,
                                    },
                            },
                    },
              [8] = {
                      type = 3,
                      price = 120,
                      boom = 24,
                      reward = {
                              mansion_feast_guest3,
                            },
                    },
              [9] = {
                      type = 3,
                      price = 240,
                      boom = 30,
                      reward = {
                              {
                                      goods_id = 1010402,
                                      goods_num = 1,
                                    },
                            },
                    },
            }
return ConfigSysmansion_feast_guest;