

Shader "SVG Importer/SolidColor/SolidColorMultiply" {
	
	Properties {
	}

	SubShader
	{
		Tags {
			"RenderType" = "Transparent"
			"Queue" = "Transparent"
			"RenderPipeline" = "UniversalPipeline"
		}

		LOD 200
		Lighting Off
		Blend DstColor Zero
		ZWrite Off
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
			#include "../SVGImporterUnityCG.cginc"
			#include "../SVGImporterSolidCG.cginc"					
			ENDHLSL
        }
	}
	
	SubShader
	{
		Tags {
			"RenderType" = "Transparent"
			"Queue" = "Transparent"
			"SSRenderPipeline" = ""
		}

		LOD 200
		Lighting Off
		Blend DstColor Zero
		ZWrite Off
		Cull Off
		Fog { Mode Off }
		
		Pass
		{
			CGPROGRAM
			#pragma vertex vertexColor
			#pragma fragment fragmentColor
			#pragma fragmentoption ARB_precision_hint_fastest
			#include "UnityCG.cginc"
			#include "../SVGImporterSolidCG.cginc"					
			ENDCG
        }
	}

}
