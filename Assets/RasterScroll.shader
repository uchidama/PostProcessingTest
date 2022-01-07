// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Custom/RasterScroll"
{
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

            float _Level;
            float _Speed;
            float _RoundTrip;

            float4 Frag(VaryingsDefault i) : SV_Target
            {
                // テクスチャの取り方とかはCGとは異なるので注意
                //1秒で _Speed ずつ加算されるタイムの作成
                float time = _Time.y * _Speed;
                //y座標(0 ~ 1)における波形のスタート位置のズレ
                float dy = time - floor(time);
                //x座標(0 ~ 1)のズレ
                float dx = sin(radians((i.texcoord.y - dy) * 360 * floor(_RoundTrip))) * _Level;
                //ピクセルの位置を計算
                float2 uv = float2(i.texcoord.x + dx, i.texcoord.y);
                //x座標が範囲外になってるものは黒で塗りつぶす
                if (uv.x < 0 || 1 < uv.x)
                    return float4(0, 0, 0, 0);                

                float4 color = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, uv);
                return color;
            }


            ENDHLSL
        }
    }

}
