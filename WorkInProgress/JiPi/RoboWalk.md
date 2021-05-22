RoboWalk
==================

Based on '_[RoboWalk](https://www.shadertoy.com/view/WlyGDt)_' by [shau](https://www.shadertoy.com/user/shau) and ported by ported by [JiPi](../../Site/Profiles/JiPi.md).

A two-legged robot runs bouncy through the room. In the original, the animation was calculated in a buffer and stored in the intermediate image. In the image calculation, the values were then read out from the buffer image.
The object is designed with only two colors, in the original a light and dark gray. Due to the numerous matrix multiplications, this shader is a performance hog.

```
    //animation
    vec4 leftHip = texture(iChannel0, LH/R),
         rightHip = texture(iChannel0, RH/R),
         leftKnee = texture(iChannel0, LK/R),
         rightKnee = texture(iChannel0, RK/R),
         leftAnkle = texture(iChannel0, LA/R),
         rightAnkle = texture(iChannel0, RA/R),
         height = texture(iChannel0, H/R);

    p.y -= height.x;
```



![RoboWalk](https://user-images.githubusercontent.com/78935215/118018523-2f7ac100-b358-11eb-8a24-25c35e56545e.gif)
