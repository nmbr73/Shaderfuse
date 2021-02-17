# CrackerCars.fuse

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



