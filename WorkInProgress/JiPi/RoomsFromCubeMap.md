RoomsFromCubeMap
==================

Based on '_[RoomsFromCubeMap](https://www.shadertoy.com/view/WsGcRm)_' by [kuvkar](https://www.shadertoy.com/user/kuvkar) and porting by [JiPi](Profiles/JiPi.md).

A look into the rooms of a high-rise building. There were two problems to be solved here. One problem relates to the use of CubMaps: In the original, the walls of the rooms are defined by CubMaps, which are not available in the DCTL. I've replaced the main wall of the rooms and the two side walls with the 2D texture here.
The other problem arose in the transfer of the textures over several functions. In the past I had a shader where the textures in a sub-function could no longer be used. At that time I put the shader aside. But here I investigated the mistake. There is obviously a problem if you pass the textures ( __TEXTURE2D__ ) as parameters across multiple functions. The cause is probably in the GPU. I've only covered the Cuda version here, too. A test with OpenCL would certainly be interesting here.

The shader has very interesting features. In addition to the textures for the rooms, I've expanded them from three to four, you can use a texture to create dirt on windows. A texture can be used to create a large reflection on the window front. It is possible to define rooms with balconies, blinds and flickering light. A great playground.


![RoomsFromCube](https://user-images.githubusercontent.com/78935215/117412288-e6b8a780-af14-11eb-81eb-67ebad77cff3.gif)
