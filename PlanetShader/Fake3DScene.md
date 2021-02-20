# Fake3DScene.fuse

Based on '_[Fake3DScene](https://www.shadertoy.com/view/MddSWB)_' by [LaBodilsen](https://www.shadertoy.com/user/LaBodilsen) and ported by [J-i-P-i](https://www.youtube.com/channel/UCItO4q_3JgMVV2MFIPDGQGg). A little Shader for occasionally.

![Fake3DScene](Fake3DScene.png "Fake3DScene.fuse")

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


![screenshot](Fake3DScene_screenshot.PNG "Fake3DScene.fuse in DaVinci Resolve")


Have fun