

Shader "SVG Importer/SolidColor/SolidColorTexOverlayAlphaBlended" {
	
	Properties {
		_MainTex ("Texture", 2D) = "white" { }
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
			
			sampler2D _MainTex;
			
			struct vertex_input
			{
			    float4 vertex : POSITION;			    
			    half4 color : COLOR;		
			    half2 uv: TEXCOORD0;	    
			};
			
			struct vertex_output
			{
			    float4 vertex : SV_POSITION;			    
			    half4 color : COLOR;	
			    half2 uv: TEXCOORD0;	    		    
			};	
			
			vertex_output vertexColor(vertex_input v)
			{
			    vertex_output o;
			    o.vertex = TransformWorldToHClip(v.vertex);    
			    o.color = v.color;
			    o.uv = v.uv;
			    return o;
			}
			
			half4 fragmentColor(vertex_output i) : COLOR
			{
				return i.color * tex2D(_MainTex, i.uv);
			}
			
			ENDHLSL
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
			
			sampler2D _MainTex;
			
			struct vertex_input
			{
			    float4 vertex : POSITION;			    
			    half4 color : COLOR;		
			    half2 uv: TEXCOORD0;	    
			};
			
			struct vertex_output
			{
			    float4 vertex : SV_POSITION;			    
			    half4 color : COLOR;	
			    half2 uv: TEXCOORD0;	    		    
			};	
			
			vertex_output vertexColor(vertex_input v)
			{
			    vertex_output o;
			    o.vertex = UnityObjectToClipPos(v.vertex);    
			    o.color = v.color;
			    o.uv = v.uv;
			    return o;
			}
			
			half4 fragmentColor(vertex_output i) : COLOR
			{
				return i.color * tex2D(_MainTex, i.uv);
			}
			
			ENDCG
        }
	}

}
