HW3Swing.fuse
====================

Based on '_[HW3Swing](https://www.shadertoy.com/view/wslGz7)_' by [wyatt](https://www.shadertoy.com/user/wyatt) and ported by [JiPi](../../Site/Profiles/JiPi.md)

I love these Wannerstedt videos and here I found one in the Shadertoy. The challenge was to resolve the global variables. It is also a nice example of using mat4.

Does not run on Metal; some minor rework to be done.

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

[![HW3Swing](HW3Swing.png "HW3Swing.fuse in DaVinci Resolve")](HW3Swing.fuse)


## Compatibility
- [ ] Tested on macOS/Metal :bomb::bomb::bomb:
- [ ] Tested on macOS/OpenCL
- [x] Tested on Windows/Cuda
- [ ] Tested on Windows/OpenCL
