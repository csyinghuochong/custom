// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "GuideArea"
{
	Properties
	{
		_MainTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
		_Area ("area", Vector) = (0.5,0.5,0.6,0.6)
		_Screen("circle",Vector) = (1280,720,0.9,0)
		_Alpha("alpha",Range(0,1)) = 0.5
	}
	
	SubShader
	{
		LOD 200

		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}
		
		Pass
		{
			Cull Off
			Lighting Off
			ZWrite Off
			Fog { Mode Off }
			Offset -1, -1
			Blend SrcAlpha OneMinusSrcAlpha

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag			
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _Area;
			float4 _Screen;
			float _Alpha;
	
			struct appdata_t
			{
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};
	
			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 texcoord : TEXCOORD0;
			};
	
			v2f o;

			v2f vert (appdata_t v)
			{
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.texcoord = v.texcoord;
				
				return o;
			}
				
			fixed4 frag (v2f IN) : COLOR
			{
				fixed4 color = tex2D(_MainTex, IN.texcoord);
				color.a = _Alpha;
				
				if( IN.texcoord.x >= _Area.x && IN.texcoord.x <= _Area.z)
				{
					if( IN.texcoord.y >= _Area.y && IN.texcoord.y<= _Area.w )
					{
						if( _Screen.w > 0 )
						{
							float halfX = _Screen.x * ( _Area.z - _Area.x ) / 2;
							float halfY = _Screen.y * ( _Area.w - _Area.y ) / 2;
							float2 origin = float2(_Area.x * _Screen.x + halfX,_Area.y * _Screen.y + halfY);
							float radius = min(halfX,halfY);
							float2 pt = float2(IN.texcoord.x * _Screen.x, IN.texcoord.y * _Screen.y);
							if( distance(pt,origin) <= radius * _Screen.z)
							{
								clip(-1);
							}
						}
						else
						{
							clip(-1);
						}
					}
				}
				
				return color;
			}
			ENDCG
		}
	}

	SubShader
	{
		LOD 100

		Tags
		{
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderType" = "Transparent"
		}
		
		Pass
		{
			Cull Off
			Lighting Off
			ZWrite Off
			Fog { Mode Off }
			Offset -1, -1
			ColorMask RGB
			Blend SrcAlpha OneMinusSrcAlpha
			ColorMaterial AmbientAndDiffuse
			
			SetTexture [_MainTex]
			{
				Combine Texture * Primary
			}
		}
	}
}
