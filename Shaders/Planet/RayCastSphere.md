A good example of displacement.

[![screenshot](RayCastSphere_screenshot.png "RayCastSphere.fuse in DaVinci Resolve")](https://github.com/nmbr73/Shaderfuse/blob/main/PlanetShader/RayCastSphere.fuse)

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