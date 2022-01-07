// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Custom/Scaling"
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
