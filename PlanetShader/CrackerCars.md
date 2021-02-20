CrackerCars.fuse
================

Based on '_[CrackerCars](https://www.shadertoy.com/view/4sdXzr)_' by [zackpudil](https://www.shadertoy.com/user/zackpudil) and ported by [J-i-P-i](https://www.youtube.com/channel/UCItO4q_3JgMVV2MFIPDGQGg). Cute little racing cars roar around on small planets. All colors are changeable

[![screenshot](https://user-images.githubusercontent.com/78935215/108132260-d41b9880-70b2-11eb-8426-f612cfd63cd8.PNG)](https://github.com/nmbr73/Shadertoys/blob/main/PlanetShader/CrackerCars.fuse)


A solution has been found for the tiresome multi-dimensional variable conversion. nmbr73 has defined cute defines ;-)
And OpenCL can have overloaded functions

```
  #define swixy(V) to_float2((V).x,(V).y)
  #define swixx(V) to_float2((V).x,(V).x)
  #define swiyx(V) to_float2((V).y,(V).x)
  #define swiyy(V) to_float2((V).y,(V).y)
```
Have fun

[![CrackerCars](https://user-images.githubusercontent.com/78935215/108132745-b00c8700-70b3-11eb-97f1-8b6e9dcec3ca.gif)](https://www.shadertoy.com/embed/4sdXzr?gui=true&t=10&paused=true&muted=false)
