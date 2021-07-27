

Shader "SVG Importer/SolidColor/SolidColorOpaque" {
	
	Properties {
	}

	SubShader
	{
		Tags {
			"RenderType" = "Opaque"
			"Queue" = "Geometry"
			"RenderPipeline" = "UniversalPipeline"
		}

		LOD 200
		Lighting Off
		Blend Off
		ZWrite On
		Cull Off
		Fog { Mode Off }	
			
		Pass
		{
			HLSLPROGRAM
			// Required to compile gles 2.0 with standard SRP library
			// All shaders must be compiled with HLSLcc and currently only gles is not using HLSLcc by default
			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x
			#pragma target 2.0

			#pragma vertex vertexColor
			#pragma fragment fragmentColor
			#pragma fragmentoption ARB_precision_hint_fastest
			//#include "UnityCG.cginc"
			#include "../../SVGImporterUnityCG.cginc"
			#include "../../SVGImporterSolidCG.cginc"
			ENDHLSL
        }
	}
	
	SubShader
	{
		Tags {
			"RenderType" = "Opaque"
			"Queue" = "Geometry"
			"RenderPipeline" = ""
		}

		LOD 200
		Lighting Off
		Blend Off
		ZWrite On
		Cull Off
		Fog { Mode Off }	
			
		Pass
		{		
			CGPROGRAM
			#pragma vertex vertexColor
			#pragma fragment fragmentColor
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc"
			#include "../../SVGImporterSolidCG.cginc"
			ENDCG
        }
	}

}
