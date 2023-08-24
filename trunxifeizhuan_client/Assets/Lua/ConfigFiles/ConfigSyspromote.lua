local promote1={
                                      type = 1,
                                      time = 300,
                                      story_id = 1,
                                      question_number = 10,
                                      again_cost = 10,
                                    }
local promote2={
                                      type = 4,
                                      time = 1000,
                                      story_id = 0,
                                      question_number = 1,
                                      again_cost = 30,
                                    }
local promote3={
                                      goods_id = 1000002,
                                      goods_number = 10000,
                                    }
local promote4={
                                      goods_id = 1000002,
                                      goods_number = 20000,
                                    }
local promote5={
                                      goods_id = 1000002,
                                      goods_number = 50000,
                                    }

local ConfigSyspromote={
              [1] = {
                      office_id = 1,
                      number_limit = {
                              1,
                              0,
                            },
                      qulity = 10,
                      woman_name = [[十品秀女]],
                      man_name = [[十品协领]],
                      exam_condition = {
                              1,
                              1,
                            },
                      exam__content = {
                              promote1,
                              promote2,
                            },
                      cost = {
                              promote3,
                              {
                                      goods_id = 1000003,
                                      goods_number = 10,
                                    },
                            },
                      examiner_id = 201,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = nil,
                    },
              [2] = {
                      office_id = 2,
                      number_limit = {
                              1,
                              0,
                            },
                      qulity = 9,
                      woman_name = [[九品采女]],
                      man_name = [[九品通判]],
                      exam_condition = {
                              1,
                              2,
                            },
                      exam__content = {
                              promote1,
                              promote2,
                            },
                      cost = {
                              promote4,
                              {
                                      goods_id = 1000003,
                                      goods_number = 20,
                                    },
                            },
                      examiner_id = 201,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = {
                              promote3,
                            },
                    },
              [3] = {
                      office_id = 3,
                      number_limit = {
                              1,
                              0,
                            },
                      qulity = 8,
                      woman_name = [[八品官女子]],
                      man_name = [[八品知事]],
                      exam_condition = {
                              1,
                              3,
                            },
                      exam__content = {
                              promote1,
                              promote2,
                            },
                      cost = {
                              promote5,
                              {
                                      goods_id = 1000003,
                                      goods_number = 30,
                                    },
                            },
                      examiner_id = 201,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = {
                              promote4,
                            },
                    },
              [4] = {
                      office_id = 4,
                      number_limit = {
                              1,
                              0,
                            },
                      qulity = 7,
                      woman_name = [[七品答应]],
                      man_name = [[七品主簿]],
                      exam_condition = {
                              1,
                              4,
                            },
                      exam__content = {
                              promote1,
                              promote2,
                            },
                      cost = {
                              {
                                      goods_id = 1000002,
                                      goods_number = 100000,
                                    },
                              {
                                      goods_id = 1000003,
                                      goods_number = 40,
                                    },
                            },
                      examiner_id = 204,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = {
                              {
                                      goods_id = 1000002,
                                      goods_number = 35000,
                                    },
                            },
                    },
              [5] = {
                      office_id = 5,
                      number_limit = {
                              1,
                              0,
                            },
                      qulity = 6,
                      woman_name = [[六品常在]],
                      man_name = [[六品学士]],
                      exam_condition = {
                              1,
                              5,
                            },
                      exam__content = {
                              promote1,
                              promote2,
                            },
                      cost = {
                              {
                                      goods_id = 1000002,
                                      goods_number = 200000,
                                    },
                              {
                                      goods_id = 1000003,
                                      goods_number = 50,
                                    },
                            },
                      examiner_id = 204,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = {
                              promote5,
                            },
                    },
              [6] = {
                      office_id = 6,
                      number_limit = {
                              1,
                              0,
                            },
                      qulity = 5,
                      woman_name = [[五品贵人]],
                      man_name = [[五品少卿]],
                      exam_condition = {
                              1,
                              6,
                            },
                      exam__content = nil,
                      cost = nil,
                      examiner_id = 206,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = {
                              {
                                      goods_id = 1000002,
                                      goods_number = 75000,
                                    },
                              {
                                      goods_id = 1010408,
                                      goods_number = 5,
                                    },
                            },
                    },
              [7] = {
                      office_id = 7,
                      number_limit = {
                              1,
                              50,
                            },
                      qulity = 4,
                      woman_name = [[四品嫔]],
                      man_name = [[四品寺卿]],
                      exam_condition = nil,
                      exam__content = nil,
                      cost = nil,
                      examiner_id = 206,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = nil,
                    },
              [8] = {
                      office_id = 8,
                      number_limit = {
                              1,
                              25,
                            },
                      qulity = 3,
                      woman_name = [[三品贵嫔]],
                      man_name = [[三品侍郎]],
                      exam_condition = nil,
                      exam__content = nil,
                      cost = nil,
                      examiner_id = 206,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = nil,
                    },
              [9] = {
                      office_id = 9,
                      number_limit = {
                              1,
                              10,
                            },
                      qulity = 2,
                      woman_name = [[二品妃]],
                      man_name = [[二品尚书]],
                      exam_condition = nil,
                      exam__content = nil,
                      cost = nil,
                      examiner_id = 206,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = nil,
                    },
              [10] = {
                      office_id = 10,
                      number_limit = {
                              1,
                              5,
                            },
                      qulity = 1,
                      woman_name = [[一品贵妃]],
                      man_name = [[一品太师]],
                      exam_condition = nil,
                      exam__content = nil,
                      cost = nil,
                      examiner_id = 206,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = nil,
                    },
              [11] = {
                      office_id = 11,
                      number_limit = {
                              1,
                              1,
                            },
                      qulity = 1,
                      woman_name = [[皇贵妃]],
                      man_name = [[亲王]],
                      exam_condition = nil,
                      exam__content = nil,
                      cost = nil,
                      examiner_id = 206,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = nil,
                    },
              [12] = {
                      office_id = 12,
                      number_limit = {
                              2,
                              1,
                            },
                      qulity = 1,
                      woman_name = [[皇后]],
                      man_name = [[皇上]],
                      exam_condition = nil,
                      exam__content = nil,
                      cost = nil,
                      examiner_id = 0,
                      robot_list = {
                              900001,
                              900002,
                            },
                      story_id = 1,
                      award = nil,
                    },
            }
return ConfigSyspromote;