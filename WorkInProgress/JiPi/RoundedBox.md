RoundedBox
==================

Based on '_[Rounded Box - intersection](https://www.shadertoy.com/view/WlSXRW)_' by [iq](https://www.shadertoy.com/user/iq) and porting by [JiPi](Profiles/JiPi.md).

A very interesting shader. The box is calculated using the inverse mat4. The calculation of the "normals" is also interesting.

```
//======================================================
// rotation matrix
mat4 rotate( vec3 v, float angle )
{
    float s = sin( angle );
    float c = cos( angle );
    float ic = 1.0 - c;

    return mat4( v.x*v.x*ic + c,     v.y*v.x*ic - s*v.z, v.z*v.x*ic + s*v.y, 0.0,
                 v.x*v.y*ic + s*v.z, v.y*v.y*ic + c,     v.z*v.y*ic - s*v.x, 0.0,
                 v.x*v.z*ic - s*v.y, v.y*v.z*ic + s*v.x, v.z*v.z*ic + c,     0.0,
			     0.0,                0.0,                0.0,                1.0 );
}

// transform points and vectors
vec3 ptransform( in mat4 mat, in vec3 v ) { return (mat*vec4(v,1.0)).xyz; }
vec3 ntransform( in mat4 mat, in vec3 v ) { return (mat*vec4(v,0.0)).xyz; }
//======================================================
```



![RoundedBox](https://user-images.githubusercontent.com/78935215/117371695-9ca9d480-aec8-11eb-9ce2-68aa8f5ddea9.gif)

