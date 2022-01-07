using System;
using UnityEngine;
// UnityEngine.Rendering.PostProcessingをusing
using UnityEngine.Rendering.PostProcessing;


[Serializable] // 必ずSerializableアトリビュートを付ける
[PostProcess(typeof(MonotoneRenderer), PostProcessEvent.AfterStack, "Custom/Monotone", true)]
public sealed class Monotone : PostProcessEffectSettings
{
    //[Range(0f, 1f)]
    //public FloatParameter scale = new FloatParameter { value = 0.0f };

    // 有効化する条件はこうやって指定する（ちゃんとやっておいたほうがパフォーマンスにつながりそう）
    public override bool IsEnabledAndSupported(PostProcessRenderContext context)
    {
        //return base.IsEnabledAndSupported(context) || scale != 0;
        return base.IsEnabledAndSupported(context);
    }
}