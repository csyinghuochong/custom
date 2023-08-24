// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ToonBasicOpaqueHit" {
	Properties {
		//_Color ("Main Color", Color) = (.5,.5,.5,1)
		//_TintColor ("Tint Color", Color) = (1,1,1,1)
		_TintColorScale ("Tint Color Scale", float) = 0
		_StartTime("startTime",float)= 0
		_EndTime("endTime",float) = 0
		_MainTex ("Base (RGB)", 2D) = "white" {}
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
			float4 _MainTex_ST;
			//float4 _Color;
			//float4 _TintColor;
			float _TintColorScale;
			float _StartTime;
			float _EndTime;

			struct appdata {
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};
			
			struct v2f {
				float4 pos : POSITION;
				float2 texcoord : TEXCOORD0;
				float scale:TEXCOORD1;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos (v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				
				if( _Time.y < _EndTime)
				{
					float halfDuration = ( _EndTime - _StartTime ) /2;
					float middleTime = _StartTime + halfDuration;
					
					if( _Time.y < middleTime )
					{
						o.scale = lerp(0,_TintColorScale,(middleTime - _Time.y ) / halfDuration );
					}
					else
					{
						o.scale = lerp(_TintColorScale,0,(_EndTime - _Time.y ) / halfDuration );
					}
				}
				else
				{
					o.scale = 0;
				}
				
				return o;
			}

			float4 frag (v2f i) : COLOR
			{
				//float4 col = _Color * tex2D(_MainTex, i.texcoord);
				float4 result = tex2D(_MainTex, i.texcoord);
				//float4 result = float4(col.rgb, col.a);
				
				if( i.scale != 0)
				{
					//result +=  _TintColor * result.r * i.scale;
					result +=  result.r * i.scale;
				}
				
				return result;
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
				//constantColor [_Color]
				Combine texture * constant
			} 
		}
	} 
	
	Fallback "VertexLit"
}
