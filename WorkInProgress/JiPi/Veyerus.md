Veyerus
==================

Based on '_[Veyerus](https://www.shadertoy.com/view/WltXDn)_' by [monsterkodi](https://www.shadertoy.com/user/monsterkodi) and porting by [JiPi](Profiles/JiPi.md).

Most extensive conversion yet. On the one hand, a solution had to be found for the structure arrays; on the other hand, a global structure led to a completely destroyed image structure. The conversion then took place in several stages. Now the corresponding parameterization for the animation is still missing.

```
struct VecMap {
    vec3[32] vecs;
    int num;
};

VecMap[5] vecMap = VecMap[5](
    VecMap(cubo,   26),
    VecMap(dodeca, 12),
    VecMap(icosa,  20),
    VecMap(weirdo, 12),
    VecMap(dodecaicosa, 32)
);
```

```
struct _gl {
    vec2  uv;
    vec2  frag;
    vec2  mouse;
    vec2  mp;
    ivec2 ifrag;
    float aspect;
    vec4  color;
    int   option;
    float time;
    vec3  light;
    int   zero;
    SDF   sdf;
} gl;
```
The first Version with destroyed image structure:

![Veyerus_V1_Defekt](https://user-images.githubusercontent.com/78935215/114778649-6966a080-9d75-11eb-8063-fbade8d27e77.gif)

The corrected version:

![Veyerus](https://user-images.githubusercontent.com/78935215/114778884-b77ba400-9d75-11eb-9137-be28f748260e.gif)
