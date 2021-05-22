InteractiveThinks
==================

Based on '_[Interactive Thinks](https://www.shadertoy.com/view/Xt3SR4)_' by [iapafoto](https://www.shadertoy.com/user/iapafoto) and ported by ported by [JiPi](../../Site/Profiles/JiPi.md).

This shader has parameter sliders in Shadertoy that can be operated with the mouse.
The conversion initially stubbornly resulted in a dark blue image. Only an intensive review of the code brought the problem to light. An uninitialized variable that "destroyed" the image during a calculation. In WebGL this was apparently initialized to zero, not so in DCTL. There the variable happened to have a higher value and so the screen stayed dark.
But even with the correct initialization, there are again fundamental differences between WebGL and DCTL.
One component is the provision of noise. A texture is used here, which is unfortunately not available in the original and so there are differences.
A noise function could then be used when converting to a fuse.
The setting parameters result in very interesting game options.

![InteractiveThinks2](https://user-images.githubusercontent.com/78935215/110646914-aad4c080-81b7-11eb-80eb-6562a27cf929.gif)
