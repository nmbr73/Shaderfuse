SatisfactionMachine
==================

Based on '_[SatisfactionMachine](https://www.shadertoy.com/view/tdGfDy)_' by [shau](https://www.shadertoy.com/user/shau) and porting by [JiPi](Profiles/JiPi.md).

The Neverending Story - a fun shader that requires little code.

And a very unusual way of calculating the normals.

```
vec3 normal(vec3 p) 
{  
    vec4 n = vec4(0.0);
    for (int i=ZERO; i<4; i++) 
    {
        vec4 s = vec4(p, 0.0);
        s[i] += EPS;
        n[i] = map(s.xyz).x;
    }
    return normalize(n.xyz-n.w);
}
```



![SatisfactionMachine](https://user-images.githubusercontent.com/78935215/117588117-b8f47e00-b121-11eb-9202-a250ada3d523.gif)
