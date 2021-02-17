# Converting between different Shader Languages

... just wanted to try out tables in Markdown :-)

## General Concepts

The entry point for a compute shader is the *compute kernel* - this is the code executed by the GPU's shader unit. In GLSL this is the code's `main` function; in OpenCL it is a function with its definition preceded by the symbol `kernel`; in DCTL it's a function preceded by `__KERNEL__`. So for compatibility avoid naming your Kernel `main` or `kernel` as this might work on one, but not the other platform.

In the world of Shader Languages and Compute Shaders we have to juggle around with the following frameworks, APIs, toolkits, abstractions ...

- **GLSL** - [OpenGL ES 3.1 Spec](https://www.khronos.org/registry/OpenGL/specs/es/3.1/es_spec_3.1.pdf), [OpenGL 4.5 Reference Page](https://www.khronos.org/registry/OpenGL-Refpages/gl4/), and [OpenGL Wiki](https://www.khronos.org/opengl/wiki/Main_Page)... OpenGL ES is a platform and GPU agnostic API targeting embedded systems. It is a subset of OpenGL (aka Desktop OpenGL), offers a Shader Language (GLSL) that also provides Compute Shaders, and OpenGL ES makes up the core of WebGL.
- **DCTL** - :question::question::question:... the DaVinci Resolve Color Transformation Language seems to be just a layer on top of CUDA, Metal, OpenCL (utilizing the appropriate toolkit depending on your platform, GPU, and settings).
- **CUDA** - [CUDA Toolkit Documentation](https://docs.nvidia.com/cuda/) ... CUDA is the Nvidia toolkit to access Nvidia GPUs.
- **Metal** - [Metal SL Spec](https://developer.apple.com/metal/Metal-Shading-Language-Specification.pdf) ... Metal is the Apple GPU API for macOS, iOS, iPadOS, tvOS.
- **OpenCL** [OpenCL 1.2 Spec](https://www.khronos.org/registry/OpenCL/specs/opencl-1.2.pdf) ... is a platform independent API to realize Compute Shaders; it was originally introduces by Apple, but has been abandoned on Macs in favor of Metal; OpenCL kernels can run not only run on GPUs, but also on CPUs.

... if only we would have a DCTL spec it should ease the process of writing conversions from one language to the other :-/ ... there is the [CTL Manual](http://ampasctl.sourceforge.net/CtlManual.pdf), but I don't know if CTL defined an implementation and if and how DCTL is derived from it.


## Math Functions


| GLSL       | DCTL         | CUDA | Metal      | OpenCL |
|------------|--------------|------|------------|--------|
| sin(float) | _sinf(float) |      | sin(float) |        |
| cos(float) | _cosf(float) |      | cos(float) |        |


## Data Types and Type Conversion

### Vectors

Overview...

|float vector construction                      | ...             |
|----------------------------|-------------------|
|`float2 to_float2(float, float)` |  |
|`float2 to_float2_v(__CONSTANTREF__ float*)` | |
|`float2 to_float2_s(float)`| |
|`float2 to_float2_cint(int2)`| |
|`float2 to_float2_cuint(uint2)`| |
|`float3 to_float3(float, float, float)`| |
|`float3 to_float3_v(__CONSTANTREF__ float*)`| |
|`float3 to_float3_s(float)`| |
|`float3 to_float3_aw(float2, float)`| |
|`float3 to_float3_cint(int3)`| |
|`float3 to_float3_cuint(uint3)`| |
|`float4 to_float4(float, float, float, float)`| |
|`float4 to_float4_v(__CONSTANTREF__ float*)`| |
|`float4 to_float4_s(float)`| |
|`float4 to_float4_aw(float3, float)`| |
|`float4 to_float4_cint(int4)`| |
|`float4 to_float4_cuint(uint4)`| |


### 2-dimensional Vector


Schema of what I guess a `vec2` looks like:

```C++
struct vec2
{
  float x,y;

  vec2(float s) : x(s), y(s) {}
  vec2(const vec2& s) x(s.x), y(s.y) {}
};
```

... I'll bet there is some Open GL ES spec and/or include files that perfectly describe the WebGL data types and functions?!?


| System | Equivalent                                                   |
|--------|--------------------------------------------------------------|
| GLGS   |`vec2`; Construction: `vec2(float,float)`, `vec(float2)`      |
| DCTL   | L-Value: `float2`; R-Value: `to_float2(float,float)`, `to_float2_s(float)`, `to_float2_v(__CONSTANTREF__ float*)`, `to_float2_cint(int2)`, `to_float2_cuint(uint2 a)` |
| Cuda   |                                                              |
| Metal  |                                                              |
| OpenCL |                                                              |

Probably DCTL does only define some macros and functions, that make the GLSL digest-able for the different Shader Language dialects?!? It would be of great help, if these definitions are accessible anywhere!?!



### 3-dimensional Vector

| System | Equivalent                                                   |
|--------|--------------------------------------------------------------|
| GLGS   |`vec3`; Construction: `vec3(float,float,float)`, `vec3(vec2,float)`                        |
| DCTL   | L-Value: `float3`; R-Value: `to_float3(float,float,float)`, `to_float3_aw(float2,float)`, `to_float3_s(float)` |
| Cuda   |                                                              |
| Metal  |                                                              |
| OpenCL |                                                              |

Implementation provided by DCTL (on MacOS / Metal):

    __DEVICE___ inline float3 to_float3(float x, float y, float z)
    { float3 t;
      t.x=x;
      t.y=y;
      t.z=z;
      return t;
    }

### Swizzling

In OpenGL you can access the components of vectors using the following syntax:

    vec4 a;
    a.x = 1; a.y=2; a.z=3; a.w=4;
    vec2 b = a.yw;
    a = b.xyyx;

This is called *swizzling*.

      #define swixy(V)   to_float2((V).x,(V).y)
    //#define swixx(V)   to_float2((V).x,(V).x)
      #define swiyx(V)   to_float2((V).y,(V).x)
    //#define swiyy(V)   to_float2((V).y,(V).y)
      #define swizw(V)   to_float2((V).z,(V).w)
      #define swixyx(V)  to_float3((V).x,(V).y,(V).x)
      #define swiyzx(V)  to_float3((V).y,(V).z,(V).x)
      #define swixyxy(V) to_float4((V).x,(V).y,(V).x,(V).y)
    //...


## 2x2 Matrix

Workaround implementation:

    typedef struct
    {
      float2 r0;
      float2 r1;

    } mat2;

    __DEVICE__ inline mat2 to_mat2(float  a, float  b, float c, float d)
    {
      mat2 t;
      t.r0.x = a; t.r0.y = b;
      t.r1.x = c; t.r1.y = d;
      return t;
    }

    __DEVICE__ inline mat2 to_mat2_1f(float  a)
    {
      mat2 t;
      t.r0.x = a; t.r0.y = a;
      t.r1.x = a; t.r1.y = a;
      return t;
    }

    __DEVICE__ inline mat2 to_mat2_s(float  a )
    {
      mat2 t;
      t.r0.x = a;     t.r0.y = 0.0f;
      t.r1.x = 0.0f;  t.r1.y = a;
      return t;
    }

    //__DEVICE__ inline mat2 to_mat2_22(float2 a, float2 b)
    //  { mat2 t; t.r0 = a; t.r1 = b; return t; }
    //__DEVICE__ inline mat2 to_mat2_13(float  a, float3 b)
    //  { mat2 t; t.r0.x = a; t.r0.y = b.x; t.r1.x = b.y; t.r1.y = b.z; return t; }
    //__DEVICE__ inline mat2 to_mat2_31 (float3 a, float  b)
    //  { mat2 t; t.r0.x = a.x; t.r0.y = a.y; t.r1.x = a.z; t.r1.y = b; return t; }


    __DEVICE__ inline mat2 prod_mat2_mat2( mat2 a, mat2 b)
    {
      mat2 t;
      t.r0.x = a.r0.x * b.r0.x + a.r0.y * b.r1.x;  t.r0.y = a.r0.x * b.r0.y + a.r0.y * b.r1.y;
      t.r1.x = a.r1.x * b.r0.x + a.r1.y * b.r1.x;  t.r1.y = a.r1.x * b.r0.y + a.r1.y * b.r1.y;
      return t;
    }


    __DEVICE__ inline float2 prod_float2_mat2( float2 v, mat2 m )
    {
      float2 t;
      t.x = v.x*m.r0.x + v.y*m.r0.y;
      t.y = v.x*m.r1.x + v.y*m.r1.y;
      return t;
    }


    __DEVICE__ inline float2 prod_mat2_float2( mat2 m, float2 v )
    {
      float2 t;
      t.x = v.x*m.r0.x + v.y*m.r1.x;
      t.y = v.x*m.r0.y + v.y*m.r1.y;
      return t;
    }


    __DEVICE__ inline mat2 prod_mat2_1f( mat2 m, float s)
    {
      mat2 t;
      t.r0.x = s * m.r0.x;  t.r0.y = s * m.r0.y;
      t.r1.x = s * m.r1.x;  t.r1.y = s * m.r1.y;
      return t;
    }

    __DEVICE__ inline mat2 prod_1f_mat2( float s, mat2 m)
    {
      return prod_mat2_1f(m,s);
    }


### 3x3 Matrix

| System | Equivalent                                                                    |
|--------|-------------------------------------------------------------------------------|
| GLGS   |`mat3`; Construction: `mat3(vec3,vec3,vec3)`                                   |
| DCTL   | **Workaround:** L-Value: `mat3`; Construction: `to_mat3(float3,float3,float3)`|
| Cuda   |                                                                               |
| Metal  | `float3x3`; Construction: `float3x3(float)`, `float3x3(float3,float3,float3)`                    |
| OpenCL |                                                                               |




Workaround implementation:

```c
typedef struct
{
  float3 r0, r1, r2;
} mat3;


__DEVICE__ inline mat3 to_mat3( float3 a, float3 b, float3 c)
{
  mat3 d;
  d.r0 = a;
  d.r1 = b;
  d.r2 = c;
  return d;
}
```

In Metal a `float3x3(fval)` creates ...

    fval  0.0   0.0
    0.0   fval  0.0
    0.0   0.0   fval

... which could be an indicator of how to implement a `mat3(float)`if something like this exists?!?


### 2D Texture

| System | Equivalent                                                   |
|--------|--------------------------------------------------------------|
| GLGS   |`sampler2D`                                                   |
| DCTL   | `__TEXTURE2D__`                                              |
| Cuda   |                                                              |
| Metal  | `texture2d<float,access::sample>`                            |
| OpenCL |                                                              |






----

Could be better for an overview, but the table gets too wide:

| GLGS / WebGL / OpenGL ES | DCTL     | Cuda | Metal | OpenCL |
|--------------------------|----------|------|-------|--------|
| `vec3` (L-Value)         | `float3` |      |       |        |
| `vec` (R-Value)          | `to_float3(float,float,float)` | | | |
| `sampler2D` | `__TEXTURE2D__` | | `texture2d<float,access::sample>` | |



----

... okay, you guys get the idea what I tried with this page - but I guess this approach is totally insane.