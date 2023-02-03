# ShareX

This Fuse is based on the Shadertoy '_[ShareX](https://www.shadertoy.com/view/WsKSRK)_' by [fre3k](https://www.shadertoy.com/user/fre3k). Conversion to DCTL and encapsulation into a fuse done by [JiPi](../../Site/Profiles/JiPi.md). See [Object](README.md) for more fuses in this category.

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->

So much shader in so little code - really amazing.

```
	//Functionality.......
    float t;
	t = itime * 0.91f;
    float2 r = iResolution,
    o = fragCoord - r/2.0f;
    o = make_float2(length(o) / r.y - 0.3f, _atan2f(o.y,o.x));
    float4 s = 0.08f*cos_f4(1.5f*make_float4(0,1,2,3) + t + o.y + _sinf(o.y) * _cosf(t)),
    e = swiyzwx(s),
    f = _fmaxf(o.x-s,e-o.x);
    fragColor = dot(clamp(f*r.y,0.0f,1.0f), 72.0f*(s-e)) * (s-0.1f) + f;

	if (params->Alpha_Apply) fragColor.w = params->Alpha;

    _tex2DVec4Write(dst, x, y, fragColor);

```

Have fun

[![screenshot](ShareX_screenshot.png "ShareX.fuse in DaVinci Resolve")](ShareX.fuse)

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE +++ TRUST ME: JUST DON'T DO IT +++ -->

## Compatibility

🟩 macOS / Metal: <span style="color:green; ">checked</span><br />
⬛ macOS / OpenCL: <span style="color:red; ">NOT TESTED!</span><br />
⬛ Windows / CUDA: <span style="color:red; ">NOT TESTED!</span><br />
🟩 Windows / OpenCL: <span style="color:green; ">checked</span><br />


## Problems

Number of problems: 3

- Thumbnail seems to be not a 320x180 pixel PNG
- macOS_OpenCL compatibility not checked
- Windows_CUDA compatibility not checked



