
<center>
[![InerciaIntended](https://user-images.githubusercontent.com/78935215/200139202-3c5b2c15-bd43-4998-84d6-a06820255d5d.gif)](Audio/Inerciaintended.md)
</center>

Shaders that use audio data (wave and frequency) over an image for display. Shadertoy provides an interface consisting of an image (512*2 pixels). One line contains 512 sampled waveform values ​​belonging to the current frame and the second line contains the FFT (Spectrum) values.
This interface can also be implemented in Resolve/Fusion. The [AudioWaveform.fuse](Fuses/AudioWaveform.md) generates the corresponding image from a loaded WAV file. The AudioWaveform has a second output for this. This Output is connected to an AudioShaderfuse-Input.

[![Download Installer](https://img.shields.io/static/v1?label=Download&message=AudioWaveform-Installer.lua&color=blue)](https://github.com/nmbr73/Shaderfuse/releases/download/V1.1/AudioWaveform-Installer.lua "Installer")
