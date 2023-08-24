// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Dark" {
	Properties 
	{
		//_MainTex ("Base (RGBA)", 2D) = "white" {}
		 _OutlineColor ("Outline Color", Color) = (0.0,0.0,0.8,1)
		 _Pow("Pow",float) = 3
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
			
			//sampler2D _MainTex;
			float4 _OutlineColor;
			float _Pow;
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
			   float4 tex =   float4(0,0,0,1);
			   float t =min(1, pow(i.uv.z+0.5,_Pow));
			   tex.rgb =(1-t)*_OutlineColor;
			   return tex;
			}
			ENDCG
		}
	} 
	FallBack "Diffuse"
}
