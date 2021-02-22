# RayCastSphere.fuse

Based on '_[RayCastSphere](https://www.shadertoy.com/embed/XdjBDG?gui=true&t=10&paused=true&muted=false)_' by [diroru](https://www.shadertoy.com/user/diroru) and ported by [JiPi](../Profiles/JiPi.md). A good example of displacement.

[![screenshot](RayCastSphere.png "RayCastSphere.fuse in DaVinci Resolve")](https://github.com/nmbr73/Shadertoys/blob/main/PlanetShader/RayCastSphere.fuse)

To use this Fuse you need two images as an input, one for Surface texture (Image) and one for the displacement (depth).

There are no parameters yet except for the background color.

An interesting realization of the displacement

```
float displacement = texture(iChannel1, latlon).r*100.0;
        if (d <= sphereRadius + displacement && d > 0.0) {

            fragColor = texture(iChannel0, latlon).xxxx;

            break;
        }
```

Have fun