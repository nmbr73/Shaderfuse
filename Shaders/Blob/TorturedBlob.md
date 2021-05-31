TorturedBlob.fuse
================

Based on '_[TorturedBlob](https://www.shadertoy.com/view/MlKGDK)_' by [roywig](https://www.shadertoy.com/user/roywig) and ported by [JiPi](../../Site/Profiles/JiPi.md). A classic blob with a lot of deformations. Tested under Cuda and OpenCL, test under metal is pending

[![screenshot](TorturedBlob.png)](https://github.com/nmbr73/Shadertoys/blob/main/BlobShader/TorturedBlob.fuse)


A nice example of the use of the mat3

```
 //**** mat3 ****
 typedef struct
  {
  float3 r0, r1, r2;
  } mat3;
```
Have fun

## Compatibility
- [x] Tested on macOS/Metal
- [x] Tested on macOS/OpenCL
- [x] Tested on Windows/Cuda
- [x] Tested on Windows/OpenCL
