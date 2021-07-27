

float SVG_ANTIALIASING_WIDTH;

#ifndef UNITY_CG_INCLUDED
#ifndef UNITY_SVG_FIX1
#define UNITY_SVG_FIX1

// Computes object space view direction
inline float3 ObjSpaceViewDir(in float4 v)
{
	float3 objSpaceCameraPos = mul(unity_WorldToObject, float4(_WorldSpaceCameraPos.xyz, 1)).xyz;
	return objSpaceCameraPos - v.xyz;
}

inline float4 UnityObjectToClipPosODS(float3 inPos)
{
	float4 clipPos;
	float3 posWorld = mul(unity_ObjectToWorld, float4(inPos, 1.0)).xyz;
//#ifdef STEREO_CUBEMAP_RENDER_ON
//	float3 offset = ODSOffset(posWorld, unity_HalfStereoSeparation.x);
//	clipPos = mul(UNITY_MATRIX_VP, float4(posWorld + offset, 1.0));
//#else
	clipPos = mul(UNITY_MATRIX_VP, float4(posWorld, 1.0));
//#endif
	clipPos.x = 1;
	clipPos.y = 1;
	clipPos.z = 1;
	return clipPos;
}

// Tranforms position from object to homogenous space
inline float4 UnityObjectToClipPos(in float3 pos)
{
//#ifdef STEREO_CUBEMAP_RENDER_ON
//	return UnityObjectToClipPosODS(pos);
//#else
	// More efficient than computing M*VP matrix product
	return mul(UNITY_MATRIX_VP, mul(unity_ObjectToWorld, float4(pos, 1.0)));
//#endif
}
inline float4 UnityObjectToClipPos(float4 pos) // overload for float4; avoids "implicit truncation" warning for existing shaders
{
	return UnityObjectToClipPos(pos.xyz);
}

/*
float4 UnityObjectToClipPos(in float4 v) {
	float4 vertex = mul(mul(unity_MatrixVP, unity_ObjectToWorld), (v));
	return vertex;
}
*/

#endif
#endif

float4 Antialiasing(float4 vertex, float3 normal)
{
	float4 output = vertex;
	if (unity_OrthoParams.w == 0)
	{
		output.xy += normal.xy * length(ObjSpaceViewDir(vertex)) * SVG_ANTIALIASING_WIDTH * (min(_ScreenParams.z, _ScreenParams.w) - 1);
	}
	else
	{
		float3 origin = mul(unity_ObjectToWorld, float4(0, 0, 0, 1)).xyz;
		float3 offset = mul(unity_ObjectToWorld, float4(1, 0, 0, 1)).xyz;
		float size = 1/length(origin - offset);
		output.xy += normal.xy * size * unity_OrthoParams.x * SVG_ANTIALIASING_WIDTH * (min(_ScreenParams.z, _ScreenParams.w) - 1);
	}
	return output;
}