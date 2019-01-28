Shader "Custom/DiffuseVertex" {
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
				fixed3 color : COLOR;
			};

			v2f vert(a2v v) {
				v2f o;
				o.pos = mul(UNITY_MATRIX_MVP, v.vertex); // this is vertex function's basic task
				fixed3 ambient = UNITY_LIGHTMODEL_AMBIENT.xyz;
				fixed3 worldNormal = normalize(mul(v.normal, (float3x3)_World2Object));
				fixed3 worldLight = normalize(_WorldSpaceLightPos0.xyz);
				fixed3 diffuse = _LightColor0.rgb * _Diffuse.rgb * saturate(dot(worldNormal, worldLight));// _LightColor0 
				o.color = ambient + diffuse;
				return o;
			}

			fixed4 frag(v2f i) : SV_Target {
				return fixed4(i.color, 1.0);
			}
			ENDCG
		}
	}
	FallBack "Diffuse"
}
