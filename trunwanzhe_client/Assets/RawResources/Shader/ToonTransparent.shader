// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "ToonTransparent" {
	Properties {
		_Color ("Main Color", Color) = (.5,.5,.5,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_BeginAlpha("beginAlpha",Range(0,1)) = 0
		_EndAlpha("endAlpha",Range(0,1)) = 1
		_EndTime("endTime",float) = 5
	}

	SubShader {
		Tags { "Queue"="Transparent" "RenderType"="Transparent" }
		Pass {
        ZWrite On
        ColorMask 0
	    }
		Pass {
			Name "BASE"
			Cull Off
			Blend SrcAlpha OneMinusSrcAlpha
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest 

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float4 _Color;
			fixed _BeginAlpha;
			fixed _EndAlpha;
			float _EndTime;

			struct appdata {
				float4 vertex : POSITION;
				float2 texcoord : TEXCOORD0;
			};
			
			struct v2f {
				float4 pos : POSITION;
				float2 texcoord : TEXCOORD0;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos (v.vertex);
				o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
				return o;
			}

			float4 frag (v2f i) : COLOR
			{
				float4 col = _Color * tex2D(_MainTex, i.texcoord);
				float4 result = float4( col.rgb, col.a);
				result.a = lerp(_BeginAlpha,_EndAlpha, 1 - (_EndTime - _Time.y ));
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
				constantColor [_Color]
				Combine texture * constant
			} 
		}
	} 
	
	Fallback "VertexLit"
}
