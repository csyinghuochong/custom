// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Custom/Water" {
Properties {
	//_horizonColor ("Horizon color", COLOR)  = ( .172 , .463 , .435 , 0)
	_WaveScale ("Wave scale", Range (0.02,0.15)) = .07
	_ColorControl ("Reflective color (RGB) fresnel (A) ", 2D) = "" { }
	//_ColorControlCube ("Reflective color cube (RGB) fresnel (A) ", Cube) = "" { TexGen CubeReflect }
	_BumpMap ("Waves Normalmap ", 2D) = "" { }
	WaveSpeed ("Wave speed (map1 x,y; map2 x,y)", Vector) = (19,9,-16,-7)
	_MainTex ("Fallback texture", 2D) = "" { }
}

CGINCLUDE
//========================================================================//
#include "UnityCG.cginc"

uniform float4 _horizonColor;

uniform float4 WaveSpeed;
uniform float _WaveScale;
uniform float4 _WaveOffset;

struct appdata {
	float4 vertex : POSITION;
	float3 normal : NORMAL;
};

struct v2f {
	float4 pos : SV_POSITION;
	float2 uv : TEXCOORD0;
	float3 viewDir : TEXCOORD2;
};

v2f vert(appdata v)
{
	v2f o;
	float4 s;

	o.pos = UnityObjectToClipPos (v.vertex);

	// 波浪处理
	o.uv = v.vertex.xz;

	// 接壤处理
	o.viewDir.xzy = normalize( ObjSpaceViewDir(v.vertex) );

	return o;
}

ENDCG
	
//==================================碎片处理================================//

Subshader {
	Tags { "RenderType"="Opaque" }
	Pass {

CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma fragmentoption ARB_precision_hint_fastest 

sampler2D _BumpMap;
sampler2D _ColorControl;

half4 frag( v2f i ) : COLOR
{
	//half3 bump = UnpackNormal(tex2D( _BumpMap, i.uv )).rgb;
	//half fresnel = dot( i.viewDir, bump );
	half4 water = tex2D( _ColorControl, float2(10,10)*i.uv );
	return water;

	//half4 col;
	//col.rgb = lerp( water.rgb, _horizonColor.rgb, water.a );
	//col.a = _horizonColor.a;
	//return col;
}
ENDCG
	}
}

}