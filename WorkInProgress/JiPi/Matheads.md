Matheads
==================

Based on '_[Matheads](https://www.shadertoy.com/view/tsSyWD)_' by [luk77](https://www.shadertoy.com/user/luk77) and porting by [JiPi](Profiles/JiPi.md).

Two funny striped figures dance and sing. A challenging shader and the difficulty was porting the animation. Obviously there are no "static" variables in WebGL, so the keyboard is queried here in BufferA, the corresponding commands are calculated from this and these are then packed into a picture. These are loaded at the beginning of the frame and then form the static variable. The commands are used in the image to implement the animation. So I first dealt with the WebGL keyboard query in detail, only to find out during porting that it obviously does not behave as described :-( Some adjustments were necessary before the two could dance across the screen. And it is not yet really perfect. The notorious artifacts when using global variables only seem to occur here in certain constellations.

[![Matheads](https://user-images.githubusercontent.com/78935215/114322433-88b8c000-9b20-11eb-8bdd-8187e565d6dc.gif)](https://www.shadertoy.com/view/tsSyWD)

