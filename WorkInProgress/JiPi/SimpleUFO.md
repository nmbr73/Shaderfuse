Simple UFO
==================

Based on '_[SimpleUFO](https://www.shadertoy.com/view/Wt2cRt)_' by [CyanMARgh](https://www.shadertoy.com/user/CyanMARgh) and porting by [JiPi](Profiles/JiPi.md).


A cute little spaceship that hovers staggering over its launch site.
An unusual lighting concept was implemented here.
The author plans a 3D printout and use as a keychain.

```
    if (depth < depthmax){
        vec3 n = norm(pos);

        // adding 3 point lights and one directional light
        lighting += getLight(pos, vec3(6., 8., 0.), n, vec3(1.,.9,.9), 15.,false);
        lighting += getLight(pos, vec3(6., 8., -10.), n, vec3(1.,1.,1.), 50.,false);
        lighting += getLight(pos, vec3(-10., 10., -2.), n, vec3(1.,1.,1.), 30.,false);
        lighting += getLight(pos, vec3(2., 13., -10.), n, vec3(1.,.9,.9), 120.,true);
        
        //lighting -= getOcc(pos, n);
		col *= lighting;
    }else{
        col=backcol;
    }
```

![SimpleUFO](https://user-images.githubusercontent.com/78935215/118020786-ccd6f480-b35a-11eb-92c7-3ef646eebce5.gif)
