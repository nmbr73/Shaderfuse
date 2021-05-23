MagicMorphingCube
==================

Based on '_[MagicMorphingCube](https://www.shadertoy.com/view/Xd3cR7)_' by [laserdog](https://www.shadertoy.com/user/laserdog) and ported by [JiPi](../../Site/Profiles/JiPi.md).

A cube rotates and the surface is cyclically changed by a red electrical impulse.
At first reminiscent of the Lonley Voxel, but technically has little in common with this code.
The realization of the camera with a mat4 matrix is interesting here.

```
    mat4 viewMat = lookAt(eye, vec3(0.), vec3(0., 1., 0.));
    ray = (viewMat * vec4(ray, 1.)).xyz;
```

![MagicMorphingCube_1](https://user-images.githubusercontent.com/78935215/119269782-bf8ef500-bbf9-11eb-9b4e-63a89aceeaa6.gif)
