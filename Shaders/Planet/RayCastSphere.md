# RayCastSphere

This Fuse is based on the Shadertoy '_[RayCastSphere](https://www.shadertoy.com/view/XdjBDG)_' by [diroru](https://www.shadertoy.com/user/diroru). Conversion to DCTL and encapsulation into a fuse done by [JiPi](../../Site/Profiles/JiPi.md). See [Planet](README.md) for more fuses in this category.

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->

A good example of displacement.

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

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE +++ TRUST ME: JUST DON'T DO IT +++ -->

## Problems

Number of problems: 1

- Thumbnail seems to be not a 320x180 pixel PNG



