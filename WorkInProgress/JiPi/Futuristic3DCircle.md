Futuristic3DCircle
==================

Based on '_[Futuristic3DCircle](https://www.shadertoy.com/view/WsG3D3)_' by [jaszunio15](https://www.shadertoy.com/user/jaszunio15) and ported by ported by [JiPi](../../Site/Profiles/JiPi.md).

In the original, three buffers connected in series create a bokeh effect. The creation of this construct is very interesting. In particular, the calculation of the rotation across the axes is very complex.


```
    mat3 rotation =	  mat3(-cos(angleZ),  sin(angleZ), 0,
                           -sin(angleZ), -cos(angleZ), 0,
                           0, 			 0, 		   1)
        			* mat3(1,            0, 		   0,
                           0, -cos(angleX),  sin(angleX),
                           0, -sin(angleX), -cos(angleX))
        			* mat3(-cos(angleY), 0,  sin(angleY),v
                           0, 			 1,            0,
                           -sin(angleY), 0, -cos(angleY));
```

![Futuristic3DCircle](https://user-images.githubusercontent.com/78935215/118017964-80d68080-b357-11eb-9ed9-88f09e196575.gif)
