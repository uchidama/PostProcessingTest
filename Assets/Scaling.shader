// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Custom/Scaling"
{
    /*
    Properties{
        _MainTex("MainTex", 2D) = "white" {}
        _Level("Level", Range(0, 1)) = 0.2
        _Speed("Speed", Range(0, 3)) = 0.5
        _RoundTrip("RoundTrip", Range(1, 5)) = 1
    }
    SubShader{
        Pass{
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex:POSITION;
                float3 normal:NORMAL;
                float4 texcoord:TEXCOORD0;
            };

            struct v2f
            {
                float4 pos:POSITION;
                float2 uv:TEXCOORD0;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Level;
            float _Speed;
            float _RoundTrip;

            v2f vert(appdata_t v)
            {
                v2f o;
                o.pos = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }

            float4 frag(v2f i) :COLOR{
                //1秒で _Speed ずつ加算されるタイムの作成
                float time = _Time.y * _Speed;
                //y座標(0 ~ 1)における波形のスタート位置のズレ
                float dy = time - floor(time);
                //x座標(0 ~ 1)のズレ
                float dx = sin(radians((i.uv.y - dy) * 360 * floor(_RoundTrip))) * _Level;
                //ピクセルの位置を計算
                float2 uv = float2(i.uv.x + dx, i.uv.y);
                //x座標が範囲外になってるものは黒で塗りつぶす
                if (uv.x < 0 || 1 < uv.x)
                    return float4(0, 0, 0, 0);
                return tex2D(_MainTex, uv);
            }
            ENDCG
        }
    }
    */

    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            // CGPROGRAMではなくHLSLPROGRAMにする
            HLSLPROGRAM

            #pragma vertex VertDefault
            #pragma fragment Frag
            
            // VaryingsDefaultとかを使うためにインクルードする必要あり
            #include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

            TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);

            float _Scale;

            float4 Frag(VaryingsDefault i) : SV_Target
            {
                // テクスチャの取り方とかはCGとは異なるので注意
                i.texcoord -= 0.5; // 0～1の値を-0.5～0.5の値にする
                i.texcoord *= 1.0 - _Scale; // スケーリング
                i.texcoord += 0.5;
                float4 color = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord);
                return color;
            }
            ENDHLSL
        }
    }

}
