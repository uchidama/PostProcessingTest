using UnityEngine;
using UnityEngine.Rendering.PostProcessing;

public sealed class ScalingRenderer : PostProcessEffectRenderer<Scaling>
{
    // 初期化時の処理
    public override void Init()
    {
        base.Init();
    }

    public override void Render(PostProcessRenderContext context)
    {
        // 内部的にプールされているMaterialPropertyBlockが保存されているPropertySheetを取得
        var sheet = context.propertySheets.Get(Shader.Find("Hidden/Custom/Scaling"));

        // MaterialPropertyBlockに対してプロパティをセット
        sheet.properties.SetFloat("_Scale", settings.scale);

        // CommandBufferのBlitFullscreenTriangleを使って描画
        context.command.BlitFullscreenTriangle(context.source, context.destination, sheet, 0);
    }

    // 破棄時の処理
    public override void Release()
    {
        base.Release();
    }
}