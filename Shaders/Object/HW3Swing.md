

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT ADD OR EDIT ANY TEXT BEFORE THIS LINE +++ IT WOULD BE A REALLY BAD IDEA +++ -->

I love these Wannerstedt videos and here I found one in the Shadertoy. The challenge was to resolve the global variables. It is also a nice example of using mat4.


```
// **** mat4 ****
typedef struct
  {
  float4 r0, r1, r2, r3;
  } mat4;


__DEVICE__ inline mat4 make_mat4 (float4 A, float4 B,
                                  float4 C, float4 D)
  {
  mat4 _ret;
  _ret.r0 = A;
  _ret.r1 = B;
  _ret.r2 = C;
  _ret.r3 = D;
  return _ret;
  }

__DEVICE__ inline float4 mat4_multi_f4 (mat4 B, float4 A) {
  float4 C;
  C.x = A.x * B.r0.x + A.y * B.r1.x + A.z * B.r2.x + A.w * B.r3.x;
  C.y = A.x * B.r0.y + A.y * B.r1.y + A.z * B.r2.y + A.w * B.r3.y;
  C.z = A.x * B.r0.z + A.y * B.r1.z + A.z * B.r2.z + A.w * B.r3.z;
  C.w = A.x * B.r0.w + A.y * B.r1.w + A.z * B.r2.w + A.w * B.r3.w;
  return C;
  }
```

[![HW3Swing](HW3Swing_screenshot.png "HW3Swing.fuse in DaVinci Resolve")](HW3Swing.fuse)

<!-- +++ DO NOT REMOVE THIS COMMENT +++ DO NOT EDIT ANY TEXT THAT COMES AFTER THIS LINE +++ TRUST ME: JUST DON'T DO IT +++ -->

