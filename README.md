Shadertoys
==========

DCTL Shader Fuses for use within DaVinci Resolve's Fusion page (aka DaFusion). These are based on WebGL shaders realeased on [Shadertoy.com](https://www.shadertoy.com/) with a license that allows for porting (see each fuse's source code for the respective license information).


Background
----------

This code is mainly based on the work of **Chris Ridings** and his *[Guide to Writing Fuses for Resolve/fusion](https://www.chrisridings.com/guide-to-writing-fuses-for-resolve-fusion-part-1/)* and the [FragmentShader.fuse](https://www.chrisridings.com/wp-content/uploads/2020/05/FragmentShader.fuse) from his *[Davinci Resolve Page Curl Transition](https://www.chrisridings.com/page-curl/)* article; **Bryan Ray**, who did a whole series of Blog posts on *[OpenCL Fuses](http://www.bryanray.name/wordpress/opencl-fuses-index/)*; **JiPi**, who did an excelent post on how to *[Convert a Shadertoy WebGL Code to DCTL](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=17&t=4460)* accompanied by a (German) [DCTL Tutorial](https://youtu.be/dbrPWRldmbs) Video and who last but not least was very patient in helping me and answering my questions. As an introduction and if you want to know more about shaders in general, I highly recommend to have a look at *[The Book of Shaders](https://thebookofshaders.com)*.


Usage
-----
Just copy the whole folder resp. clone the repository into your `Fusion/Fuses/` directory (macOS: `~/Library/Application Support/Blackmagic Design/DaVinci Resolve/`; Windows 10: `%APPDATA%\\Blackmagic Design\\DaVinci Resolve\\Support\\`) or pick and choose only the .fuse files you are interested in (which is very simple as there is only one file so far).

    ATTENTION: Does currently not work on systems
    using CUDA (Nvidia GPUs) as I myself can only
    test the code on OpenCL and Metal.


Fuses
-----

Okay, so far there's not much here, which of course seems a bit silly after that long and thorough introduction ... but hey: it's a start.

### CrossDistance.fuse

Based on '_[Cross - distance](https://www.shadertoy.com/view/XtGfzw)_' by [iq](https://www.shadertoy.com/user/iq) and ported by [nmbr73](https://www.youtube.com/c/nmbr73).

![screenshot](CrossDistance.png "CrossDistance.fuse in DaVinci Resolve")