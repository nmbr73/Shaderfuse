Physically-BasedSoapBubble
==================

Based on '_[Physically-BasedSoapBubble](https://www.shadertoy.com/view/XtKyRK)_' by [totimannino](https://www.shadertoy.com/user/totimannino) and ported by ported by [JiPi](../../Site/Profiles/JiPi.md).

I love soap bubbles. My first soap bubble conversion was also the hardest yet. For reasons beyond my imagination, there were long artifacts in the shader. Until I finally found a workaround. But this only worked with Cuda.
Here is a new approach, but no less tricky. The use of the mat3 was carried out according to a tried and tested model. But the use of the mat4 meant a lot of modifications for the DCTL. Unfortunately, there is no equivalent for DCTL for either cubemaps or volumes. Therefore a replacement had to be made for it. Unfortunately, of course, the 360 degree view and the mirroring are lost, but it is still very impressive.

```
    mat4 rval = mat4(vec4(0.0, 0.0, 0.0, -1.0),
                     vec4(0.0, 0.0, 0.0, -1.0),
                     vec4(0.0, 0.0, 0.0, -1.0),
                     vec4(0.0, 0.0, 0.0, -1.0));
    if(count > 0.01 ) {
        if(count < 1.1) {
            rval[0] = vec4(normalize(minfronthit.xyz),minfronthit.w);
```



![Physically-BasedSoapBubble](https://user-images.githubusercontent.com/78935215/113588610-abcf0580-9630-11eb-83f3-6e59fad873b4.gif)
