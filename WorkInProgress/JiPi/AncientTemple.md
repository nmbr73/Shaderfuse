Ancient Temple
==================

Based on '_[Ancient Temple](https://www.shadertoy.com/view/4lX3Rj)_' by [Kali](https://www.shadertoy.com/user/kali) and ported by ported by [JiPi](../../Site/Profiles/JiPi.md).

When converting this shadertoy, there is a major difference between WebGL and DCTL.
In the original, the superstructures and the ball are given a grain. This is not implemented under DCTL. I was able to identify the following line that is used for the calculation:

``
es + = exp (-1.2 / abs (l-pl));
``

I tried to find a workaround through various measures, such as

```
#define _e 2.71828182846

...

es + = pow_cf (_e / 2.0, -1.2 / abs (l-pl));
```

I haven't been able to get anywhere near a grain. My guess is that for some reason the sampling over the entire frame is lost via the functions for this feature.


Fragmentshader in Resolve:

![AncientTemple](https://user-images.githubusercontent.com/78935215/112473642-e605f080-8d6e-11eb-94f3-21c14a07c8d2.gif)

Original Shadertoy Screenshot:

![Screen Shot 03-25-21 at 01 42 PM](https://user-images.githubusercontent.com/78935215/112474494-fec2d600-8d6f-11eb-8f0d-5eb3ec87be37.PNG)
