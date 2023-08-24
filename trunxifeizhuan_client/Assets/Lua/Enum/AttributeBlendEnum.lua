local AttributeBlendEnum = 
{
	INCREASE_MAX = 10101; --增加固定值，取最大
	INCREASE_SUM = 10102; --增加固定值，累加
	INCREASE_MAX_PER = 10201; --增加百分比，取最大
	INCREASE_SUM_PER = 10202; --增加百分比，累加
	DECREASE_MAX = 20101; --降低固定值，取最大
	DECREASE_SUM = 20102; --降低固定值，累加
	DECREASE_MAX_PER = 20201; --降低百分比，取最大
	DECREASE_SUM_PER = 20202; --降低百分比，累加
}

return AttributeBlendEnum;