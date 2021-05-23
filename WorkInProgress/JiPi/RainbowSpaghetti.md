RainbowSpaghetti
==================

Based on '_[RainbowSpaghetti](https://www.shadertoy.com/view/lsjGRV)_' by [mattz](https://www.shadertoy.com/user/mattz) and ported by [JiPi](../../Site/Profiles/JiPi.md).

A flight through lots of colorful spaghetti. An interesting solution for the tracking shot is available in this shader.

```
	mat3 Rx = mat3(1.0, 0.0, 0.0, 
				   0.0,  cx,  sx,
				   0.0, -sx,  cx);
	
	mat3 Ry = mat3( cy, 0.0, -sy,
				   0.0, 1.0, 0.0,
				    sy, 0.0, cy);

	mat3 R = mat3(rx,ry,rz);
	mat3 Rt = mat3(rx.x, ry.x, rz.x,
				   rx.y, ry.y, rz.y,
				   rx.z, ry.z, rz.z);

	vec3 rd = R*Rx*Ry*normalize(vec3(uv, f));
	
	vec3 ro = tgt + R*Rx*Ry*Rt*(cpos-tgt);
```

![RainbowSpaghetti](https://user-images.githubusercontent.com/78935215/119272025-65dff800-bc04-11eb-8150-396ea04bda63.gif)
