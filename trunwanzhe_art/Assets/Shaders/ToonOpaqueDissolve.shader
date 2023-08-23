// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ToonOpaqueDissolve" {
	Properties {
		_Color ("Main Color", Color) = (.5,.5,.5,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_ToonShade ("ToonShader Cubemap(RGB)", CUBE) = "" { Texgen CubeNormal }
		
		_Amount ("Amount", Range (0, 1)) = 0.5
		_StartAmount("StartAmount", float) = 0.1
		_Illuminate ("Illuminate", Range (0, 1)) = 0.5
		_Tile("Tile", float) = 1
		_DissColor ("DissColor", Color) = (1,1,1,1)
		_ColorAnimate ("ColorAnimate", vector) = (1,1,1,1)
		_DissolveSrc ("DissolveSrc", 2D) = "white" {}
		_StartTime("StartTime",float) = 0
	}

	SubShader {
		Tags { "RenderType"="Opaque" }
		Pass {
			Name "BASE"
			Cull Off
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest 

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			samplerCUBE _ToonShade;
			float4 _MainTex_ST;
			float4 _Color;
			
			sampler2D _DissolveSrc;
			half4 _DissColor;
			half _Amount;
			static half3 Color = float3(1,1,1);
			half4 _ColorAnimate;
			half _Illuminate;
			half _Tile;
			half _StartAmount;
			
			float _StartTime;

			struct appdata {
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
				float3 normal : NORMAL;
			};
			
			struct v2f {
				float4 pos : POSITION;
				float2 texcoord : TEXCOORD0;
				float3 cubenormal : TEXCOORD1;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos (v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				o.cubenormal = mul (UNITY_MATRIX_MV, float4(v.normal,0));
				return o;
			}

			float4 frag (v2f i) : COLOR
			{
				float4 col = _Color * tex2D(_MainTex, i.texcoord);
				float4 cube = texCUBE(_ToonShade, i.cubenormal);
				
				float3 result = float3(2.0f * cube.rgb * col.rgb);
				
				float ClipTex = tex2D (_DissolveSrc, i.texcoord/_Tile).r ;
				_Amount = _Time.y - _StartTime;
				float ClipAmount = ClipTex - _Amount * 0.1;
				float Clip = 0;

				if (_Amount > 0)
				{
					if (ClipAmount <0)
					{
						Clip = 1; 
					}
					 else
					 {
						if (ClipAmount < _StartAmount)
						{
							if (_ColorAnimate.x == 0)
								Color.x = _DissColor.x;
							else
								Color.x = ClipAmount/_StartAmount;
						  
							if (_ColorAnimate.y == 0)
								Color.y = _DissColor.y;
							else
								Color.y = ClipAmount/_StartAmount;
						  
							if (_ColorAnimate.z == 0)
								Color.z = _DissColor.z;
							else
								Color.z = ClipAmount/_StartAmount;

							result  = (result *((Color.x+Color.y+Color.z))* Color*((Color.x+Color.y+Color.z)))/(1 - _Illuminate);
						}
					 }
				 }

			 
				if (Clip == 1)
				{
					clip(-1);
				}
				
				return float4(result,col.a);
			}
			ENDCG			
		}
	} 

	SubShader {
		Tags { "RenderType"="Opaque" }
		Pass {
			Name "BASE"
			Cull Off
			SetTexture [_MainTex] {
				constantColor [_Color]
				Combine texture * constant
			} 
			SetTexture [_ToonShade] {
				combine texture * previous DOUBLE, previous
			}
		}
	} 
	
	Fallback "VertexLit"
}
