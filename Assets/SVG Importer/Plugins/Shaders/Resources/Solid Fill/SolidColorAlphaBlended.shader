

Shader "SVG Importer/SolidColor/SolidColorAlphaBlended" {
	
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
		Blend SrcAlpha OneMinusSrcAlpha			
		ZWrite Off
		Cull Off	
		Fog { Mode Off }	
		
		Pass
		{			
			//CGPROGRAM
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
			//#include "Packages/com.unity.render-pipelines.lightweight/ShaderLibrary/Core.hlsl"
			#include "../../SVGImporterUnityCG.cginc"
			#include "../../SVGImporterSolidCG.cginc"
			ENDHLSL
			//ENDCG
        }
	}
	
	SubShader
	{
		Tags {
			"RenderType" = "Transparent"
			"Queue" = "Transparent"
			"RenderPipeline" = ""
		}

		LOD 200	
		Lighting Off	
		Blend SrcAlpha OneMinusSrcAlpha			
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
			#include "../../SVGImporterSolidCG.cginc"					
			ENDCG
        }
	}

}
