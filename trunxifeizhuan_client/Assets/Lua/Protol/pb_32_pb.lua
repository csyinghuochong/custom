--Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf.protobuf"
local pb_common_pb = require("Protol.pb_common_pb")
module('Protol.pb_32_pb')

PBTALENTLIST = protobuf.Descriptor();
PBTALENTLIST_TALENT_LIST_FIELD = protobuf.FieldDescriptor();
PBTALENTMODEL = protobuf.Descriptor();
PBTALENTMODEL_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODEL_NUM_FIELD = protobuf.FieldDescriptor();
PBTALENTSELL = protobuf.Descriptor();
PBTALENTSELL_SELL_LIST_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELWEAR = protobuf.Descriptor();
PBTALENTMODELWEAR_PARTNER_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELWEAR_POS_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELWEAR_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELREMOVE = protobuf.Descriptor();
PBTALENTMODELREMOVE_PARTNER_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELREMOVE_POS_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELSTRENGTH = protobuf.Descriptor();
PBTALENTMODELSTRENGTH_PARTNER_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELSTRENGTH_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELSTRENGTH_USE_GOOD_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELUP = protobuf.Descriptor();
PBTALENTMODELUP_PARTNER_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELUP_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELUP_SEQ_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELUP_USE_GOOD_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELSAVE = protobuf.Descriptor();
PBTALENTMODELSAVE_PARTNER_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELSAVE_ID_FIELD = protobuf.FieldDescriptor();
PBTALENTMODELSAVE_ACT_FIELD = protobuf.FieldDescriptor();
PBTALENTATTRIBUTEADD = protobuf.Descriptor();
PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD = protobuf.FieldDescriptor();

PBTALENTLIST_TALENT_LIST_FIELD.name = "talent_list"
PBTALENTLIST_TALENT_LIST_FIELD.full_name = ".pbTalentList.talent_list"
PBTALENTLIST_TALENT_LIST_FIELD.number = 1
PBTALENTLIST_TALENT_LIST_FIELD.index = 0
PBTALENTLIST_TALENT_LIST_FIELD.label = 3
PBTALENTLIST_TALENT_LIST_FIELD.has_default_value = false
PBTALENTLIST_TALENT_LIST_FIELD.default_value = {}
PBTALENTLIST_TALENT_LIST_FIELD.message_type = pb_common_pb.PBTALENT
PBTALENTLIST_TALENT_LIST_FIELD.type = 11
PBTALENTLIST_TALENT_LIST_FIELD.cpp_type = 10

PBTALENTLIST.name = "pbTalentList"
PBTALENTLIST.full_name = ".pbTalentList"
PBTALENTLIST.nested_types = {}
PBTALENTLIST.enum_types = {}
PBTALENTLIST.fields = {PBTALENTLIST_TALENT_LIST_FIELD}
PBTALENTLIST.is_extendable = false
PBTALENTLIST.extensions = {}
PBTALENTMODEL_ID_FIELD.name = "id"
PBTALENTMODEL_ID_FIELD.full_name = ".pbTalentModel.id"
PBTALENTMODEL_ID_FIELD.number = 1
PBTALENTMODEL_ID_FIELD.index = 0
PBTALENTMODEL_ID_FIELD.label = 1
PBTALENTMODEL_ID_FIELD.has_default_value = false
PBTALENTMODEL_ID_FIELD.default_value = 0
PBTALENTMODEL_ID_FIELD.type = 5
PBTALENTMODEL_ID_FIELD.cpp_type = 1

PBTALENTMODEL_NUM_FIELD.name = "num"
PBTALENTMODEL_NUM_FIELD.full_name = ".pbTalentModel.num"
PBTALENTMODEL_NUM_FIELD.number = 2
PBTALENTMODEL_NUM_FIELD.index = 1
PBTALENTMODEL_NUM_FIELD.label = 1
PBTALENTMODEL_NUM_FIELD.has_default_value = false
PBTALENTMODEL_NUM_FIELD.default_value = 0
PBTALENTMODEL_NUM_FIELD.type = 5
PBTALENTMODEL_NUM_FIELD.cpp_type = 1

PBTALENTMODEL.name = "pbTalentModel"
PBTALENTMODEL.full_name = ".pbTalentModel"
PBTALENTMODEL.nested_types = {}
PBTALENTMODEL.enum_types = {}
PBTALENTMODEL.fields = {PBTALENTMODEL_ID_FIELD, PBTALENTMODEL_NUM_FIELD}
PBTALENTMODEL.is_extendable = false
PBTALENTMODEL.extensions = {}
PBTALENTSELL_SELL_LIST_FIELD.name = "sell_list"
PBTALENTSELL_SELL_LIST_FIELD.full_name = ".pbTalentSell.sell_list"
PBTALENTSELL_SELL_LIST_FIELD.number = 1
PBTALENTSELL_SELL_LIST_FIELD.index = 0
PBTALENTSELL_SELL_LIST_FIELD.label = 3
PBTALENTSELL_SELL_LIST_FIELD.has_default_value = false
PBTALENTSELL_SELL_LIST_FIELD.default_value = {}
PBTALENTSELL_SELL_LIST_FIELD.message_type = PBTALENTMODEL
PBTALENTSELL_SELL_LIST_FIELD.type = 11
PBTALENTSELL_SELL_LIST_FIELD.cpp_type = 10

PBTALENTSELL.name = "pbTalentSell"
PBTALENTSELL.full_name = ".pbTalentSell"
PBTALENTSELL.nested_types = {}
PBTALENTSELL.enum_types = {}
PBTALENTSELL.fields = {PBTALENTSELL_SELL_LIST_FIELD}
PBTALENTSELL.is_extendable = false
PBTALENTSELL.extensions = {}
PBTALENTMODELWEAR_PARTNER_ID_FIELD.name = "partner_id"
PBTALENTMODELWEAR_PARTNER_ID_FIELD.full_name = ".pbTalentModelWear.partner_id"
PBTALENTMODELWEAR_PARTNER_ID_FIELD.number = 1
PBTALENTMODELWEAR_PARTNER_ID_FIELD.index = 0
PBTALENTMODELWEAR_PARTNER_ID_FIELD.label = 1
PBTALENTMODELWEAR_PARTNER_ID_FIELD.has_default_value = false
PBTALENTMODELWEAR_PARTNER_ID_FIELD.default_value = 0
PBTALENTMODELWEAR_PARTNER_ID_FIELD.type = 5
PBTALENTMODELWEAR_PARTNER_ID_FIELD.cpp_type = 1

PBTALENTMODELWEAR_POS_FIELD.name = "pos"
PBTALENTMODELWEAR_POS_FIELD.full_name = ".pbTalentModelWear.pos"
PBTALENTMODELWEAR_POS_FIELD.number = 2
PBTALENTMODELWEAR_POS_FIELD.index = 1
PBTALENTMODELWEAR_POS_FIELD.label = 1
PBTALENTMODELWEAR_POS_FIELD.has_default_value = false
PBTALENTMODELWEAR_POS_FIELD.default_value = 0
PBTALENTMODELWEAR_POS_FIELD.type = 5
PBTALENTMODELWEAR_POS_FIELD.cpp_type = 1

PBTALENTMODELWEAR_ID_FIELD.name = "id"
PBTALENTMODELWEAR_ID_FIELD.full_name = ".pbTalentModelWear.id"
PBTALENTMODELWEAR_ID_FIELD.number = 3
PBTALENTMODELWEAR_ID_FIELD.index = 2
PBTALENTMODELWEAR_ID_FIELD.label = 1
PBTALENTMODELWEAR_ID_FIELD.has_default_value = false
PBTALENTMODELWEAR_ID_FIELD.default_value = 0
PBTALENTMODELWEAR_ID_FIELD.type = 5
PBTALENTMODELWEAR_ID_FIELD.cpp_type = 1

PBTALENTMODELWEAR.name = "pbTalentModelWear"
PBTALENTMODELWEAR.full_name = ".pbTalentModelWear"
PBTALENTMODELWEAR.nested_types = {}
PBTALENTMODELWEAR.enum_types = {}
PBTALENTMODELWEAR.fields = {PBTALENTMODELWEAR_PARTNER_ID_FIELD, PBTALENTMODELWEAR_POS_FIELD, PBTALENTMODELWEAR_ID_FIELD}
PBTALENTMODELWEAR.is_extendable = false
PBTALENTMODELWEAR.extensions = {}
PBTALENTMODELREMOVE_PARTNER_ID_FIELD.name = "partner_id"
PBTALENTMODELREMOVE_PARTNER_ID_FIELD.full_name = ".pbTalentModelRemove.partner_id"
PBTALENTMODELREMOVE_PARTNER_ID_FIELD.number = 1
PBTALENTMODELREMOVE_PARTNER_ID_FIELD.index = 0
PBTALENTMODELREMOVE_PARTNER_ID_FIELD.label = 1
PBTALENTMODELREMOVE_PARTNER_ID_FIELD.has_default_value = false
PBTALENTMODELREMOVE_PARTNER_ID_FIELD.default_value = 0
PBTALENTMODELREMOVE_PARTNER_ID_FIELD.type = 5
PBTALENTMODELREMOVE_PARTNER_ID_FIELD.cpp_type = 1

PBTALENTMODELREMOVE_POS_FIELD.name = "pos"
PBTALENTMODELREMOVE_POS_FIELD.full_name = ".pbTalentModelRemove.pos"
PBTALENTMODELREMOVE_POS_FIELD.number = 2
PBTALENTMODELREMOVE_POS_FIELD.index = 1
PBTALENTMODELREMOVE_POS_FIELD.label = 1
PBTALENTMODELREMOVE_POS_FIELD.has_default_value = false
PBTALENTMODELREMOVE_POS_FIELD.default_value = 0
PBTALENTMODELREMOVE_POS_FIELD.type = 5
PBTALENTMODELREMOVE_POS_FIELD.cpp_type = 1

PBTALENTMODELREMOVE.name = "pbTalentModelRemove"
PBTALENTMODELREMOVE.full_name = ".pbTalentModelRemove"
PBTALENTMODELREMOVE.nested_types = {}
PBTALENTMODELREMOVE.enum_types = {}
PBTALENTMODELREMOVE.fields = {PBTALENTMODELREMOVE_PARTNER_ID_FIELD, PBTALENTMODELREMOVE_POS_FIELD}
PBTALENTMODELREMOVE.is_extendable = false
PBTALENTMODELREMOVE.extensions = {}
PBTALENTMODELSTRENGTH_PARTNER_ID_FIELD.name = "partner_id"
PBTALENTMODELSTRENGTH_PARTNER_ID_FIELD.full_name = ".pbTalentModelStrength.partner_id"
PBTALENTMODELSTRENGTH_PARTNER_ID_FIELD.number = 1
PBTALENTMODELSTRENGTH_PARTNER_ID_FIELD.index = 0
PBTALENTMODELSTRENGTH_PARTNER_ID_FIELD.label = 1
PBTALENTMODELSTRENGTH_PARTNER_ID_FIELD.has_default_value = false
PBTALENTMODELSTRENGTH_PARTNER_ID_FIELD.default_value = 0
PBTALENTMODELSTRENGTH_PARTNER_ID_FIELD.type = 5
PBTALENTMODELSTRENGTH_PARTNER_ID_FIELD.cpp_type = 1

PBTALENTMODELSTRENGTH_ID_FIELD.name = "id"
PBTALENTMODELSTRENGTH_ID_FIELD.full_name = ".pbTalentModelStrength.id"
PBTALENTMODELSTRENGTH_ID_FIELD.number = 2
PBTALENTMODELSTRENGTH_ID_FIELD.index = 1
PBTALENTMODELSTRENGTH_ID_FIELD.label = 1
PBTALENTMODELSTRENGTH_ID_FIELD.has_default_value = false
PBTALENTMODELSTRENGTH_ID_FIELD.default_value = 0
PBTALENTMODELSTRENGTH_ID_FIELD.type = 5
PBTALENTMODELSTRENGTH_ID_FIELD.cpp_type = 1

PBTALENTMODELSTRENGTH_USE_GOOD_ID_FIELD.name = "use_good_id"
PBTALENTMODELSTRENGTH_USE_GOOD_ID_FIELD.full_name = ".pbTalentModelStrength.use_good_id"
PBTALENTMODELSTRENGTH_USE_GOOD_ID_FIELD.number = 3
PBTALENTMODELSTRENGTH_USE_GOOD_ID_FIELD.index = 2
PBTALENTMODELSTRENGTH_USE_GOOD_ID_FIELD.label = 1
PBTALENTMODELSTRENGTH_USE_GOOD_ID_FIELD.has_default_value = false
PBTALENTMODELSTRENGTH_USE_GOOD_ID_FIELD.default_value = 0
PBTALENTMODELSTRENGTH_USE_GOOD_ID_FIELD.type = 5
PBTALENTMODELSTRENGTH_USE_GOOD_ID_FIELD.cpp_type = 1

PBTALENTMODELSTRENGTH.name = "pbTalentModelStrength"
PBTALENTMODELSTRENGTH.full_name = ".pbTalentModelStrength"
PBTALENTMODELSTRENGTH.nested_types = {}
PBTALENTMODELSTRENGTH.enum_types = {}
PBTALENTMODELSTRENGTH.fields = {PBTALENTMODELSTRENGTH_PARTNER_ID_FIELD, PBTALENTMODELSTRENGTH_ID_FIELD, PBTALENTMODELSTRENGTH_USE_GOOD_ID_FIELD}
PBTALENTMODELSTRENGTH.is_extendable = false
PBTALENTMODELSTRENGTH.extensions = {}
PBTALENTMODELUP_PARTNER_ID_FIELD.name = "partner_id"
PBTALENTMODELUP_PARTNER_ID_FIELD.full_name = ".pbTalentModelUp.partner_id"
PBTALENTMODELUP_PARTNER_ID_FIELD.number = 1
PBTALENTMODELUP_PARTNER_ID_FIELD.index = 0
PBTALENTMODELUP_PARTNER_ID_FIELD.label = 1
PBTALENTMODELUP_PARTNER_ID_FIELD.has_default_value = false
PBTALENTMODELUP_PARTNER_ID_FIELD.default_value = 0
PBTALENTMODELUP_PARTNER_ID_FIELD.type = 5
PBTALENTMODELUP_PARTNER_ID_FIELD.cpp_type = 1

PBTALENTMODELUP_ID_FIELD.name = "id"
PBTALENTMODELUP_ID_FIELD.full_name = ".pbTalentModelUp.id"
PBTALENTMODELUP_ID_FIELD.number = 2
PBTALENTMODELUP_ID_FIELD.index = 1
PBTALENTMODELUP_ID_FIELD.label = 1
PBTALENTMODELUP_ID_FIELD.has_default_value = false
PBTALENTMODELUP_ID_FIELD.default_value = 0
PBTALENTMODELUP_ID_FIELD.type = 5
PBTALENTMODELUP_ID_FIELD.cpp_type = 1

PBTALENTMODELUP_SEQ_FIELD.name = "seq"
PBTALENTMODELUP_SEQ_FIELD.full_name = ".pbTalentModelUp.seq"
PBTALENTMODELUP_SEQ_FIELD.number = 3
PBTALENTMODELUP_SEQ_FIELD.index = 2
PBTALENTMODELUP_SEQ_FIELD.label = 1
PBTALENTMODELUP_SEQ_FIELD.has_default_value = false
PBTALENTMODELUP_SEQ_FIELD.default_value = 0
PBTALENTMODELUP_SEQ_FIELD.type = 5
PBTALENTMODELUP_SEQ_FIELD.cpp_type = 1

PBTALENTMODELUP_USE_GOOD_ID_FIELD.name = "use_good_id"
PBTALENTMODELUP_USE_GOOD_ID_FIELD.full_name = ".pbTalentModelUp.use_good_id"
PBTALENTMODELUP_USE_GOOD_ID_FIELD.number = 4
PBTALENTMODELUP_USE_GOOD_ID_FIELD.index = 3
PBTALENTMODELUP_USE_GOOD_ID_FIELD.label = 1
PBTALENTMODELUP_USE_GOOD_ID_FIELD.has_default_value = false
PBTALENTMODELUP_USE_GOOD_ID_FIELD.default_value = 0
PBTALENTMODELUP_USE_GOOD_ID_FIELD.type = 5
PBTALENTMODELUP_USE_GOOD_ID_FIELD.cpp_type = 1

PBTALENTMODELUP.name = "pbTalentModelUp"
PBTALENTMODELUP.full_name = ".pbTalentModelUp"
PBTALENTMODELUP.nested_types = {}
PBTALENTMODELUP.enum_types = {}
PBTALENTMODELUP.fields = {PBTALENTMODELUP_PARTNER_ID_FIELD, PBTALENTMODELUP_ID_FIELD, PBTALENTMODELUP_SEQ_FIELD, PBTALENTMODELUP_USE_GOOD_ID_FIELD}
PBTALENTMODELUP.is_extendable = false
PBTALENTMODELUP.extensions = {}
PBTALENTMODELSAVE_PARTNER_ID_FIELD.name = "partner_id"
PBTALENTMODELSAVE_PARTNER_ID_FIELD.full_name = ".pbTalentModelSave.partner_id"
PBTALENTMODELSAVE_PARTNER_ID_FIELD.number = 1
PBTALENTMODELSAVE_PARTNER_ID_FIELD.index = 0
PBTALENTMODELSAVE_PARTNER_ID_FIELD.label = 1
PBTALENTMODELSAVE_PARTNER_ID_FIELD.has_default_value = false
PBTALENTMODELSAVE_PARTNER_ID_FIELD.default_value = 0
PBTALENTMODELSAVE_PARTNER_ID_FIELD.type = 5
PBTALENTMODELSAVE_PARTNER_ID_FIELD.cpp_type = 1

PBTALENTMODELSAVE_ID_FIELD.name = "id"
PBTALENTMODELSAVE_ID_FIELD.full_name = ".pbTalentModelSave.id"
PBTALENTMODELSAVE_ID_FIELD.number = 2
PBTALENTMODELSAVE_ID_FIELD.index = 1
PBTALENTMODELSAVE_ID_FIELD.label = 1
PBTALENTMODELSAVE_ID_FIELD.has_default_value = false
PBTALENTMODELSAVE_ID_FIELD.default_value = 0
PBTALENTMODELSAVE_ID_FIELD.type = 5
PBTALENTMODELSAVE_ID_FIELD.cpp_type = 1

PBTALENTMODELSAVE_ACT_FIELD.name = "act"
PBTALENTMODELSAVE_ACT_FIELD.full_name = ".pbTalentModelSave.act"
PBTALENTMODELSAVE_ACT_FIELD.number = 3
PBTALENTMODELSAVE_ACT_FIELD.index = 2
PBTALENTMODELSAVE_ACT_FIELD.label = 1
PBTALENTMODELSAVE_ACT_FIELD.has_default_value = false
PBTALENTMODELSAVE_ACT_FIELD.default_value = 0
PBTALENTMODELSAVE_ACT_FIELD.type = 5
PBTALENTMODELSAVE_ACT_FIELD.cpp_type = 1

PBTALENTMODELSAVE.name = "pbTalentModelSave"
PBTALENTMODELSAVE.full_name = ".pbTalentModelSave"
PBTALENTMODELSAVE.nested_types = {}
PBTALENTMODELSAVE.enum_types = {}
PBTALENTMODELSAVE.fields = {PBTALENTMODELSAVE_PARTNER_ID_FIELD, PBTALENTMODELSAVE_ID_FIELD, PBTALENTMODELSAVE_ACT_FIELD}
PBTALENTMODELSAVE.is_extendable = false
PBTALENTMODELSAVE.extensions = {}
PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD.name = "add_attribute"
PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD.full_name = ".pbTalentAttributeAdd.add_attribute"
PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD.number = 1
PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD.index = 0
PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD.label = 3
PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD.has_default_value = false
PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD.default_value = {}
PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD.message_type = pb_common_pb.PBATTRIBUTEADD
PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD.type = 11
PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD.cpp_type = 10

PBTALENTATTRIBUTEADD.name = "pbTalentAttributeAdd"
PBTALENTATTRIBUTEADD.full_name = ".pbTalentAttributeAdd"
PBTALENTATTRIBUTEADD.nested_types = {}
PBTALENTATTRIBUTEADD.enum_types = {}
PBTALENTATTRIBUTEADD.fields = {PBTALENTATTRIBUTEADD_ADD_ATTRIBUTE_FIELD}
PBTALENTATTRIBUTEADD.is_extendable = false
PBTALENTATTRIBUTEADD.extensions = {}

pbTalentAttributeAdd = protobuf.Message(PBTALENTATTRIBUTEADD)
pbTalentList = protobuf.Message(PBTALENTLIST)
pbTalentModel = protobuf.Message(PBTALENTMODEL)
pbTalentModelRemove = protobuf.Message(PBTALENTMODELREMOVE)
pbTalentModelSave = protobuf.Message(PBTALENTMODELSAVE)
pbTalentModelStrength = protobuf.Message(PBTALENTMODELSTRENGTH)
pbTalentModelUp = protobuf.Message(PBTALENTMODELUP)
pbTalentModelWear = protobuf.Message(PBTALENTMODELWEAR)
pbTalentSell = protobuf.Message(PBTALENTSELL)

