Shader "Custom/DiffuseFragment" {
	Properties {
		_Diffuse ("Diffuse", Color) = (1,1,1,1)
	}
	SubShader {
		//Tags { "RenderType"="Opaque" }
		Pass{
			Tags { "LightMode" = "ForwardBase"}

			CGPROGRAM
			// Physically based Standard lighting model, and enable shadows on all light types
			#pragma vertex vert
			#pragma fragment frag
			// Use shader model 3.0 target, to get nicer looking lighting
			#pragma target 3.0
			#include "Lighting.cginc"

			fixed4 _Diffuse;

			struct a2v {
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f {
				float4 pos : SV_POSITION;
				float3 worldNormal : TEXCOORD0;
			};

			v2f vert(a2v v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex); // this is vertex function's basic task
				o.worldNormal = mul(v.normal, (float3x3)_World2Object);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target {
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
				fixed3 worldNormal = normalize(i.worldNormal);
				fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
				//fixed halfLambert = dot(worldNormal,worldLight) * 0.5 + 0.5;
				//fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * halfLambert;// _LightColor0

				fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLight));// _LightColor0
				fixed3 color = ambient + diffuse;
				return fixed4(color, 1.0);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
