# Converting between different Shader Languages

... just wanted to try out tables in Markdown :-)

## General Concepts

The entry point for a compute shader is the *compute kernel* - this is the code executed by the GPU's shader unit. In GLSL this is the code's `main` function; in OpenCL it is a function with its definition preceded by the symbol `kernel`; in DCTL it's a function preceded by `__KERNEL__`. So for compatibility avoid naming your Kernel `main` or `kernel` as this might work on one, but not the other platform.

In the world of Shader Languages and Compute Shaders we have to juggle around with the following frameworks, APIs, toolkits, abstractions ...

- **GLSL** - [OpenGL ES 3.1 Spec](https://www.khronos.org/registry/OpenGL/specs/es/3.1/es_spec_3.1.pdf) ... OpenGL ES is a platform and GPU agnostic API targeting embedded systems. It is a subset of OpenGL (aka Desktop OpenGL), offers a Shader Language (GLSL) that also provides Compute Shaders, and OpenGL ES makes up the core of WebGL.
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

### 2-dimensional Vector

Schema of what I guess a `vec2` looks like:

```C++
struct vec2
{
  float x;
  float y;

  vec2(float s)
  {
    x=y=s;
  }

  vec2(const vec2& s)
  {
    x=s.x;
    y=s.y;
  }
};
```

... I'll bet there is some Open GL ES spec and/or include files that perfectly describe the WebGL data types and functions?!?


| System | Equivalent                                                   |
|--------|--------------------------------------------------------------|
| GLGS   |`vec2`; Construction: `vec2(float,float)`                                                        |
| DCTL   | L-Value: `float2`; R-Value: `to_float2(float,float)`, `to_float2_s(float)` |
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
      t.x=y; 
      t.z=z;
      return t;
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