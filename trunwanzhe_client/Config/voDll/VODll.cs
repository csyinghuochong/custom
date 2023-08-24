using System.IO;
                                using System;
                                using System.Collections.Generic;
                                namespace Assets.Scripts.Com.Game.Config
                                { 
 [Serializable]public class Sysactive_charge
    {
		public string unikey;
		public int charge; //累计达到金额
		public List<Syscharge_goods> day7; //7天累计奖励
		public List<Syscharge_goods> day1; //当天累计奖励
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] chargeBytes = BitConverter.GetBytes(charge);
            ms.Write(chargeBytes,0,chargeBytes.Length);
if(day7==null)day7 = new List<Syscharge_goods>();
byte[] day7CountBytes = BitConverter.GetBytes(day7.Count);
            ms.Write(day7CountBytes,0,day7CountBytes.Length);
for (int i = 0; i < day7.Count; i++){
if(day7[i] == null)day7[i] = new Syscharge_goods();day7[i].Serializer(ms);
}
if(day1==null)day1 = new List<Syscharge_goods>();
byte[] day1CountBytes = BitConverter.GetBytes(day1.Count);
            ms.Write(day1CountBytes,0,day1CountBytes.Length);
for (int i = 0; i < day1.Count; i++){
if(day1[i] == null)day1[i] = new Syscharge_goods();day1[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
charge = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int day7Count;
day7Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
day7 = new List<Syscharge_goods>(day7Count);
for (int i = 0; i < day7Count; i++){
day7.Add(new Syscharge_goods());offset = day7[i].Deserializer(bytes,offset);
}

int day1Count;
day1Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
day1 = new List<Syscharge_goods>(day1Count);
for (int i = 0; i < day1Count; i++){
day1.Add(new Syscharge_goods());offset = day1[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_combat
    {
		public string unikey;
		public int id; //唯一id
		public int combat; //战力
		public List<Sysrank_goods> combat_goods; //战力奖励物品
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] combatBytes = BitConverter.GetBytes(combat);
            ms.Write(combatBytes,0,combatBytes.Length);
if(combat_goods==null)combat_goods = new List<Sysrank_goods>();
byte[] combat_goodsCountBytes = BitConverter.GetBytes(combat_goods.Count);
            ms.Write(combat_goodsCountBytes,0,combat_goodsCountBytes.Length);
for (int i = 0; i < combat_goods.Count; i++){
if(combat_goods[i] == null)combat_goods[i] = new Sysrank_goods();combat_goods[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
combat = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int combat_goodsCount;
combat_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
combat_goods = new List<Sysrank_goods>(combat_goodsCount);
for (int i = 0; i < combat_goodsCount; i++){
combat_goods.Add(new Sysrank_goods());offset = combat_goods[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_grow_fund
    {
		public string unikey;
		public int lv; //等级
		public int gold_num; //等级领取钻石
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
byte[] gold_numBytes = BitConverter.GetBytes(gold_num);
            ms.Write(gold_numBytes,0,gold_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
gold_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysactive_hero
    {
		public string unikey;
		public int hero_id; //英雄id
		public int sell_price; //出售价格
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] hero_idBytes = BitConverter.GetBytes(hero_id);
            ms.Write(hero_idBytes,0,hero_idBytes.Length);
byte[] sell_priceBytes = BitConverter.GetBytes(sell_price);
            ms.Write(sell_priceBytes,0,sell_priceBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
hero_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
sell_price = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysactive_login
    {
		public string unikey;
		public int day; //登陆天数
		public List<Syslogin_goods> goods; //登陆天数奖励物品
		public List<Syslogin_goods> goods2; //登陆天数奖励物品
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] dayBytes = BitConverter.GetBytes(day);
            ms.Write(dayBytes,0,dayBytes.Length);
if(goods==null)goods = new List<Syslogin_goods>();
byte[] goodsCountBytes = BitConverter.GetBytes(goods.Count);
            ms.Write(goodsCountBytes,0,goodsCountBytes.Length);
for (int i = 0; i < goods.Count; i++){
if(goods[i] == null)goods[i] = new Syslogin_goods();goods[i].Serializer(ms);
}
if(goods2==null)goods2 = new List<Syslogin_goods>();
byte[] goods2CountBytes = BitConverter.GetBytes(goods2.Count);
            ms.Write(goods2CountBytes,0,goods2CountBytes.Length);
for (int i = 0; i < goods2.Count; i++){
if(goods2[i] == null)goods2[i] = new Syslogin_goods();goods2[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
day = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int goodsCount;
goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods = new List<Syslogin_goods>(goodsCount);
for (int i = 0; i < goodsCount; i++){
goods.Add(new Syslogin_goods());offset = goods[i].Deserializer(bytes,offset);
}

int goods2Count;
goods2Count = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods2 = new List<Syslogin_goods>(goods2Count);
for (int i = 0; i < goods2Count; i++){
goods2.Add(new Syslogin_goods());offset = goods2[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_lv
    {
		public string unikey;
		public int lv; //等级
		public List<Syslv_goods> goods; //等级奖励物品
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
if(goods==null)goods = new List<Syslv_goods>();
byte[] goodsCountBytes = BitConverter.GetBytes(goods.Count);
            ms.Write(goodsCountBytes,0,goodsCountBytes.Length);
for (int i = 0; i < goods.Count; i++){
if(goods[i] == null)goods[i] = new Syslv_goods();goods[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int goodsCount;
goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods = new List<Syslv_goods>(goodsCount);
for (int i = 0; i < goodsCount; i++){
goods.Add(new Syslv_goods());offset = goods[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_phase
    {
		public string unikey;
		public int phase; //段位
		public List<int> score; //段位积分
		public List<Sysrank_goods> phase_goods; //段位奖励物品
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] phaseBytes = BitConverter.GetBytes(phase);
            ms.Write(phaseBytes,0,phaseBytes.Length);
if(score==null)score = new List<int>();
byte[] scoreCountBytes = BitConverter.GetBytes(score.Count);
            ms.Write(scoreCountBytes,0,scoreCountBytes.Length);
for (int i = 0; i < score.Count; i++){
byte[] scoreBytes = BitConverter.GetBytes(score[i]);
            ms.Write(scoreBytes,0,scoreBytes.Length);
}
if(phase_goods==null)phase_goods = new List<Sysrank_goods>();
byte[] phase_goodsCountBytes = BitConverter.GetBytes(phase_goods.Count);
            ms.Write(phase_goodsCountBytes,0,phase_goodsCountBytes.Length);
for (int i = 0; i < phase_goods.Count; i++){
if(phase_goods[i] == null)phase_goods[i] = new Sysrank_goods();phase_goods[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
phase = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int scoreCount;
scoreCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
score = new List<int>(scoreCount);
for (int i = 0; i < scoreCount; i++){
score.Add( BitConverter.ToInt32(bytes, offset));
            offset += 4;
}

int phase_goodsCount;
phase_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
phase_goods = new List<Sysrank_goods>(phase_goodsCount);
for (int i = 0; i < phase_goodsCount; i++){
phase_goods.Add(new Sysrank_goods());offset = phase_goods[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_rank
    {
		public string unikey;
		public int id; //rank_id
		public List<Sysrank_goods> dungeon_reward; //闯关奖励(实际发的)
		public List<Sysrank_goods> dungeon_extra_reward; //闯关奖励(显示用)
		public List<Sysrank_goods> combat_reward; //战力奖励(实际发的)
		public List<Sysrank_goods> combat_extra_reward; //战力奖励(显示用)
		public List<Sysrank_goods> arena_reward; //竞技场奖励(实际发的)
		public List<Sysrank_goods> arena_extra_reward; //竞技场奖励(显示用)
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
if(dungeon_reward==null)dungeon_reward = new List<Sysrank_goods>();
byte[] dungeon_rewardCountBytes = BitConverter.GetBytes(dungeon_reward.Count);
            ms.Write(dungeon_rewardCountBytes,0,dungeon_rewardCountBytes.Length);
for (int i = 0; i < dungeon_reward.Count; i++){
if(dungeon_reward[i] == null)dungeon_reward[i] = new Sysrank_goods();dungeon_reward[i].Serializer(ms);
}
if(dungeon_extra_reward==null)dungeon_extra_reward = new List<Sysrank_goods>();
byte[] dungeon_extra_rewardCountBytes = BitConverter.GetBytes(dungeon_extra_reward.Count);
            ms.Write(dungeon_extra_rewardCountBytes,0,dungeon_extra_rewardCountBytes.Length);
for (int i = 0; i < dungeon_extra_reward.Count; i++){
if(dungeon_extra_reward[i] == null)dungeon_extra_reward[i] = new Sysrank_goods();dungeon_extra_reward[i].Serializer(ms);
}
if(combat_reward==null)combat_reward = new List<Sysrank_goods>();
byte[] combat_rewardCountBytes = BitConverter.GetBytes(combat_reward.Count);
            ms.Write(combat_rewardCountBytes,0,combat_rewardCountBytes.Length);
for (int i = 0; i < combat_reward.Count; i++){
if(combat_reward[i] == null)combat_reward[i] = new Sysrank_goods();combat_reward[i].Serializer(ms);
}
if(combat_extra_reward==null)combat_extra_reward = new List<Sysrank_goods>();
byte[] combat_extra_rewardCountBytes = BitConverter.GetBytes(combat_extra_reward.Count);
            ms.Write(combat_extra_rewardCountBytes,0,combat_extra_rewardCountBytes.Length);
for (int i = 0; i < combat_extra_reward.Count; i++){
if(combat_extra_reward[i] == null)combat_extra_reward[i] = new Sysrank_goods();combat_extra_reward[i].Serializer(ms);
}
if(arena_reward==null)arena_reward = new List<Sysrank_goods>();
byte[] arena_rewardCountBytes = BitConverter.GetBytes(arena_reward.Count);
            ms.Write(arena_rewardCountBytes,0,arena_rewardCountBytes.Length);
for (int i = 0; i < arena_reward.Count; i++){
if(arena_reward[i] == null)arena_reward[i] = new Sysrank_goods();arena_reward[i].Serializer(ms);
}
if(arena_extra_reward==null)arena_extra_reward = new List<Sysrank_goods>();
byte[] arena_extra_rewardCountBytes = BitConverter.GetBytes(arena_extra_reward.Count);
            ms.Write(arena_extra_rewardCountBytes,0,arena_extra_rewardCountBytes.Length);
for (int i = 0; i < arena_extra_reward.Count; i++){
if(arena_extra_reward[i] == null)arena_extra_reward[i] = new Sysrank_goods();arena_extra_reward[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int dungeon_rewardCount;
dungeon_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungeon_reward = new List<Sysrank_goods>(dungeon_rewardCount);
for (int i = 0; i < dungeon_rewardCount; i++){
dungeon_reward.Add(new Sysrank_goods());offset = dungeon_reward[i].Deserializer(bytes,offset);
}

int dungeon_extra_rewardCount;
dungeon_extra_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungeon_extra_reward = new List<Sysrank_goods>(dungeon_extra_rewardCount);
for (int i = 0; i < dungeon_extra_rewardCount; i++){
dungeon_extra_reward.Add(new Sysrank_goods());offset = dungeon_extra_reward[i].Deserializer(bytes,offset);
}

int combat_rewardCount;
combat_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
combat_reward = new List<Sysrank_goods>(combat_rewardCount);
for (int i = 0; i < combat_rewardCount; i++){
combat_reward.Add(new Sysrank_goods());offset = combat_reward[i].Deserializer(bytes,offset);
}

int combat_extra_rewardCount;
combat_extra_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
combat_extra_reward = new List<Sysrank_goods>(combat_extra_rewardCount);
for (int i = 0; i < combat_extra_rewardCount; i++){
combat_extra_reward.Add(new Sysrank_goods());offset = combat_extra_reward[i].Deserializer(bytes,offset);
}

int arena_rewardCount;
arena_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arena_reward = new List<Sysrank_goods>(arena_rewardCount);
for (int i = 0; i < arena_rewardCount; i++){
arena_reward.Add(new Sysrank_goods());offset = arena_reward[i].Deserializer(bytes,offset);
}

int arena_extra_rewardCount;
arena_extra_rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arena_extra_reward = new List<Sysrank_goods>(arena_extra_rewardCount);
for (int i = 0; i < arena_extra_rewardCount; i++){
arena_extra_reward.Add(new Sysrank_goods());offset = arena_extra_reward[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysactive_vip
    {
		public string unikey;
		public int vip_lv; //vip等级
		public int online_time; //在线时长
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] vip_lvBytes = BitConverter.GetBytes(vip_lv);
            ms.Write(vip_lvBytes,0,vip_lvBytes.Length);
byte[] online_timeBytes = BitConverter.GetBytes(online_time);
            ms.Write(online_timeBytes,0,online_timeBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
vip_lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
online_time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysactive_welfare
    {
		public string unikey;
		public int id; //id
		public int finish_limit; //完成条件
		public List<Sysrank_goods> reward; //奖励
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] finish_limitBytes = BitConverter.GetBytes(finish_limit);
            ms.Write(finish_limitBytes,0,finish_limitBytes.Length);
if(reward==null)reward = new List<Sysrank_goods>();
byte[] rewardCountBytes = BitConverter.GetBytes(reward.Count);
            ms.Write(rewardCountBytes,0,rewardCountBytes.Length);
for (int i = 0; i < reward.Count; i++){
if(reward[i] == null)reward[i] = new Sysrank_goods();reward[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
finish_limit = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int rewardCount;
rewardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
reward = new List<Sysrank_goods>(rewardCount);
for (int i = 0; i < rewardCount; i++){
reward.Add(new Sysrank_goods());offset = reward[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Syscharge_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysglobal_value
    {
		public string unikey;
		public int id; //唯一id
		public int value; //整型数值
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] idBytes = BitConverter.GetBytes(id);
            ms.Write(idBytes,0,idBytes.Length);
byte[] valueBytes = BitConverter.GetBytes(value);
            ms.Write(valueBytes,0,valueBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
value = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syslogin_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syslv_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysrank_goods
    {
		public int goods_id; //物品Id
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysrecharge
    {
		public string unikey;
		public int rmb; //充值RMB
		public int diamond; //获得钻石
		public int presentation; //赠送钻石
		public string diamond_id; //钻石ID
		public string wzjx_diamond_id; //钻石ID
		public string desc; //描述
		public string bg_icon; //钻石ID
		public string top_left_name; //左上角
		public string top_left_bg; //左上角
		public List<Sysrecharge_award> recharge_award; //首充奖励
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] rmbBytes = BitConverter.GetBytes(rmb);
            ms.Write(rmbBytes,0,rmbBytes.Length);
byte[] diamondBytes = BitConverter.GetBytes(diamond);
            ms.Write(diamondBytes,0,diamondBytes.Length);
byte[] presentationBytes = BitConverter.GetBytes(presentation);
            ms.Write(presentationBytes,0,presentationBytes.Length);
if(string.IsNullOrEmpty(diamond_id))diamond_id = string.Empty;
            byte[] diamond_idBytes = System.Text.Encoding.UTF8.GetBytes(diamond_id);
            byte[] diamond_idBytesLen = BitConverter.GetBytes(diamond_idBytes.Length);
            ms.Write(diamond_idBytesLen, 0, diamond_idBytesLen.Length);
            ms.Write(diamond_idBytes, 0, diamond_idBytes.Length);
if(string.IsNullOrEmpty(wzjx_diamond_id))wzjx_diamond_id = string.Empty;
            byte[] wzjx_diamond_idBytes = System.Text.Encoding.UTF8.GetBytes(wzjx_diamond_id);
            byte[] wzjx_diamond_idBytesLen = BitConverter.GetBytes(wzjx_diamond_idBytes.Length);
            ms.Write(wzjx_diamond_idBytesLen, 0, wzjx_diamond_idBytesLen.Length);
            ms.Write(wzjx_diamond_idBytes, 0, wzjx_diamond_idBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
if(string.IsNullOrEmpty(bg_icon))bg_icon = string.Empty;
            byte[] bg_iconBytes = System.Text.Encoding.UTF8.GetBytes(bg_icon);
            byte[] bg_iconBytesLen = BitConverter.GetBytes(bg_iconBytes.Length);
            ms.Write(bg_iconBytesLen, 0, bg_iconBytesLen.Length);
            ms.Write(bg_iconBytes, 0, bg_iconBytes.Length);
if(string.IsNullOrEmpty(top_left_name))top_left_name = string.Empty;
            byte[] top_left_nameBytes = System.Text.Encoding.UTF8.GetBytes(top_left_name);
            byte[] top_left_nameBytesLen = BitConverter.GetBytes(top_left_nameBytes.Length);
            ms.Write(top_left_nameBytesLen, 0, top_left_nameBytesLen.Length);
            ms.Write(top_left_nameBytes, 0, top_left_nameBytes.Length);
if(string.IsNullOrEmpty(top_left_bg))top_left_bg = string.Empty;
            byte[] top_left_bgBytes = System.Text.Encoding.UTF8.GetBytes(top_left_bg);
            byte[] top_left_bgBytesLen = BitConverter.GetBytes(top_left_bgBytes.Length);
            ms.Write(top_left_bgBytesLen, 0, top_left_bgBytesLen.Length);
            ms.Write(top_left_bgBytes, 0, top_left_bgBytes.Length);
if(recharge_award==null)recharge_award = new List<Sysrecharge_award>();
byte[] recharge_awardCountBytes = BitConverter.GetBytes(recharge_award.Count);
            ms.Write(recharge_awardCountBytes,0,recharge_awardCountBytes.Length);
for (int i = 0; i < recharge_award.Count; i++){
if(recharge_award[i] == null)recharge_award[i] = new Sysrecharge_award();recharge_award[i].Serializer(ms);
}
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
rmb = BitConverter.ToInt32(bytes, offset);
            offset += 4;
diamond = BitConverter.ToInt32(bytes, offset);
            offset += 4;
presentation = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int diamond_id_count;diamond_id_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;diamond_id = System.Text.Encoding.UTF8.GetString(bytes, offset, diamond_id_count);offset += diamond_id_count;
int wzjx_diamond_id_count;wzjx_diamond_id_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;wzjx_diamond_id = System.Text.Encoding.UTF8.GetString(bytes, offset, wzjx_diamond_id_count);offset += wzjx_diamond_id_count;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
int bg_icon_count;bg_icon_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;bg_icon = System.Text.Encoding.UTF8.GetString(bytes, offset, bg_icon_count);offset += bg_icon_count;
int top_left_name_count;top_left_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;top_left_name = System.Text.Encoding.UTF8.GetString(bytes, offset, top_left_name_count);offset += top_left_name_count;
int top_left_bg_count;top_left_bg_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;top_left_bg = System.Text.Encoding.UTF8.GetString(bytes, offset, top_left_bg_count);offset += top_left_bg_count;

int recharge_awardCount;
recharge_awardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
recharge_award = new List<Sysrecharge_award>(recharge_awardCount);
for (int i = 0; i < recharge_awardCount; i++){
recharge_award.Add(new Sysrecharge_award());offset = recharge_award[i].Deserializer(bytes,offset);
}
return offset;
        }
} 
 [Serializable]public class Sysrecharge_award
    {
		public int goods_id; //物品1D
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Syssign_always
    {
		public string unikey;
		public int date; //连续天数
		public List<Syssign_goods> goods; //物品
		public List<Syssign_goods> goods_first; //首次7连签奖励
		public List<Syssign_goods> land_goods; //7天连续登陆奖励物品
		public string goods_name; //七日登陆奖励物品
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] dateBytes = BitConverter.GetBytes(date);
            ms.Write(dateBytes,0,dateBytes.Length);
if(goods==null)goods = new List<Syssign_goods>();
byte[] goodsCountBytes = BitConverter.GetBytes(goods.Count);
            ms.Write(goodsCountBytes,0,goodsCountBytes.Length);
for (int i = 0; i < goods.Count; i++){
if(goods[i] == null)goods[i] = new Syssign_goods();goods[i].Serializer(ms);
}
if(goods_first==null)goods_first = new List<Syssign_goods>();
byte[] goods_firstCountBytes = BitConverter.GetBytes(goods_first.Count);
            ms.Write(goods_firstCountBytes,0,goods_firstCountBytes.Length);
for (int i = 0; i < goods_first.Count; i++){
if(goods_first[i] == null)goods_first[i] = new Syssign_goods();goods_first[i].Serializer(ms);
}
if(land_goods==null)land_goods = new List<Syssign_goods>();
byte[] land_goodsCountBytes = BitConverter.GetBytes(land_goods.Count);
            ms.Write(land_goodsCountBytes,0,land_goodsCountBytes.Length);
for (int i = 0; i < land_goods.Count; i++){
if(land_goods[i] == null)land_goods[i] = new Syssign_goods();land_goods[i].Serializer(ms);
}
if(string.IsNullOrEmpty(goods_name))goods_name = string.Empty;
            byte[] goods_nameBytes = System.Text.Encoding.UTF8.GetBytes(goods_name);
            byte[] goods_nameBytesLen = BitConverter.GetBytes(goods_nameBytes.Length);
            ms.Write(goods_nameBytesLen, 0, goods_nameBytesLen.Length);
            ms.Write(goods_nameBytes, 0, goods_nameBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
date = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int goodsCount;
goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods = new List<Syssign_goods>(goodsCount);
for (int i = 0; i < goodsCount; i++){
goods.Add(new Syssign_goods());offset = goods[i].Deserializer(bytes,offset);
}

int goods_firstCount;
goods_firstCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_first = new List<Syssign_goods>(goods_firstCount);
for (int i = 0; i < goods_firstCount; i++){
goods_first.Add(new Syssign_goods());offset = goods_first[i].Deserializer(bytes,offset);
}

int land_goodsCount;
land_goodsCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
land_goods = new List<Syssign_goods>(land_goodsCount);
for (int i = 0; i < land_goodsCount; i++){
land_goods.Add(new Syssign_goods());offset = land_goods[i].Deserializer(bytes,offset);
}
int goods_name_count;goods_name_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;goods_name = System.Text.Encoding.UTF8.GetString(bytes, offset, goods_name_count);offset += goods_name_count;
return offset;
        }
} 
 [Serializable]public class Syssign_goods
    {
		public int goods_id; //物品1D
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysvip
    {
		public string unikey;
		public int lv; //vip等级
		public string desc; //描述
		public int exp; //总共需要的经验
		public int dungeon_no_star; //非三星开启扫荡功能
		public int dungeon_sweep; //扫荡十次功能
		public int bag_num; //背包格子容量
		public int coin_num; //购买金币的次数
		public int tittle; //获得称号
		public int player_skill_point_num; //上古神器钻石购买次数
		public int energy_num; //购买体力次数
		public int skill_point_num; //购买英雄技能点次数
		public int max_energy_auto; //体力上限
		public int max_skill_point_auto; //自动增长英雄技能点上限
		public int max_energy; //最大体力上限
		public int max_skill_point; //英雄技能点上限
		public int super_dungeon; //精英副本购买次数
		public int arena_num; //购买竞技场次数
		public int marking_gold; //印记VIP消耗
		public int marking_exp; //印记经验翻倍
		public List<Sysvip_award> award; //奖励
		public int value; //价值
		public int union_build_time; //联盟朝拜钻石次数
		public int hell_times; //血色地狱次数
		public int peerage_num; //购买爵位挑战次数
		public int escort_num; //征服之海护送次数
		public int escort_rob_num; //征服之海掠夺次数
		public int buy_trial_times; //购买试炼币次数
		public int buy_grow_fund; //购买成长基金
    public void Serializer(MemoryStream ms){

if(string.IsNullOrEmpty(unikey))unikey = string.Empty;
            byte[] unikeyBytes = System.Text.Encoding.UTF8.GetBytes(unikey);
            byte[] unikeyBytesLen = BitConverter.GetBytes(unikeyBytes.Length);
            ms.Write(unikeyBytesLen, 0, unikeyBytesLen.Length);
            ms.Write(unikeyBytes, 0, unikeyBytes.Length);
byte[] lvBytes = BitConverter.GetBytes(lv);
            ms.Write(lvBytes,0,lvBytes.Length);
if(string.IsNullOrEmpty(desc))desc = string.Empty;
            byte[] descBytes = System.Text.Encoding.UTF8.GetBytes(desc);
            byte[] descBytesLen = BitConverter.GetBytes(descBytes.Length);
            ms.Write(descBytesLen, 0, descBytesLen.Length);
            ms.Write(descBytes, 0, descBytes.Length);
byte[] expBytes = BitConverter.GetBytes(exp);
            ms.Write(expBytes,0,expBytes.Length);
byte[] dungeon_no_starBytes = BitConverter.GetBytes(dungeon_no_star);
            ms.Write(dungeon_no_starBytes,0,dungeon_no_starBytes.Length);
byte[] dungeon_sweepBytes = BitConverter.GetBytes(dungeon_sweep);
            ms.Write(dungeon_sweepBytes,0,dungeon_sweepBytes.Length);
byte[] bag_numBytes = BitConverter.GetBytes(bag_num);
            ms.Write(bag_numBytes,0,bag_numBytes.Length);
byte[] coin_numBytes = BitConverter.GetBytes(coin_num);
            ms.Write(coin_numBytes,0,coin_numBytes.Length);
byte[] tittleBytes = BitConverter.GetBytes(tittle);
            ms.Write(tittleBytes,0,tittleBytes.Length);
byte[] player_skill_point_numBytes = BitConverter.GetBytes(player_skill_point_num);
            ms.Write(player_skill_point_numBytes,0,player_skill_point_numBytes.Length);
byte[] energy_numBytes = BitConverter.GetBytes(energy_num);
            ms.Write(energy_numBytes,0,energy_numBytes.Length);
byte[] skill_point_numBytes = BitConverter.GetBytes(skill_point_num);
            ms.Write(skill_point_numBytes,0,skill_point_numBytes.Length);
byte[] max_energy_autoBytes = BitConverter.GetBytes(max_energy_auto);
            ms.Write(max_energy_autoBytes,0,max_energy_autoBytes.Length);
byte[] max_skill_point_autoBytes = BitConverter.GetBytes(max_skill_point_auto);
            ms.Write(max_skill_point_autoBytes,0,max_skill_point_autoBytes.Length);
byte[] max_energyBytes = BitConverter.GetBytes(max_energy);
            ms.Write(max_energyBytes,0,max_energyBytes.Length);
byte[] max_skill_pointBytes = BitConverter.GetBytes(max_skill_point);
            ms.Write(max_skill_pointBytes,0,max_skill_pointBytes.Length);
byte[] super_dungeonBytes = BitConverter.GetBytes(super_dungeon);
            ms.Write(super_dungeonBytes,0,super_dungeonBytes.Length);
byte[] arena_numBytes = BitConverter.GetBytes(arena_num);
            ms.Write(arena_numBytes,0,arena_numBytes.Length);
byte[] marking_goldBytes = BitConverter.GetBytes(marking_gold);
            ms.Write(marking_goldBytes,0,marking_goldBytes.Length);
byte[] marking_expBytes = BitConverter.GetBytes(marking_exp);
            ms.Write(marking_expBytes,0,marking_expBytes.Length);
if(award==null)award = new List<Sysvip_award>();
byte[] awardCountBytes = BitConverter.GetBytes(award.Count);
            ms.Write(awardCountBytes,0,awardCountBytes.Length);
for (int i = 0; i < award.Count; i++){
if(award[i] == null)award[i] = new Sysvip_award();award[i].Serializer(ms);
}
byte[] valueBytes = BitConverter.GetBytes(value);
            ms.Write(valueBytes,0,valueBytes.Length);
byte[] union_build_timeBytes = BitConverter.GetBytes(union_build_time);
            ms.Write(union_build_timeBytes,0,union_build_timeBytes.Length);
byte[] hell_timesBytes = BitConverter.GetBytes(hell_times);
            ms.Write(hell_timesBytes,0,hell_timesBytes.Length);
byte[] peerage_numBytes = BitConverter.GetBytes(peerage_num);
            ms.Write(peerage_numBytes,0,peerage_numBytes.Length);
byte[] escort_numBytes = BitConverter.GetBytes(escort_num);
            ms.Write(escort_numBytes,0,escort_numBytes.Length);
byte[] escort_rob_numBytes = BitConverter.GetBytes(escort_rob_num);
            ms.Write(escort_rob_numBytes,0,escort_rob_numBytes.Length);
byte[] buy_trial_timesBytes = BitConverter.GetBytes(buy_trial_times);
            ms.Write(buy_trial_timesBytes,0,buy_trial_timesBytes.Length);
byte[] buy_grow_fundBytes = BitConverter.GetBytes(buy_grow_fund);
            ms.Write(buy_grow_fundBytes,0,buy_grow_fundBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

int unikey_count;unikey_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;unikey = System.Text.Encoding.UTF8.GetString(bytes, offset, unikey_count);offset += unikey_count;
lv = BitConverter.ToInt32(bytes, offset);
            offset += 4;
int desc_count;desc_count = BitConverter.ToInt32(bytes, offset);
            offset += 4;desc = System.Text.Encoding.UTF8.GetString(bytes, offset, desc_count);offset += desc_count;
exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungeon_no_star = BitConverter.ToInt32(bytes, offset);
            offset += 4;
dungeon_sweep = BitConverter.ToInt32(bytes, offset);
            offset += 4;
bag_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
coin_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
tittle = BitConverter.ToInt32(bytes, offset);
            offset += 4;
player_skill_point_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
energy_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
skill_point_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max_energy_auto = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max_skill_point_auto = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max_energy = BitConverter.ToInt32(bytes, offset);
            offset += 4;
max_skill_point = BitConverter.ToInt32(bytes, offset);
            offset += 4;
super_dungeon = BitConverter.ToInt32(bytes, offset);
            offset += 4;
arena_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
marking_gold = BitConverter.ToInt32(bytes, offset);
            offset += 4;
marking_exp = BitConverter.ToInt32(bytes, offset);
            offset += 4;

int awardCount;
awardCount = BitConverter.ToInt32(bytes, offset);
            offset += 4;
award = new List<Sysvip_award>(awardCount);
for (int i = 0; i < awardCount; i++){
award.Add(new Sysvip_award());offset = award[i].Deserializer(bytes,offset);
}
value = BitConverter.ToInt32(bytes, offset);
            offset += 4;
union_build_time = BitConverter.ToInt32(bytes, offset);
            offset += 4;
hell_times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
peerage_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
escort_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
escort_rob_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buy_trial_times = BitConverter.ToInt32(bytes, offset);
            offset += 4;
buy_grow_fund = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
} 
 [Serializable]public class Sysvip_award
    {
		public int goods_id; //物品ID
		public int goods_num; //物品数量
    public void Serializer(MemoryStream ms){

byte[] goods_idBytes = BitConverter.GetBytes(goods_id);
            ms.Write(goods_idBytes,0,goods_idBytes.Length);
byte[] goods_numBytes = BitConverter.GetBytes(goods_num);
            ms.Write(goods_numBytes,0,goods_numBytes.Length);
}
public int Deserializer(byte[] bytes, int offset = 0){

goods_id = BitConverter.ToInt32(bytes, offset);
            offset += 4;
goods_num = BitConverter.ToInt32(bytes, offset);
            offset += 4;
return offset;
        }
}}