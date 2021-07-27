

Shader "SVG Importer/UI/UI" {
	
	Properties {
		_GradientColor ("Gradient Color (RGBA)", 2D) = "white" { }
		_GradientShape ("Gradient Shape (RGBA)", 2D) = "white" { }
		_Params ("Params", Vector) = (1.0, 1.0, 1.0, 1.0)
		
		_Color ("Tint", Color) = (1,1,1,1)
		
 		_StencilComp ("Stencil Comparison", Float) = 8
 		_Stencil ("Stencil ID", Float) = 0
 		_StencilOp ("Stencil Operation", Float) = 0
 		_StencilWriteMask ("Stencil Write Mask", Float) = 255
 		_StencilReadMask ("Stencil Read Mask", Float) = 255
 		
 		_ColorMask ("Color Mask", Float) = 15
 		[Toggle(UNITY_UI_ALPHACLIP)] _UseUIAlphaClip("Use Alpha Clip", Float) = 0
	}

	SubShader
	{
		Tags {
			"RenderType" = "Transparent"
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"PreviewType" = "Plane"
			"CanUseSpriteAtlas" = "False"
			"RenderPipeline" = "UniversalPipeline"
		}

		Lighting Off
		ZTest[unity_GUIZTestMode]
		ZWrite Off
		Cull Off

		Stencil {
			Ref[_Stencil]
			ReadMask[_StencilReadMask]
			WriteMask[_StencilWriteMask]
			Comp[_StencilComp]
			Pass[_StencilOp]
		}

		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask[_ColorMask]

		Pass
		{
			HLSLPROGRAM
			// Required to compile gles 2.0 with standard SRP library
			// All shaders must be compiled with HLSLcc and currently only gles is not using HLSLcc by default
			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x
			#pragma target 2.0

			#pragma vertex vertexGradients
			#pragma fragment fragmentGradientsAlphaBlended
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma glsl_no_auto_normalization 
			//#include "UnityCG.cginc"
			#include "../../SVGImporterUnityCG.cginc"
			//#include "UnityUI.cginc"
			#include "../../SVGImporterUICG.cginc"			
			ENDHLSL
		}
	}
	
	SubShader
	{
		Tags {
			"RenderType" = "Transparent"
			"Queue" = "Transparent"
			"IgnoreProjector" = "True"
			"PreviewType" = "Plane"
			"CanUseSpriteAtlas" = "False"
			"RenderPipeline" = ""
		}

		Lighting Off
		ZTest [unity_GUIZTestMode]
		ZWrite Off
		Cull Off

		Stencil {
			Ref [_Stencil]
			ReadMask [_StencilReadMask]
			WriteMask [_StencilWriteMask]
			Comp [_StencilComp]
			Pass [_StencilOp]
		}

		Blend SrcAlpha OneMinusSrcAlpha
		ColorMask [_ColorMask]

		Pass
		{
			CGPROGRAM
			#pragma vertex vertexGradients
			#pragma fragment fragmentGradientsAlphaBlended
			#pragma fragmentoption ARB_precision_hint_fastest
			#pragma glsl_no_auto_normalization 
			#include "UnityCG.cginc"			
			#include "UnityUI.cginc"
			#include "../../SVGImporterUICG.cginc"			
			ENDCG
        }
	}

}
