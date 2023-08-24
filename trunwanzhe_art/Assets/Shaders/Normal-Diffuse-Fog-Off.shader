Shader "Diffuse_Fog_Off" {
Properties {
	_MainTex ("Base (RGB)", 2D) = "white" {}
}
SubShader {
	Tags { "RenderType"="Opaque" }
	LOD 200
	Fog{Mode Off}
	

CGPROGRAM
#pragma surface surf Lambert finalcolor:mycolor vertex:myvert

sampler2D _MainTex;

uniform half4 unity_FogColor;
uniform half4 unity_FogStart;
uniform half4 unity_FogEnd;

struct Input {
	float2 uv_MainTex;
	float4 viewSpacePos;
};

void myvert(inout appdata_full v,out Input data){
	data.viewSpacePos = mul( UNITY_MATRIX_MV, v.vertex);
}

void mycolor(Input IN,SurfaceOutput o,inout fixed4 color){
	float dist = length(IN.viewSpacePos);
	float fogFactor = ( abs(dist) - unity_FogStart.x) / (unity_FogEnd.x - unity_FogStart.x);
	fogFactor = clamp(fogFactor, 0.0, 1.0);
			
	color = float4(lerp(color.rgb,unity_FogColor.rgb, fogFactor),color.a);
}

void surf (Input IN, inout SurfaceOutput o) {
	fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
	o.Albedo = c.rgb;
	o.Alpha = c.a;
}
ENDCG
}

Fallback "VertexLit"
}
