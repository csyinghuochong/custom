local promote_examine1={
                      examine_id = 201,
                      require = {
                              1,
                              3,
                              4,
                              3,
                            },
                    }
local promote_examine2={
                      examine_id = 202,
                      require = {
                              3,
                              4,
                              1,
                              3,
                            },
                    }
local promote_examine3={
                      examine_id = 203,
                      require = {
                              3,
                              1,
                              3,
                              4,
                            },
                    }
local promote_examine4={
                      examine_id = 204,
                      require = {
                              2,
                              3,
                              3,
                              2,
                            },
                    }
local promote_examine5={
                      examine_id = 205,
                      require = {
                              4,
                              3,
                              3,
                              1,
                            },
                    }
local promote_examine6={
                      examine_id = 206,
                      require = {
                              3,
                              2,
                              2,
                              3,
                            },
                    }

local ConfigSyspromote_examine={
              ["2_201"] = promote_examine1,
              ["3_201"] = promote_examine1,
              ["4_201"] = promote_examine1,
              ["5_201"] = promote_examine1,
              ["6_201"] = promote_examine1,
              ["2_202"] = promote_examine2,
              ["3_202"] = promote_examine2,
              ["4_202"] = promote_examine2,
              ["5_202"] = promote_examine2,
              ["6_202"] = promote_examine2,
              ["2_203"] = promote_examine3,
              ["3_203"] = promote_examine3,
              ["4_203"] = promote_examine3,
              ["5_203"] = promote_examine3,
              ["6_203"] = promote_examine3,
              ["2_204"] = promote_examine4,
              ["3_204"] = promote_examine4,
              ["4_204"] = promote_examine4,
              ["5_204"] = promote_examine4,
              ["6_204"] = promote_examine4,
              ["2_205"] = promote_examine5,
              ["3_205"] = promote_examine5,
              ["4_205"] = promote_examine5,
              ["5_205"] = promote_examine5,
              ["6_205"] = promote_examine5,
              ["2_206"] = promote_examine6,
              ["3_206"] = promote_examine6,
              ["4_206"] = promote_examine6,
              ["5_206"] = promote_examine6,
              ["6_206"] = promote_examine6,
            }
return ConfigSyspromote_examine;