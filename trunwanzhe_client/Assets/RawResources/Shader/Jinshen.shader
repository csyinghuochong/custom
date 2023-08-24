// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Jinshen" {
	Properties {
		_MainTex ("Base (RGBA)", 2D) = "white" {}
	}
	SubShader 
	{
		Tags
		{
			"Queue" = "Geometry"
			"IgnoreProjector" = "True"
			"RenderType" = "Opaque"
		}
	    Pass
	    {
		    Cull Off
			Lighting Off
			Fog { Mode Off }

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag			
			#pragma fragmentoption ARB_precision_hint_fastest 
			#include "UnityCG.cginc"
			
			sampler2D _MainTex;
			struct appdata
			{
			    float4 vertex:POSITION;
			    float2 uv:TEXCOORD0;
				float4 normal:NORMAL;
			};
			
			struct v2f
			{
			    float4 pos:SV_POSITION;
			    float3 uv:TEXCOORD0;
			};

			v2f vert(appdata i)
			{
			    v2f o;
			    o.pos = UnityObjectToClipPos(i.vertex);
			    o.uv.xy = i.uv;
				float3 n = normalize(i.normal);
			    float3 viewDir = normalize(ObjSpaceViewDir(i.vertex));
				o.uv.z = abs(dot(n,viewDir));
			    return o;
			}
			
			fixed4 frag(v2f i):COLOR
			{
			   float4 tex =   tex2D(_MainTex,i.uv.xy);
			   float d = tex.r*0.3 + tex.g*0.6 + tex.b*0.1;
			   tex.rgb = float3(1+d,i.uv.z+d,0);
			   return tex;
			}
			ENDCG
		}
	} 
	FallBack "Diffuse"
}
