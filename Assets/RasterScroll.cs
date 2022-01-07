using System;
using UnityEngine;
// UnityEngine.Rendering.PostProcessingをusing
using UnityEngine.Rendering.PostProcessing;


[Serializable] // 必ずSerializableアトリビュートを付ける
[PostProcess(typeof(RasterScrollRenderer), PostProcessEvent.AfterStack, "Custom/RasterScroll", true)]
public sealed class RasterScroll : PostProcessEffectSettings
{
    [Range(0f, 1f)]
    public FloatParameter level = new FloatParameter { value = 0.2f };

    [Range(0f, 3f)]
    public FloatParameter speed = new FloatParameter { value = 0.5f };


    [Range(1f, 5f)]
    public FloatParameter roundTrip = new FloatParameter { value = 1.0f };


    // 有効化する条件はこうやって指定する（ちゃんとやっておいたほうがパフォーマンスにつながりそう）
    public override bool IsEnabledAndSupported(PostProcessRenderContext context)
    {
        return base.IsEnabledAndSupported(context) || level != 0;
    }
}