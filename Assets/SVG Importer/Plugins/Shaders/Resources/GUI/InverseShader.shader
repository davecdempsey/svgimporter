

Shader "SVG Importer/Utils/InverseShader"
{
	Properties
	{
		
	}

	SubShader
	{
		Tags {
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderPipeline" = "UniversalPipeline"
		}

		LOD 100

		ZWrite Off
		Cull Off
		Blend OneMinusDstColor OneMinusSrcAlpha
		

		Pass
		{
			HLSLPROGRAM
			// Required to compile gles 2.0 with standard SRP library
			// All shaders must be compiled with HLSLcc and currently only gles is not using HLSLcc by default
			#pragma prefer_hlslcc gles
			#pragma exclude_renderers d3d11_9x
			#pragma target 2.0

			#pragma vertex vert
			#pragma fragment frag
			//#include "UnityCG.cginc"
			#include "../../SVGImporterUnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = TransformWorldToHClip(v.vertex);				
				return o;
			}
			
			half4 frag (v2f i) : SV_Target
			{				
				return half4(1.0, 1.0, 1.0, 0.5);
			}
			ENDHLSL
		}
	}

	SubShader
	{
		Tags {
			"Queue" = "Transparent"
			"RenderType" = "Transparent"
			"IgnoreProjector" = "True"
			"RenderPipeline" = ""
		}

		LOD 100

		ZWrite Off
		Cull Off
		Blend OneMinusDstColor OneMinusSrcAlpha
		

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);				
				return o;
			}
			
			half4 frag (v2f i) : SV_Target
			{				
				return half4(1.0, 1.0, 1.0, 0.5);
			}
			ENDCG
		}
	}

}
