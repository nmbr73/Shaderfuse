ProceduralWalkAnimation.fuse :runner:
===========

Based on '_[ProceduralWalkAnimation](https://www.shadertoy.com/view/WlsSWS)_' by [TLC123](https://www.shadertoy.com/user/TLC123) and ported by [JiPi](../../Site/Profiles/JiPi.md).

A figure runs after his head on uneven terrain.
The very good animation made this a very interesting shader.
This function does this.

```
 vec3 timefly(float t) {
    // main path Called from many places
    t*=.80;
	t += (.125 + sin(t * .125));
	vec3 v =
	vec3(sin(t / 50.) * 20., 0., cos(t / 25.) * 24.) +
		vec3(sin(t / 17.1) * 07., 0., cos(t / 17.1) * 05.) +
		vec3(sin(t / 8.1) * 6., 0., cos(t / 8.1) * 8.) +
		vec3(cos(t / 3.) * 3.,0., sin(t / 3.) * 2.)
        +vec3(cos(t  )*2.,0., sin(t  )*2. );
    v.y=pathterrain(v.x,v.z);
    return v        ;
}
```
In the original, the texture is fixed. In the fuse you can choose between a changeable color or a texture connected via Image1 and Image2, this can then be adjusted using an offset and scale. A head is already provided in the right place in the shader. This can be selected using the checkboxes. With this shader, the replacement function for fwidth works very well. In the end, it was hard work to get this shader to work under OpenCL. Since all parts of the figure were defined as global variables, a structure had to be built that had to be looped through almost all functions. After loading the fuse, it takes a short moment for the code to be compiled in the graphics card, after which the playback is almost in real time.

Have fun playing

![ProceduralWalkAnimation](https://user-images.githubusercontent.com/78935215/121263523-05181700-c8b6-11eb-98f5-aa44d178ce23.gif)



[![ProceduralWalkAnimation](ProceduralWalkAnimation.png)](ProceduralWalkAnimation.fuse)



## Compatibility
- [ ] Tested on macOS/Metal
- [ ] Tested on macOS/OpenCL
- [x] Tested on Windows/Cuda
- [x] Tested on Windows/OpenCL
