Shader "Hidden/Custom/Monotone" {

    SubShader
    {
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            HLSLPROGRAM

            #pragma vertex VertDefault
            #pragma fragment Frag
            
            // VaryingsDefaultとかを使うためにインクルードする必要あり
            #include "Packages/com.unity.postprocessing/PostProcessing/Shaders/StdLib.hlsl"

            TEXTURE2D_SAMPLER2D(_MainTex, sampler_MainTex);


            float4 Frag(VaryingsDefault i) : SV_Target
            {
                // これで色取得
                float4 c = SAMPLE_TEXTURE2D(_MainTex, sampler_MainTex, i.texcoord);
                float gray = c.r * 0.3 + c.g * 0.6 + c.b * 0.1;

                float4 color = float4(gray,gray,gray,c.a);
                return color;
            }
            ENDHLSL
        }
    }

}