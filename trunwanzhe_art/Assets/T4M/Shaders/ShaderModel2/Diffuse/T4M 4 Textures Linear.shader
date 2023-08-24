Shader "T4MShaders/ShaderModel2/Diffuse/T4M 4 Textures Linear" {
Properties {
	_Splat0 ("Layer 1", 2D) = "white" {}
	_Splat1 ("Layer 2", 2D) = "white" {}
	_Splat2 ("Layer 3", 2D) = "white" {}
	_Splat3 ("Layer 4", 2D) = "white" {}
	_Control ("Control (RGBA)", 2D) = "white" {}
	_MainTex ("Never Used", 2D) = "white" {}
}
                
SubShader {
	Tags {
   "SplatCount" = "4"
   "RenderType" = "Opaque"
	}
	
	//Fog {Mode Linear Color(0.2,0.37,0.36) Density 0.01 Range 28.6,54}
	Fog {Mode Off}
	
CGPROGRAM
#pragma surface surf Lambert noforwardadd approxview halfasview  finalcolor:fogColor vertex:fogVertex
#pragma exclude_renderers xbox360 ps3



struct Input {
	float2 uv_Control : TEXCOORD0;
	float2 uv_Splat0 : TEXCOORD1;
	float2 uv_Splat1 : TEXCOORD2;
	float2 uv_Splat2 : TEXCOORD3;
	float2 uv_Splat3 : TEXCOORD4;
	float4 viewSpacePos;
};
 
sampler2D _Control;
sampler2D _Splat0,_Splat1,_Splat2,_Splat3;

uniform half4 unity_FogColor;
uniform half4 unity_FogStart;
uniform half4 unity_FogEnd;

void fogVertex(inout appdata_full v,out Input data){
	data.viewSpacePos = mul( UNITY_MATRIX_MV, v.vertex);
}

void fogColor(Input IN,SurfaceOutput o,inout fixed4 color){
	float dist = IN.viewSpacePos.z;//length(IN.viewSpacePos);
	float fogFactor = ( abs(dist) - unity_FogStart.x) / (unity_FogEnd.x - unity_FogStart.x);
	fogFactor = clamp(fogFactor, 0.0, 1.0);
			
	color = float4(lerp(color.rgb,unity_FogColor.rgb, fogFactor),color.a);
}
 
void surf (Input IN, inout SurfaceOutput o) {
	fixed4 splat_control = tex2D (_Control, IN.uv_Control).rgba;
		
	fixed3 lay1 = tex2D (_Splat0, IN.uv_Splat0);
	fixed3 lay2 = tex2D (_Splat1, IN.uv_Splat1);
	fixed3 lay3 = tex2D (_Splat2, IN.uv_Splat2);
	fixed3 lay4 = tex2D (_Splat3, IN.uv_Splat3);
	o.Alpha = 0.0;
	o.Albedo.rgb = (lay1 * splat_control.r + lay2 * splat_control.g + lay3 * splat_control.b + lay4 * splat_control.a);
}
ENDCG 
}
// Fallback to Diffuse
Fallback "Diffuse"
}
