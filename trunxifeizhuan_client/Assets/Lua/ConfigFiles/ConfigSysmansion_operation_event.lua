local mansion_operation_event1=[[r_200131]]
local mansion_operation_event2=[[]]
local mansion_operation_event3=[[房梁上藏着100银两]]
local mansion_operation_event4=[[地里挖出1元宝]]
local mansion_operation_event5=[[发现10通宝]]
local mansion_operation_event6=[[邻居小孩来捣乱，屋子又脏了]]
local mansion_operation_event7=[[紫气东来爆发，获得繁荣度20点]]
local mansion_operation_event8=[[神秘商店开启]]
local mansion_operation_event9=[[获得BUFF]]
local mansion_operation_event10=[[BUFF：繁荣度加成10%]]
local mansion_operation_event11=[[BUFF：减少种植需要时间10%]]
local mansion_operation_event12=[[BUFF：免疫偷取，捣乱]]
local mansion_operation_event13=[[皇上送礼物]]
local mansion_operation_event14=[[皇上亲临]]
local mansion_operation_event15={
                                      key = 1010407,
                                      value = 1,
                                    }
local mansion_operation_event16=[[皇后送礼物]]
local mansion_operation_event17=[[皇后亲临]]
local mansion_operation_event18={
                                      key = 1010406,
                                      value = 1,
                                    }
local mansion_operation_event19=[[太监送礼物]]
local mansion_operation_event20={
                                      key = 1010501,
                                      value = 1,
                                    }

local ConfigSysmansion_operation_event={
              [1] = {
                      type = 1,
                      model = mansion_operation_event1,
                      desc = [[XXXXXXXXXXXXX1000银两]],
                      buff_desc = mansion_operation_event2,
                      title = [[NPC商城]],
                      event_params = {
                              1000,
                            },
                      assets = nil,
                      exp = 50,
                    },
              [2] = {
                      type = 1,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event3,
                      buff_desc = mansion_operation_event2,
                      title = mansion_operation_event3,
                      event_params = {
                              1000,
                            },
                      assets = {
                              {
                                      key = 100002,
                                      value = 100,
                                    },
                            },
                      exp = 50,
                    },
              [3] = {
                      type = 1,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event4,
                      buff_desc = mansion_operation_event2,
                      title = mansion_operation_event4,
                      event_params = {
                              1000,
                            },
                      assets = {
                              {
                                      key = 100003,
                                      value = 1,
                                    },
                            },
                      exp = 50,
                    },
              [4] = {
                      type = 1,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event5,
                      buff_desc = mansion_operation_event2,
                      title = mansion_operation_event5,
                      event_params = {
                              1000,
                            },
                      assets = {
                              {
                                      key = 100008,
                                      value = 10,
                                    },
                            },
                      exp = 50,
                    },
              [5] = {
                      type = 1,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event6,
                      buff_desc = mansion_operation_event2,
                      title = mansion_operation_event6,
                      event_params = {
                              1000,
                            },
                      assets = nil,
                      exp = 50,
                    },
              [6] = {
                      type = 1,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event7,
                      buff_desc = mansion_operation_event2,
                      title = mansion_operation_event7,
                      event_params = {
                              1000,
                            },
                      assets = nil,
                      exp = 50,
                    },
              [7] = {
                      type = 2,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event8,
                      buff_desc = mansion_operation_event2,
                      title = mansion_operation_event8,
                      event_params = {
                              1000,
                            },
                      assets = nil,
                      exp = 0,
                    },
              [8] = {
                      type = 2,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event9,
                      buff_desc = mansion_operation_event10,
                      title = mansion_operation_event9,
                      event_params = {
                              1000,
                            },
                      assets = nil,
                      exp = 0,
                    },
              [9] = {
                      type = 2,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event9,
                      buff_desc = mansion_operation_event11,
                      title = mansion_operation_event9,
                      event_params = {
                              1000,
                            },
                      assets = nil,
                      exp = 0,
                    },
              [10] = {
                      type = 2,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event9,
                      buff_desc = mansion_operation_event12,
                      title = mansion_operation_event9,
                      event_params = {
                              1000,
                            },
                      assets = nil,
                      exp = 0,
                    },
              [11] = {
                      type = 2,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event13,
                      buff_desc = mansion_operation_event2,
                      title = mansion_operation_event14,
                      event_params = {
                              100,
                            },
                      assets = {
                              mansion_operation_event15,
                            },
                      exp = 0,
                    },
              [12] = {
                      type = 2,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event16,
                      buff_desc = mansion_operation_event2,
                      title = mansion_operation_event17,
                      event_params = {
                              150,
                            },
                      assets = {
                              mansion_operation_event18,
                            },
                      exp = 0,
                    },
              [13] = {
                      type = 2,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event19,
                      buff_desc = mansion_operation_event2,
                      title = mansion_operation_event19,
                      event_params = {
                              200,
                            },
                      assets = {
                              mansion_operation_event20,
                            },
                      exp = 0,
                    },
              [14] = {
                      type = 2,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event13,
                      buff_desc = mansion_operation_event10,
                      title = mansion_operation_event14,
                      event_params = {
                              100,
                            },
                      assets = {
                              mansion_operation_event15,
                            },
                      exp = 0,
                    },
              [15] = {
                      type = 2,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event16,
                      buff_desc = mansion_operation_event11,
                      title = mansion_operation_event17,
                      event_params = {
                              150,
                            },
                      assets = {
                              mansion_operation_event18,
                            },
                      exp = 0,
                    },
              [16] = {
                      type = 2,
                      model = mansion_operation_event1,
                      desc = mansion_operation_event19,
                      buff_desc = mansion_operation_event12,
                      title = mansion_operation_event19,
                      event_params = {
                              200,
                            },
                      assets = {
                              mansion_operation_event20,
                            },
                      exp = 0,
                    },
            }
return ConfigSysmansion_operation_event;