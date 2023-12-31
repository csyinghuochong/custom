--Generated By protoc-gen-lua Do not Edit
local protobuf = require "protobuf.protobuf"
local pb_common_pb = require("Protol.pb_common_pb")
module('Protol.pb_45_pb')

PBHEROEQUIP = protobuf.Descriptor();
PBHEROEQUIP_POS_FIELD = protobuf.FieldDescriptor();
PBHEROEQUIP_EQUIP_ID_FIELD = protobuf.FieldDescriptor();
PBHEROEQUIP_LV_FIELD = protobuf.FieldDescriptor();
PBHEROEQUIP_QUALITY_FIELD = protobuf.FieldDescriptor();
PBHEROEQUIP_STAR_FIELD = protobuf.FieldDescriptor();
PBHEROGENIUS = protobuf.Descriptor();
PBHEROGENIUS_POS_FIELD = protobuf.FieldDescriptor();
PBHEROGENIUS_GENIUS_ID_FIELD = protobuf.FieldDescriptor();
PBHEROGENIUS_LV_FIELD = protobuf.FieldDescriptor();
PBHEROMARKING = protobuf.Descriptor();
PBHEROMARKING_ID_FIELD = protobuf.FieldDescriptor();
PBHEROMARKING_MARK_ID_FIELD = protobuf.FieldDescriptor();
PBHEROMARKING_MARK_LV_FIELD = protobuf.FieldDescriptor();
PBHEROMARKING_MARK_EXP_FIELD = protobuf.FieldDescriptor();
PBHEROMARKING_MARK_QUALITY_FIELD = protobuf.FieldDescriptor();
PBHEROMARKING_POS_FIELD = protobuf.FieldDescriptor();
PBSKILLINFO = protobuf.Descriptor();
PBSKILLINFO_SKILL_ID_FIELD = protobuf.FieldDescriptor();
PBSKILLINFO_SKILL_LEVEL_FIELD = protobuf.FieldDescriptor();
PBHERO = protobuf.Descriptor();
PBHERO_ID_FIELD = protobuf.FieldDescriptor();
PBHERO_HERO_ID_FIELD = protobuf.FieldDescriptor();
PBHERO_LEVEL_FIELD = protobuf.FieldDescriptor();
PBHERO_STAR_FIELD = protobuf.FieldDescriptor();
PBHERO_QUALITY_FIELD = protobuf.FieldDescriptor();
PBHERO_EXP_FIELD = protobuf.FieldDescriptor();
PBHERO_EQUIPS_FIELD = protobuf.FieldDescriptor();
PBHERO_SKILLS_FIELD = protobuf.FieldDescriptor();
PBHERO_MARKS_FIELD = protobuf.FieldDescriptor();
PBHERO_PLAYER_SKILL_FIELD = protobuf.FieldDescriptor();
PBHERO_GENIUS_FIELD = protobuf.FieldDescriptor();
PBHERO_GENIUS_LV_FIELD = protobuf.FieldDescriptor();
PBHERO_GENIUS_EXP_FIELD = protobuf.FieldDescriptor();
PBHERO_DEED_FIELD = protobuf.FieldDescriptor();
PBHERO_COMBAT_FIELD = protobuf.FieldDescriptor();
PBHERODEED = protobuf.Descriptor();
PBHERODEED_HERO_ID_FIELD = protobuf.FieldDescriptor();
PBHERODEED_DEED_STAR_NUM_FIELD = protobuf.FieldDescriptor();
PBHEROLIST = protobuf.Descriptor();
PBHEROLIST_LIST_FIELD = protobuf.FieldDescriptor();
PBNEWHEROLIST = protobuf.Descriptor();
PBNEWHEROLIST_BATTLE_LIST_FIELD = protobuf.FieldDescriptor();
PBNEWHEROLIST_LIST_FIELD = protobuf.FieldDescriptor();
PBNEWHEROLIST_PLAYER_SKILL_FIELD = protobuf.FieldDescriptor();
PBHEROID = protobuf.Descriptor();
PBHEROID_HERO_ID_FIELD = protobuf.FieldDescriptor();
PBHEROIDS = protobuf.Descriptor();
PBHEROIDS_BATTLE_STATE_FIELD = protobuf.FieldDescriptor();
PBHEROIDS_HERO_ID_FIELD = protobuf.FieldDescriptor();
PBHEROEQUIPID = protobuf.Descriptor();
PBHEROEQUIPID_EQUIP_ID_FIELD = protobuf.FieldDescriptor();
PBHEROWEAREQUIP = protobuf.Descriptor();
PBHEROWEAREQUIP_HERO_ID_FIELD = protobuf.FieldDescriptor();
PBHEROWEAREQUIP_EQUIP_ID_FIELD = protobuf.FieldDescriptor();
PBHEROWEAREQUIP_POS_FIELD = protobuf.FieldDescriptor();
PBHEROUPEQUIP = protobuf.Descriptor();
PBHEROUPEQUIP_HERO_ID_FIELD = protobuf.FieldDescriptor();
PBHEROUPEQUIP_POS_FIELD = protobuf.FieldDescriptor();
PBHEROUPEQUIP_TYPE_FIELD = protobuf.FieldDescriptor();
PBHEROEQUIPUP = protobuf.Descriptor();
PBHEROEQUIPUP_HERO_ID_FIELD = protobuf.FieldDescriptor();
PBHEROEQUIPUP_POS_FIELD = protobuf.FieldDescriptor();
PBHERORESULT = protobuf.Descriptor();
PBHERORESULT_NUM_FIELD = protobuf.FieldDescriptor();
PBHERORESULT_HERO_FIELD = protobuf.FieldDescriptor();
PBHEROUPSKILL = protobuf.Descriptor();
PBHEROUPSKILL_HERO_ID_FIELD = protobuf.FieldDescriptor();
PBHEROUPSKILL_SKILL_ID_FIELD = protobuf.FieldDescriptor();
PBPLAYERUPSKILL = protobuf.Descriptor();
PBPLAYERUPSKILL_SKILL_ID_FIELD = protobuf.FieldDescriptor();

PBHEROEQUIP_POS_FIELD.name = "pos"
PBHEROEQUIP_POS_FIELD.full_name = ".pbHeroEquip.pos"
PBHEROEQUIP_POS_FIELD.number = 1
PBHEROEQUIP_POS_FIELD.index = 0
PBHEROEQUIP_POS_FIELD.label = 1
PBHEROEQUIP_POS_FIELD.has_default_value = false
PBHEROEQUIP_POS_FIELD.default_value = 0
PBHEROEQUIP_POS_FIELD.type = 5
PBHEROEQUIP_POS_FIELD.cpp_type = 1

PBHEROEQUIP_EQUIP_ID_FIELD.name = "equip_id"
PBHEROEQUIP_EQUIP_ID_FIELD.full_name = ".pbHeroEquip.equip_id"
PBHEROEQUIP_EQUIP_ID_FIELD.number = 2
PBHEROEQUIP_EQUIP_ID_FIELD.index = 1
PBHEROEQUIP_EQUIP_ID_FIELD.label = 1
PBHEROEQUIP_EQUIP_ID_FIELD.has_default_value = false
PBHEROEQUIP_EQUIP_ID_FIELD.default_value = 0
PBHEROEQUIP_EQUIP_ID_FIELD.type = 5
PBHEROEQUIP_EQUIP_ID_FIELD.cpp_type = 1

PBHEROEQUIP_LV_FIELD.name = "lv"
PBHEROEQUIP_LV_FIELD.full_name = ".pbHeroEquip.lv"
PBHEROEQUIP_LV_FIELD.number = 3
PBHEROEQUIP_LV_FIELD.index = 2
PBHEROEQUIP_LV_FIELD.label = 1
PBHEROEQUIP_LV_FIELD.has_default_value = false
PBHEROEQUIP_LV_FIELD.default_value = 0
PBHEROEQUIP_LV_FIELD.type = 5
PBHEROEQUIP_LV_FIELD.cpp_type = 1

PBHEROEQUIP_QUALITY_FIELD.name = "quality"
PBHEROEQUIP_QUALITY_FIELD.full_name = ".pbHeroEquip.quality"
PBHEROEQUIP_QUALITY_FIELD.number = 4
PBHEROEQUIP_QUALITY_FIELD.index = 3
PBHEROEQUIP_QUALITY_FIELD.label = 1
PBHEROEQUIP_QUALITY_FIELD.has_default_value = false
PBHEROEQUIP_QUALITY_FIELD.default_value = 0
PBHEROEQUIP_QUALITY_FIELD.type = 5
PBHEROEQUIP_QUALITY_FIELD.cpp_type = 1

PBHEROEQUIP_STAR_FIELD.name = "star"
PBHEROEQUIP_STAR_FIELD.full_name = ".pbHeroEquip.star"
PBHEROEQUIP_STAR_FIELD.number = 5
PBHEROEQUIP_STAR_FIELD.index = 4
PBHEROEQUIP_STAR_FIELD.label = 1
PBHEROEQUIP_STAR_FIELD.has_default_value = false
PBHEROEQUIP_STAR_FIELD.default_value = 0
PBHEROEQUIP_STAR_FIELD.type = 5
PBHEROEQUIP_STAR_FIELD.cpp_type = 1

PBHEROEQUIP.name = "pbHeroEquip"
PBHEROEQUIP.full_name = ".pbHeroEquip"
PBHEROEQUIP.nested_types = {}
PBHEROEQUIP.enum_types = {}
PBHEROEQUIP.fields = {PBHEROEQUIP_POS_FIELD, PBHEROEQUIP_EQUIP_ID_FIELD, PBHEROEQUIP_LV_FIELD, PBHEROEQUIP_QUALITY_FIELD, PBHEROEQUIP_STAR_FIELD}
PBHEROEQUIP.is_extendable = false
PBHEROEQUIP.extensions = {}
PBHEROGENIUS_POS_FIELD.name = "pos"
PBHEROGENIUS_POS_FIELD.full_name = ".pbHeroGenius.pos"
PBHEROGENIUS_POS_FIELD.number = 1
PBHEROGENIUS_POS_FIELD.index = 0
PBHEROGENIUS_POS_FIELD.label = 1
PBHEROGENIUS_POS_FIELD.has_default_value = false
PBHEROGENIUS_POS_FIELD.default_value = 0
PBHEROGENIUS_POS_FIELD.type = 5
PBHEROGENIUS_POS_FIELD.cpp_type = 1

PBHEROGENIUS_GENIUS_ID_FIELD.name = "genius_id"
PBHEROGENIUS_GENIUS_ID_FIELD.full_name = ".pbHeroGenius.genius_id"
PBHEROGENIUS_GENIUS_ID_FIELD.number = 2
PBHEROGENIUS_GENIUS_ID_FIELD.index = 1
PBHEROGENIUS_GENIUS_ID_FIELD.label = 1
PBHEROGENIUS_GENIUS_ID_FIELD.has_default_value = false
PBHEROGENIUS_GENIUS_ID_FIELD.default_value = 0
PBHEROGENIUS_GENIUS_ID_FIELD.type = 5
PBHEROGENIUS_GENIUS_ID_FIELD.cpp_type = 1

PBHEROGENIUS_LV_FIELD.name = "lv"
PBHEROGENIUS_LV_FIELD.full_name = ".pbHeroGenius.lv"
PBHEROGENIUS_LV_FIELD.number = 3
PBHEROGENIUS_LV_FIELD.index = 2
PBHEROGENIUS_LV_FIELD.label = 1
PBHEROGENIUS_LV_FIELD.has_default_value = false
PBHEROGENIUS_LV_FIELD.default_value = 0
PBHEROGENIUS_LV_FIELD.type = 5
PBHEROGENIUS_LV_FIELD.cpp_type = 1

PBHEROGENIUS.name = "pbHeroGenius"
PBHEROGENIUS.full_name = ".pbHeroGenius"
PBHEROGENIUS.nested_types = {}
PBHEROGENIUS.enum_types = {}
PBHEROGENIUS.fields = {PBHEROGENIUS_POS_FIELD, PBHEROGENIUS_GENIUS_ID_FIELD, PBHEROGENIUS_LV_FIELD}
PBHEROGENIUS.is_extendable = false
PBHEROGENIUS.extensions = {}
PBHEROMARKING_ID_FIELD.name = "id"
PBHEROMARKING_ID_FIELD.full_name = ".pbHeroMarking.id"
PBHEROMARKING_ID_FIELD.number = 1
PBHEROMARKING_ID_FIELD.index = 0
PBHEROMARKING_ID_FIELD.label = 1
PBHEROMARKING_ID_FIELD.has_default_value = false
PBHEROMARKING_ID_FIELD.default_value = 0
PBHEROMARKING_ID_FIELD.type = 5
PBHEROMARKING_ID_FIELD.cpp_type = 1

PBHEROMARKING_MARK_ID_FIELD.name = "mark_id"
PBHEROMARKING_MARK_ID_FIELD.full_name = ".pbHeroMarking.mark_id"
PBHEROMARKING_MARK_ID_FIELD.number = 2
PBHEROMARKING_MARK_ID_FIELD.index = 1
PBHEROMARKING_MARK_ID_FIELD.label = 1
PBHEROMARKING_MARK_ID_FIELD.has_default_value = false
PBHEROMARKING_MARK_ID_FIELD.default_value = 0
PBHEROMARKING_MARK_ID_FIELD.type = 5
PBHEROMARKING_MARK_ID_FIELD.cpp_type = 1

PBHEROMARKING_MARK_LV_FIELD.name = "mark_lv"
PBHEROMARKING_MARK_LV_FIELD.full_name = ".pbHeroMarking.mark_lv"
PBHEROMARKING_MARK_LV_FIELD.number = 3
PBHEROMARKING_MARK_LV_FIELD.index = 2
PBHEROMARKING_MARK_LV_FIELD.label = 1
PBHEROMARKING_MARK_LV_FIELD.has_default_value = false
PBHEROMARKING_MARK_LV_FIELD.default_value = 0
PBHEROMARKING_MARK_LV_FIELD.type = 5
PBHEROMARKING_MARK_LV_FIELD.cpp_type = 1

PBHEROMARKING_MARK_EXP_FIELD.name = "mark_exp"
PBHEROMARKING_MARK_EXP_FIELD.full_name = ".pbHeroMarking.mark_exp"
PBHEROMARKING_MARK_EXP_FIELD.number = 4
PBHEROMARKING_MARK_EXP_FIELD.index = 3
PBHEROMARKING_MARK_EXP_FIELD.label = 1
PBHEROMARKING_MARK_EXP_FIELD.has_default_value = false
PBHEROMARKING_MARK_EXP_FIELD.default_value = 0
PBHEROMARKING_MARK_EXP_FIELD.type = 5
PBHEROMARKING_MARK_EXP_FIELD.cpp_type = 1

PBHEROMARKING_MARK_QUALITY_FIELD.name = "mark_quality"
PBHEROMARKING_MARK_QUALITY_FIELD.full_name = ".pbHeroMarking.mark_quality"
PBHEROMARKING_MARK_QUALITY_FIELD.number = 5
PBHEROMARKING_MARK_QUALITY_FIELD.index = 4
PBHEROMARKING_MARK_QUALITY_FIELD.label = 1
PBHEROMARKING_MARK_QUALITY_FIELD.has_default_value = false
PBHEROMARKING_MARK_QUALITY_FIELD.default_value = 0
PBHEROMARKING_MARK_QUALITY_FIELD.type = 5
PBHEROMARKING_MARK_QUALITY_FIELD.cpp_type = 1

PBHEROMARKING_POS_FIELD.name = "pos"
PBHEROMARKING_POS_FIELD.full_name = ".pbHeroMarking.pos"
PBHEROMARKING_POS_FIELD.number = 6
PBHEROMARKING_POS_FIELD.index = 5
PBHEROMARKING_POS_FIELD.label = 1
PBHEROMARKING_POS_FIELD.has_default_value = false
PBHEROMARKING_POS_FIELD.default_value = 0
PBHEROMARKING_POS_FIELD.type = 5
PBHEROMARKING_POS_FIELD.cpp_type = 1

PBHEROMARKING.name = "pbHeroMarking"
PBHEROMARKING.full_name = ".pbHeroMarking"
PBHEROMARKING.nested_types = {}
PBHEROMARKING.enum_types = {}
PBHEROMARKING.fields = {PBHEROMARKING_ID_FIELD, PBHEROMARKING_MARK_ID_FIELD, PBHEROMARKING_MARK_LV_FIELD, PBHEROMARKING_MARK_EXP_FIELD, PBHEROMARKING_MARK_QUALITY_FIELD, PBHEROMARKING_POS_FIELD}
PBHEROMARKING.is_extendable = false
PBHEROMARKING.extensions = {}
PBSKILLINFO_SKILL_ID_FIELD.name = "skill_id"
PBSKILLINFO_SKILL_ID_FIELD.full_name = ".pbSkillInfo.skill_id"
PBSKILLINFO_SKILL_ID_FIELD.number = 1
PBSKILLINFO_SKILL_ID_FIELD.index = 0
PBSKILLINFO_SKILL_ID_FIELD.label = 1
PBSKILLINFO_SKILL_ID_FIELD.has_default_value = false
PBSKILLINFO_SKILL_ID_FIELD.default_value = 0
PBSKILLINFO_SKILL_ID_FIELD.type = 5
PBSKILLINFO_SKILL_ID_FIELD.cpp_type = 1

PBSKILLINFO_SKILL_LEVEL_FIELD.name = "skill_level"
PBSKILLINFO_SKILL_LEVEL_FIELD.full_name = ".pbSkillInfo.skill_level"
PBSKILLINFO_SKILL_LEVEL_FIELD.number = 2
PBSKILLINFO_SKILL_LEVEL_FIELD.index = 1
PBSKILLINFO_SKILL_LEVEL_FIELD.label = 1
PBSKILLINFO_SKILL_LEVEL_FIELD.has_default_value = false
PBSKILLINFO_SKILL_LEVEL_FIELD.default_value = 0
PBSKILLINFO_SKILL_LEVEL_FIELD.type = 5
PBSKILLINFO_SKILL_LEVEL_FIELD.cpp_type = 1

PBSKILLINFO.name = "pbSkillInfo"
PBSKILLINFO.full_name = ".pbSkillInfo"
PBSKILLINFO.nested_types = {}
PBSKILLINFO.enum_types = {}
PBSKILLINFO.fields = {PBSKILLINFO_SKILL_ID_FIELD, PBSKILLINFO_SKILL_LEVEL_FIELD}
PBSKILLINFO.is_extendable = false
PBSKILLINFO.extensions = {}
PBHERO_ID_FIELD.name = "id"
PBHERO_ID_FIELD.full_name = ".pbHero.id"
PBHERO_ID_FIELD.number = 1
PBHERO_ID_FIELD.index = 0
PBHERO_ID_FIELD.label = 1
PBHERO_ID_FIELD.has_default_value = false
PBHERO_ID_FIELD.default_value = 0
PBHERO_ID_FIELD.type = 3
PBHERO_ID_FIELD.cpp_type = 2

PBHERO_HERO_ID_FIELD.name = "hero_id"
PBHERO_HERO_ID_FIELD.full_name = ".pbHero.hero_id"
PBHERO_HERO_ID_FIELD.number = 2
PBHERO_HERO_ID_FIELD.index = 1
PBHERO_HERO_ID_FIELD.label = 1
PBHERO_HERO_ID_FIELD.has_default_value = false
PBHERO_HERO_ID_FIELD.default_value = 0
PBHERO_HERO_ID_FIELD.type = 5
PBHERO_HERO_ID_FIELD.cpp_type = 1

PBHERO_LEVEL_FIELD.name = "level"
PBHERO_LEVEL_FIELD.full_name = ".pbHero.level"
PBHERO_LEVEL_FIELD.number = 3
PBHERO_LEVEL_FIELD.index = 2
PBHERO_LEVEL_FIELD.label = 1
PBHERO_LEVEL_FIELD.has_default_value = false
PBHERO_LEVEL_FIELD.default_value = 0
PBHERO_LEVEL_FIELD.type = 5
PBHERO_LEVEL_FIELD.cpp_type = 1

PBHERO_STAR_FIELD.name = "star"
PBHERO_STAR_FIELD.full_name = ".pbHero.star"
PBHERO_STAR_FIELD.number = 4
PBHERO_STAR_FIELD.index = 3
PBHERO_STAR_FIELD.label = 1
PBHERO_STAR_FIELD.has_default_value = false
PBHERO_STAR_FIELD.default_value = 0
PBHERO_STAR_FIELD.type = 5
PBHERO_STAR_FIELD.cpp_type = 1

PBHERO_QUALITY_FIELD.name = "quality"
PBHERO_QUALITY_FIELD.full_name = ".pbHero.quality"
PBHERO_QUALITY_FIELD.number = 5
PBHERO_QUALITY_FIELD.index = 4
PBHERO_QUALITY_FIELD.label = 1
PBHERO_QUALITY_FIELD.has_default_value = false
PBHERO_QUALITY_FIELD.default_value = 0
PBHERO_QUALITY_FIELD.type = 5
PBHERO_QUALITY_FIELD.cpp_type = 1

PBHERO_EXP_FIELD.name = "exp"
PBHERO_EXP_FIELD.full_name = ".pbHero.exp"
PBHERO_EXP_FIELD.number = 6
PBHERO_EXP_FIELD.index = 5
PBHERO_EXP_FIELD.label = 1
PBHERO_EXP_FIELD.has_default_value = false
PBHERO_EXP_FIELD.default_value = 0
PBHERO_EXP_FIELD.type = 5
PBHERO_EXP_FIELD.cpp_type = 1

PBHERO_EQUIPS_FIELD.name = "equips"
PBHERO_EQUIPS_FIELD.full_name = ".pbHero.equips"
PBHERO_EQUIPS_FIELD.number = 7
PBHERO_EQUIPS_FIELD.index = 6
PBHERO_EQUIPS_FIELD.label = 3
PBHERO_EQUIPS_FIELD.has_default_value = false
PBHERO_EQUIPS_FIELD.default_value = {}
PBHERO_EQUIPS_FIELD.message_type = PBHEROEQUIP
PBHERO_EQUIPS_FIELD.type = 11
PBHERO_EQUIPS_FIELD.cpp_type = 10

PBHERO_SKILLS_FIELD.name = "skills"
PBHERO_SKILLS_FIELD.full_name = ".pbHero.skills"
PBHERO_SKILLS_FIELD.number = 8
PBHERO_SKILLS_FIELD.index = 7
PBHERO_SKILLS_FIELD.label = 3
PBHERO_SKILLS_FIELD.has_default_value = false
PBHERO_SKILLS_FIELD.default_value = {}
PBHERO_SKILLS_FIELD.message_type = PBSKILLINFO
PBHERO_SKILLS_FIELD.type = 11
PBHERO_SKILLS_FIELD.cpp_type = 10

PBHERO_MARKS_FIELD.name = "marks"
PBHERO_MARKS_FIELD.full_name = ".pbHero.marks"
PBHERO_MARKS_FIELD.number = 9
PBHERO_MARKS_FIELD.index = 8
PBHERO_MARKS_FIELD.label = 3
PBHERO_MARKS_FIELD.has_default_value = false
PBHERO_MARKS_FIELD.default_value = {}
PBHERO_MARKS_FIELD.message_type = PBHEROMARKING
PBHERO_MARKS_FIELD.type = 11
PBHERO_MARKS_FIELD.cpp_type = 10

PBHERO_PLAYER_SKILL_FIELD.name = "player_skill"
PBHERO_PLAYER_SKILL_FIELD.full_name = ".pbHero.player_skill"
PBHERO_PLAYER_SKILL_FIELD.number = 10
PBHERO_PLAYER_SKILL_FIELD.index = 9
PBHERO_PLAYER_SKILL_FIELD.label = 1
PBHERO_PLAYER_SKILL_FIELD.has_default_value = false
PBHERO_PLAYER_SKILL_FIELD.default_value = 0
PBHERO_PLAYER_SKILL_FIELD.type = 5
PBHERO_PLAYER_SKILL_FIELD.cpp_type = 1

PBHERO_GENIUS_FIELD.name = "genius"
PBHERO_GENIUS_FIELD.full_name = ".pbHero.genius"
PBHERO_GENIUS_FIELD.number = 11
PBHERO_GENIUS_FIELD.index = 10
PBHERO_GENIUS_FIELD.label = 3
PBHERO_GENIUS_FIELD.has_default_value = false
PBHERO_GENIUS_FIELD.default_value = {}
PBHERO_GENIUS_FIELD.message_type = PBHEROGENIUS
PBHERO_GENIUS_FIELD.type = 11
PBHERO_GENIUS_FIELD.cpp_type = 10

PBHERO_GENIUS_LV_FIELD.name = "genius_lv"
PBHERO_GENIUS_LV_FIELD.full_name = ".pbHero.genius_lv"
PBHERO_GENIUS_LV_FIELD.number = 12
PBHERO_GENIUS_LV_FIELD.index = 11
PBHERO_GENIUS_LV_FIELD.label = 1
PBHERO_GENIUS_LV_FIELD.has_default_value = false
PBHERO_GENIUS_LV_FIELD.default_value = 0
PBHERO_GENIUS_LV_FIELD.type = 5
PBHERO_GENIUS_LV_FIELD.cpp_type = 1

PBHERO_GENIUS_EXP_FIELD.name = "genius_exp"
PBHERO_GENIUS_EXP_FIELD.full_name = ".pbHero.genius_exp"
PBHERO_GENIUS_EXP_FIELD.number = 13
PBHERO_GENIUS_EXP_FIELD.index = 12
PBHERO_GENIUS_EXP_FIELD.label = 1
PBHERO_GENIUS_EXP_FIELD.has_default_value = false
PBHERO_GENIUS_EXP_FIELD.default_value = 0
PBHERO_GENIUS_EXP_FIELD.type = 5
PBHERO_GENIUS_EXP_FIELD.cpp_type = 1

PBHERO_DEED_FIELD.name = "deed"
PBHERO_DEED_FIELD.full_name = ".pbHero.deed"
PBHERO_DEED_FIELD.number = 14
PBHERO_DEED_FIELD.index = 13
PBHERO_DEED_FIELD.label = 3
PBHERO_DEED_FIELD.has_default_value = false
PBHERO_DEED_FIELD.default_value = {}
PBHERO_DEED_FIELD.message_type = PBHERODEED
PBHERO_DEED_FIELD.type = 11
PBHERO_DEED_FIELD.cpp_type = 10

PBHERO_COMBAT_FIELD.name = "combat"
PBHERO_COMBAT_FIELD.full_name = ".pbHero.combat"
PBHERO_COMBAT_FIELD.number = 15
PBHERO_COMBAT_FIELD.index = 14
PBHERO_COMBAT_FIELD.label = 1
PBHERO_COMBAT_FIELD.has_default_value = false
PBHERO_COMBAT_FIELD.default_value = 0
PBHERO_COMBAT_FIELD.type = 5
PBHERO_COMBAT_FIELD.cpp_type = 1

PBHERO.name = "pbHero"
PBHERO.full_name = ".pbHero"
PBHERO.nested_types = {}
PBHERO.enum_types = {}
PBHERO.fields = {PBHERO_ID_FIELD, PBHERO_HERO_ID_FIELD, PBHERO_LEVEL_FIELD, PBHERO_STAR_FIELD, PBHERO_QUALITY_FIELD, PBHERO_EXP_FIELD, PBHERO_EQUIPS_FIELD, PBHERO_SKILLS_FIELD, PBHERO_MARKS_FIELD, PBHERO_PLAYER_SKILL_FIELD, PBHERO_GENIUS_FIELD, PBHERO_GENIUS_LV_FIELD, PBHERO_GENIUS_EXP_FIELD, PBHERO_DEED_FIELD, PBHERO_COMBAT_FIELD}
PBHERO.is_extendable = false
PBHERO.extensions = {}
PBHERODEED_HERO_ID_FIELD.name = "hero_id"
PBHERODEED_HERO_ID_FIELD.full_name = ".pbHeroDeed.hero_id"
PBHERODEED_HERO_ID_FIELD.number = 1
PBHERODEED_HERO_ID_FIELD.index = 0
PBHERODEED_HERO_ID_FIELD.label = 1
PBHERODEED_HERO_ID_FIELD.has_default_value = false
PBHERODEED_HERO_ID_FIELD.default_value = 0
PBHERODEED_HERO_ID_FIELD.type = 5
PBHERODEED_HERO_ID_FIELD.cpp_type = 1

PBHERODEED_DEED_STAR_NUM_FIELD.name = "deed_star_num"
PBHERODEED_DEED_STAR_NUM_FIELD.full_name = ".pbHeroDeed.deed_star_num"
PBHERODEED_DEED_STAR_NUM_FIELD.number = 2
PBHERODEED_DEED_STAR_NUM_FIELD.index = 1
PBHERODEED_DEED_STAR_NUM_FIELD.label = 1
PBHERODEED_DEED_STAR_NUM_FIELD.has_default_value = false
PBHERODEED_DEED_STAR_NUM_FIELD.default_value = 0
PBHERODEED_DEED_STAR_NUM_FIELD.type = 5
PBHERODEED_DEED_STAR_NUM_FIELD.cpp_type = 1

PBHERODEED.name = "pbHeroDeed"
PBHERODEED.full_name = ".pbHeroDeed"
PBHERODEED.nested_types = {}
PBHERODEED.enum_types = {}
PBHERODEED.fields = {PBHERODEED_HERO_ID_FIELD, PBHERODEED_DEED_STAR_NUM_FIELD}
PBHERODEED.is_extendable = false
PBHERODEED.extensions = {}
PBHEROLIST_LIST_FIELD.name = "list"
PBHEROLIST_LIST_FIELD.full_name = ".pbHeroList.list"
PBHEROLIST_LIST_FIELD.number = 1
PBHEROLIST_LIST_FIELD.index = 0
PBHEROLIST_LIST_FIELD.label = 3
PBHEROLIST_LIST_FIELD.has_default_value = false
PBHEROLIST_LIST_FIELD.default_value = {}
PBHEROLIST_LIST_FIELD.message_type = PBHERO
PBHEROLIST_LIST_FIELD.type = 11
PBHEROLIST_LIST_FIELD.cpp_type = 10

PBHEROLIST.name = "pbHeroList"
PBHEROLIST.full_name = ".pbHeroList"
PBHEROLIST.nested_types = {}
PBHEROLIST.enum_types = {}
PBHEROLIST.fields = {PBHEROLIST_LIST_FIELD}
PBHEROLIST.is_extendable = false
PBHEROLIST.extensions = {}
PBNEWHEROLIST_BATTLE_LIST_FIELD.name = "battle_list"
PBNEWHEROLIST_BATTLE_LIST_FIELD.full_name = ".pbNewHeroList.battle_list"
PBNEWHEROLIST_BATTLE_LIST_FIELD.number = 1
PBNEWHEROLIST_BATTLE_LIST_FIELD.index = 0
PBNEWHEROLIST_BATTLE_LIST_FIELD.label = 3
PBNEWHEROLIST_BATTLE_LIST_FIELD.has_default_value = false
PBNEWHEROLIST_BATTLE_LIST_FIELD.default_value = {}
PBNEWHEROLIST_BATTLE_LIST_FIELD.message_type = PBHEROIDS
PBNEWHEROLIST_BATTLE_LIST_FIELD.type = 11
PBNEWHEROLIST_BATTLE_LIST_FIELD.cpp_type = 10

PBNEWHEROLIST_LIST_FIELD.name = "list"
PBNEWHEROLIST_LIST_FIELD.full_name = ".pbNewHeroList.list"
PBNEWHEROLIST_LIST_FIELD.number = 2
PBNEWHEROLIST_LIST_FIELD.index = 1
PBNEWHEROLIST_LIST_FIELD.label = 3
PBNEWHEROLIST_LIST_FIELD.has_default_value = false
PBNEWHEROLIST_LIST_FIELD.default_value = {}
PBNEWHEROLIST_LIST_FIELD.message_type = PBHERO
PBNEWHEROLIST_LIST_FIELD.type = 11
PBNEWHEROLIST_LIST_FIELD.cpp_type = 10

PBNEWHEROLIST_PLAYER_SKILL_FIELD.name = "player_skill"
PBNEWHEROLIST_PLAYER_SKILL_FIELD.full_name = ".pbNewHeroList.player_skill"
PBNEWHEROLIST_PLAYER_SKILL_FIELD.number = 3
PBNEWHEROLIST_PLAYER_SKILL_FIELD.index = 2
PBNEWHEROLIST_PLAYER_SKILL_FIELD.label = 3
PBNEWHEROLIST_PLAYER_SKILL_FIELD.has_default_value = false
PBNEWHEROLIST_PLAYER_SKILL_FIELD.default_value = {}
PBNEWHEROLIST_PLAYER_SKILL_FIELD.message_type = PBSKILLINFO
PBNEWHEROLIST_PLAYER_SKILL_FIELD.type = 11
PBNEWHEROLIST_PLAYER_SKILL_FIELD.cpp_type = 10

PBNEWHEROLIST.name = "pbNewHeroList"
PBNEWHEROLIST.full_name = ".pbNewHeroList"
PBNEWHEROLIST.nested_types = {}
PBNEWHEROLIST.enum_types = {}
PBNEWHEROLIST.fields = {PBNEWHEROLIST_BATTLE_LIST_FIELD, PBNEWHEROLIST_LIST_FIELD, PBNEWHEROLIST_PLAYER_SKILL_FIELD}
PBNEWHEROLIST.is_extendable = false
PBNEWHEROLIST.extensions = {}
PBHEROID_HERO_ID_FIELD.name = "hero_id"
PBHEROID_HERO_ID_FIELD.full_name = ".pbHeroId.hero_id"
PBHEROID_HERO_ID_FIELD.number = 1
PBHEROID_HERO_ID_FIELD.index = 0
PBHEROID_HERO_ID_FIELD.label = 1
PBHEROID_HERO_ID_FIELD.has_default_value = false
PBHEROID_HERO_ID_FIELD.default_value = 0
PBHEROID_HERO_ID_FIELD.type = 5
PBHEROID_HERO_ID_FIELD.cpp_type = 1

PBHEROID.name = "pbHeroId"
PBHEROID.full_name = ".pbHeroId"
PBHEROID.nested_types = {}
PBHEROID.enum_types = {}
PBHEROID.fields = {PBHEROID_HERO_ID_FIELD}
PBHEROID.is_extendable = false
PBHEROID.extensions = {}
PBHEROIDS_BATTLE_STATE_FIELD.name = "battle_state"
PBHEROIDS_BATTLE_STATE_FIELD.full_name = ".pbHeroIds.battle_state"
PBHEROIDS_BATTLE_STATE_FIELD.number = 1
PBHEROIDS_BATTLE_STATE_FIELD.index = 0
PBHEROIDS_BATTLE_STATE_FIELD.label = 1
PBHEROIDS_BATTLE_STATE_FIELD.has_default_value = false
PBHEROIDS_BATTLE_STATE_FIELD.default_value = 0
PBHEROIDS_BATTLE_STATE_FIELD.type = 5
PBHEROIDS_BATTLE_STATE_FIELD.cpp_type = 1

PBHEROIDS_HERO_ID_FIELD.name = "hero_id"
PBHEROIDS_HERO_ID_FIELD.full_name = ".pbHeroIds.hero_id"
PBHEROIDS_HERO_ID_FIELD.number = 2
PBHEROIDS_HERO_ID_FIELD.index = 1
PBHEROIDS_HERO_ID_FIELD.label = 3
PBHEROIDS_HERO_ID_FIELD.has_default_value = false
PBHEROIDS_HERO_ID_FIELD.default_value = {}
PBHEROIDS_HERO_ID_FIELD.type = 5
PBHEROIDS_HERO_ID_FIELD.cpp_type = 1

PBHEROIDS.name = "pbHeroIds"
PBHEROIDS.full_name = ".pbHeroIds"
PBHEROIDS.nested_types = {}
PBHEROIDS.enum_types = {}
PBHEROIDS.fields = {PBHEROIDS_BATTLE_STATE_FIELD, PBHEROIDS_HERO_ID_FIELD}
PBHEROIDS.is_extendable = false
PBHEROIDS.extensions = {}
PBHEROEQUIPID_EQUIP_ID_FIELD.name = "equip_id"
PBHEROEQUIPID_EQUIP_ID_FIELD.full_name = ".pbHeroEquipId.equip_id"
PBHEROEQUIPID_EQUIP_ID_FIELD.number = 1
PBHEROEQUIPID_EQUIP_ID_FIELD.index = 0
PBHEROEQUIPID_EQUIP_ID_FIELD.label = 1
PBHEROEQUIPID_EQUIP_ID_FIELD.has_default_value = false
PBHEROEQUIPID_EQUIP_ID_FIELD.default_value = 0
PBHEROEQUIPID_EQUIP_ID_FIELD.type = 5
PBHEROEQUIPID_EQUIP_ID_FIELD.cpp_type = 1

PBHEROEQUIPID.name = "pbHeroEquipId"
PBHEROEQUIPID.full_name = ".pbHeroEquipId"
PBHEROEQUIPID.nested_types = {}
PBHEROEQUIPID.enum_types = {}
PBHEROEQUIPID.fields = {PBHEROEQUIPID_EQUIP_ID_FIELD}
PBHEROEQUIPID.is_extendable = false
PBHEROEQUIPID.extensions = {}
PBHEROWEAREQUIP_HERO_ID_FIELD.name = "hero_id"
PBHEROWEAREQUIP_HERO_ID_FIELD.full_name = ".pbHeroWearEquip.hero_id"
PBHEROWEAREQUIP_HERO_ID_FIELD.number = 1
PBHEROWEAREQUIP_HERO_ID_FIELD.index = 0
PBHEROWEAREQUIP_HERO_ID_FIELD.label = 1
PBHEROWEAREQUIP_HERO_ID_FIELD.has_default_value = false
PBHEROWEAREQUIP_HERO_ID_FIELD.default_value = 0
PBHEROWEAREQUIP_HERO_ID_FIELD.type = 5
PBHEROWEAREQUIP_HERO_ID_FIELD.cpp_type = 1

PBHEROWEAREQUIP_EQUIP_ID_FIELD.name = "equip_id"
PBHEROWEAREQUIP_EQUIP_ID_FIELD.full_name = ".pbHeroWearEquip.equip_id"
PBHEROWEAREQUIP_EQUIP_ID_FIELD.number = 2
PBHEROWEAREQUIP_EQUIP_ID_FIELD.index = 1
PBHEROWEAREQUIP_EQUIP_ID_FIELD.label = 1
PBHEROWEAREQUIP_EQUIP_ID_FIELD.has_default_value = false
PBHEROWEAREQUIP_EQUIP_ID_FIELD.default_value = 0
PBHEROWEAREQUIP_EQUIP_ID_FIELD.type = 5
PBHEROWEAREQUIP_EQUIP_ID_FIELD.cpp_type = 1

PBHEROWEAREQUIP_POS_FIELD.name = "pos"
PBHEROWEAREQUIP_POS_FIELD.full_name = ".pbHeroWearEquip.pos"
PBHEROWEAREQUIP_POS_FIELD.number = 3
PBHEROWEAREQUIP_POS_FIELD.index = 2
PBHEROWEAREQUIP_POS_FIELD.label = 1
PBHEROWEAREQUIP_POS_FIELD.has_default_value = false
PBHEROWEAREQUIP_POS_FIELD.default_value = 0
PBHEROWEAREQUIP_POS_FIELD.type = 5
PBHEROWEAREQUIP_POS_FIELD.cpp_type = 1

PBHEROWEAREQUIP.name = "pbHeroWearEquip"
PBHEROWEAREQUIP.full_name = ".pbHeroWearEquip"
PBHEROWEAREQUIP.nested_types = {}
PBHEROWEAREQUIP.enum_types = {}
PBHEROWEAREQUIP.fields = {PBHEROWEAREQUIP_HERO_ID_FIELD, PBHEROWEAREQUIP_EQUIP_ID_FIELD, PBHEROWEAREQUIP_POS_FIELD}
PBHEROWEAREQUIP.is_extendable = false
PBHEROWEAREQUIP.extensions = {}
PBHEROUPEQUIP_HERO_ID_FIELD.name = "hero_id"
PBHEROUPEQUIP_HERO_ID_FIELD.full_name = ".pbHeroUpEquip.hero_id"
PBHEROUPEQUIP_HERO_ID_FIELD.number = 1
PBHEROUPEQUIP_HERO_ID_FIELD.index = 0
PBHEROUPEQUIP_HERO_ID_FIELD.label = 1
PBHEROUPEQUIP_HERO_ID_FIELD.has_default_value = false
PBHEROUPEQUIP_HERO_ID_FIELD.default_value = 0
PBHEROUPEQUIP_HERO_ID_FIELD.type = 5
PBHEROUPEQUIP_HERO_ID_FIELD.cpp_type = 1

PBHEROUPEQUIP_POS_FIELD.name = "pos"
PBHEROUPEQUIP_POS_FIELD.full_name = ".pbHeroUpEquip.pos"
PBHEROUPEQUIP_POS_FIELD.number = 2
PBHEROUPEQUIP_POS_FIELD.index = 1
PBHEROUPEQUIP_POS_FIELD.label = 1
PBHEROUPEQUIP_POS_FIELD.has_default_value = false
PBHEROUPEQUIP_POS_FIELD.default_value = 0
PBHEROUPEQUIP_POS_FIELD.type = 5
PBHEROUPEQUIP_POS_FIELD.cpp_type = 1

PBHEROUPEQUIP_TYPE_FIELD.name = "type"
PBHEROUPEQUIP_TYPE_FIELD.full_name = ".pbHeroUpEquip.type"
PBHEROUPEQUIP_TYPE_FIELD.number = 3
PBHEROUPEQUIP_TYPE_FIELD.index = 2
PBHEROUPEQUIP_TYPE_FIELD.label = 1
PBHEROUPEQUIP_TYPE_FIELD.has_default_value = false
PBHEROUPEQUIP_TYPE_FIELD.default_value = 0
PBHEROUPEQUIP_TYPE_FIELD.type = 5
PBHEROUPEQUIP_TYPE_FIELD.cpp_type = 1

PBHEROUPEQUIP.name = "pbHeroUpEquip"
PBHEROUPEQUIP.full_name = ".pbHeroUpEquip"
PBHEROUPEQUIP.nested_types = {}
PBHEROUPEQUIP.enum_types = {}
PBHEROUPEQUIP.fields = {PBHEROUPEQUIP_HERO_ID_FIELD, PBHEROUPEQUIP_POS_FIELD, PBHEROUPEQUIP_TYPE_FIELD}
PBHEROUPEQUIP.is_extendable = false
PBHEROUPEQUIP.extensions = {}
PBHEROEQUIPUP_HERO_ID_FIELD.name = "hero_id"
PBHEROEQUIPUP_HERO_ID_FIELD.full_name = ".pbHeroEquipUp.hero_id"
PBHEROEQUIPUP_HERO_ID_FIELD.number = 1
PBHEROEQUIPUP_HERO_ID_FIELD.index = 0
PBHEROEQUIPUP_HERO_ID_FIELD.label = 1
PBHEROEQUIPUP_HERO_ID_FIELD.has_default_value = false
PBHEROEQUIPUP_HERO_ID_FIELD.default_value = 0
PBHEROEQUIPUP_HERO_ID_FIELD.type = 5
PBHEROEQUIPUP_HERO_ID_FIELD.cpp_type = 1

PBHEROEQUIPUP_POS_FIELD.name = "pos"
PBHEROEQUIPUP_POS_FIELD.full_name = ".pbHeroEquipUp.pos"
PBHEROEQUIPUP_POS_FIELD.number = 2
PBHEROEQUIPUP_POS_FIELD.index = 1
PBHEROEQUIPUP_POS_FIELD.label = 1
PBHEROEQUIPUP_POS_FIELD.has_default_value = false
PBHEROEQUIPUP_POS_FIELD.default_value = 0
PBHEROEQUIPUP_POS_FIELD.type = 5
PBHEROEQUIPUP_POS_FIELD.cpp_type = 1

PBHEROEQUIPUP.name = "pbHeroEquipUp"
PBHEROEQUIPUP.full_name = ".pbHeroEquipUp"
PBHEROEQUIPUP.nested_types = {}
PBHEROEQUIPUP.enum_types = {}
PBHEROEQUIPUP.fields = {PBHEROEQUIPUP_HERO_ID_FIELD, PBHEROEQUIPUP_POS_FIELD}
PBHEROEQUIPUP.is_extendable = false
PBHEROEQUIPUP.extensions = {}
PBHERORESULT_NUM_FIELD.name = "num"
PBHERORESULT_NUM_FIELD.full_name = ".pbHeroResult.num"
PBHERORESULT_NUM_FIELD.number = 1
PBHERORESULT_NUM_FIELD.index = 0
PBHERORESULT_NUM_FIELD.label = 3
PBHERORESULT_NUM_FIELD.has_default_value = false
PBHERORESULT_NUM_FIELD.default_value = {}
PBHERORESULT_NUM_FIELD.type = 5
PBHERORESULT_NUM_FIELD.cpp_type = 1

PBHERORESULT_HERO_FIELD.name = "hero"
PBHERORESULT_HERO_FIELD.full_name = ".pbHeroResult.hero"
PBHERORESULT_HERO_FIELD.number = 2
PBHERORESULT_HERO_FIELD.index = 1
PBHERORESULT_HERO_FIELD.label = 3
PBHERORESULT_HERO_FIELD.has_default_value = false
PBHERORESULT_HERO_FIELD.default_value = {}
PBHERORESULT_HERO_FIELD.message_type = PBHERO
PBHERORESULT_HERO_FIELD.type = 11
PBHERORESULT_HERO_FIELD.cpp_type = 10

PBHERORESULT.name = "pbHeroResult"
PBHERORESULT.full_name = ".pbHeroResult"
PBHERORESULT.nested_types = {}
PBHERORESULT.enum_types = {}
PBHERORESULT.fields = {PBHERORESULT_NUM_FIELD, PBHERORESULT_HERO_FIELD}
PBHERORESULT.is_extendable = false
PBHERORESULT.extensions = {}
PBHEROUPSKILL_HERO_ID_FIELD.name = "hero_id"
PBHEROUPSKILL_HERO_ID_FIELD.full_name = ".pbHeroUpSkill.hero_id"
PBHEROUPSKILL_HERO_ID_FIELD.number = 1
PBHEROUPSKILL_HERO_ID_FIELD.index = 0
PBHEROUPSKILL_HERO_ID_FIELD.label = 1
PBHEROUPSKILL_HERO_ID_FIELD.has_default_value = false
PBHEROUPSKILL_HERO_ID_FIELD.default_value = 0
PBHEROUPSKILL_HERO_ID_FIELD.type = 5
PBHEROUPSKILL_HERO_ID_FIELD.cpp_type = 1

PBHEROUPSKILL_SKILL_ID_FIELD.name = "skill_id"
PBHEROUPSKILL_SKILL_ID_FIELD.full_name = ".pbHeroUpSkill.skill_id"
PBHEROUPSKILL_SKILL_ID_FIELD.number = 2
PBHEROUPSKILL_SKILL_ID_FIELD.index = 1
PBHEROUPSKILL_SKILL_ID_FIELD.label = 1
PBHEROUPSKILL_SKILL_ID_FIELD.has_default_value = false
PBHEROUPSKILL_SKILL_ID_FIELD.default_value = 0
PBHEROUPSKILL_SKILL_ID_FIELD.type = 5
PBHEROUPSKILL_SKILL_ID_FIELD.cpp_type = 1

PBHEROUPSKILL.name = "pbHeroUpSkill"
PBHEROUPSKILL.full_name = ".pbHeroUpSkill"
PBHEROUPSKILL.nested_types = {}
PBHEROUPSKILL.enum_types = {}
PBHEROUPSKILL.fields = {PBHEROUPSKILL_HERO_ID_FIELD, PBHEROUPSKILL_SKILL_ID_FIELD}
PBHEROUPSKILL.is_extendable = false
PBHEROUPSKILL.extensions = {}
PBPLAYERUPSKILL_SKILL_ID_FIELD.name = "skill_id"
PBPLAYERUPSKILL_SKILL_ID_FIELD.full_name = ".pbPlayerUpSkill.skill_id"
PBPLAYERUPSKILL_SKILL_ID_FIELD.number = 1
PBPLAYERUPSKILL_SKILL_ID_FIELD.index = 0
PBPLAYERUPSKILL_SKILL_ID_FIELD.label = 1
PBPLAYERUPSKILL_SKILL_ID_FIELD.has_default_value = false
PBPLAYERUPSKILL_SKILL_ID_FIELD.default_value = 0
PBPLAYERUPSKILL_SKILL_ID_FIELD.type = 5
PBPLAYERUPSKILL_SKILL_ID_FIELD.cpp_type = 1

PBPLAYERUPSKILL.name = "pbPlayerUpSkill"
PBPLAYERUPSKILL.full_name = ".pbPlayerUpSkill"
PBPLAYERUPSKILL.nested_types = {}
PBPLAYERUPSKILL.enum_types = {}
PBPLAYERUPSKILL.fields = {PBPLAYERUPSKILL_SKILL_ID_FIELD}
PBPLAYERUPSKILL.is_extendable = false
PBPLAYERUPSKILL.extensions = {}

pbHero = protobuf.Message(PBHERO)
pbHeroDeed = protobuf.Message(PBHERODEED)
pbHeroEquip = protobuf.Message(PBHEROEQUIP)
pbHeroEquipId = protobuf.Message(PBHEROEQUIPID)
pbHeroEquipUp = protobuf.Message(PBHEROEQUIPUP)
pbHeroGenius = protobuf.Message(PBHEROGENIUS)
pbHeroId = protobuf.Message(PBHEROID)
pbHeroIds = protobuf.Message(PBHEROIDS)
pbHeroList = protobuf.Message(PBHEROLIST)
pbHeroMarking = protobuf.Message(PBHEROMARKING)
pbHeroResult = protobuf.Message(PBHERORESULT)
pbHeroUpEquip = protobuf.Message(PBHEROUPEQUIP)
pbHeroUpSkill = protobuf.Message(PBHEROUPSKILL)
pbHeroWearEquip = protobuf.Message(PBHEROWEAREQUIP)
pbNewHeroList = protobuf.Message(PBNEWHEROLIST)
pbPlayerUpSkill = protobuf.Message(PBPLAYERUPSKILL)
pbSkillInfo = protobuf.Message(PBSKILLINFO)

