

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->

A little Shader for occasionally.

[![screenshot](Fake3DScene_screenshot.png "Fake3DScene.fuse in DaVinci Resolve")](https://github.com/nmbr73/Shadertoys/blob/main/PlanetShader/Fake3DScene.fuse)

To use this Fuse you need two images as an input, one for the Ball (Image) and one for the Ground (Ground).

In addition to the standard parameters such as Center, Scale, Angle and Frequency, you have the option of adjusting the floor and ball displacement and their speed. With two parameters it is possible to change the lighting of the ball.

This is a nice shader to explore the use of a 2 dimensional matrix. With the help of this block, the lack of mat2 in DCTL can be canceled:

```
//-------- mat2 ---------
 typedef struct
  {
      float2 r0, r1;
  } mat2;

 __DEVICE__ inline mat2 make_mat2_2( float A, float B, float C, float D)
  {
      mat2 E;
      E.r0 = to_float2(A,B);
      E.r1 = to_float2(C,D);
      return E;
  }

 __DEVICE__ inline float2 f2_multi_mat2( float2 A, mat2 B)
  {
      float2 C;
      C.x = A.x * B.r0.x + A.y * B.r0.y;
      C.y = A.x * B.r1.x + A.y * B.r1.y;
      return C;
  }
```

Have fun

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE +++ TRUST ME: JUST DON'T DO IT +++ -->

