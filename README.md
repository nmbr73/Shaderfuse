Shadertoys
==========
[![GitHub release](https://img.shields.io/github/v/release/nmbr73/Shadertoys?include_prereleases)](https://github.com/nmbr73/Shadertoys/releases/latest) [![License](https://img.shields.io/badge/license-various-critical)](LICENSE)

DCTL shader fuses for use within Fusion and/or DaVinci Resolve's Fusion page (aka "DaFusion"). These are based on WebGL shaders released on [Shadertoy.com](https://www.shadertoy.com/) with a license that allows for porting (see each Fuse's source code for the respective license information); please note that neither we are related to Shadertoy.com, nor is this an official Shadertoy.com repository; but we are obviously and definitely huge fans of this amazing website!

Furthermore must be mentioned that this repository is only an incubator to develop such fuses and to exchange on experiences, approaches and solutions. If you are searching for production ready extensions to really use for your day to day work, then the [Reactor](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=32&t=1814) is the right and de facto go to place for you. As soon as an implementation in this repo achieves an appropriate maturity we will suggest it for inclusion into the Reactor - thereby Reactor is the one and only source for the outcomes and stable versions of our experiments. You should find the stable Fuses in Reactor under the same name but without any of the annoying '`ST_`', '`BETA_`', whatsoever prefixes.

[![Shadertoyparade](img_subscribe.png)](https://youtu.be/oyndG0pLEQQ "WebGL to DCTL")



Background
----------

This code is mainly based on the work of **Chris Ridings** and his *[Guide to Writing Fuses for Resolve/fusion](https://www.chrisridings.com/guide-to-writing-fuses-for-resolve-fusion-part-1/)* and the [FragmentShader.fuse](https://www.chrisridings.com/wp-content/uploads/2020/05/FragmentShader.fuse) from his *[Davinci Resolve Page Curl Transition](https://www.chrisridings.com/page-curl/)* article; **Bryan Ray**, who did a whole series of blog posts on *[OpenCL Fuses](http://www.bryanray.name/wordpress/opencl-fuses-index/)*; **JiPi**, who did an excellent post on how to *[Convert a Shadertoy WebGL Code to DCTL](https://www.steakunderwater.com/wesuckless/viewtopic.php?f=17&t=4460)* accompanied by a (German) [DCTL Tutorial](https://youtu.be/dbrPWRldmbs) video. As an introduction and if you want to know more about shaders in general, a look into *[The Book of Shaders](https://thebookofshaders.com)* is highly recommended. Last but not least the [We Suck Less](https://www.steakunderwater.com/wesuckless/index.php) forum is again the place where you will find tons of information and all the experts.

See also the [Conversions](Conversions.md) (under construction) file for some more details on how to port GLSL to DCTL.


Installation
------------

### Repository
Just copy the whole folder resp. clone the repository into your `Fusion/Fuses/` directory, or pick and choose only the `.fuse` files you are interested in and copy them into the target folder. If you don't know how to clone a repository or if you don't know where to find the `Fusion/Fuses/` folder, don't bother - in this case it's just not the right kind of installation for you and we have other options to offer.

### ZIP-File

Find on [GitHub Pages](https://nmbr73.github.io/Shadertoys/) the Links to download the full `.tar.gz` or `.zip` archive. After unpacking you can again copy the whole folder into you `Fuses` directory or keep only single `.fuse` files.

### Fuse-Installers

You can drag'n'drop the `*-Installer.lua` files (which you find in the repo or the ZIP archive) into your Fusion working area to copy the corresponding fuse into the appropriate path.

### Installer

Alternatively you can also use the installer of the v0.1-alpha.1 release: drag'n'drop the `Shadertoys_Installer.lua` onto you Fusion working area, perform the installation and restart DaVinci Resolve.

Using Base64 in a HTML Image does work on GitHub Pages, but not on GitHub:<br />
<a href="https://github.com/nmbr73/Shadertoys/releases/download/v0.1-alpha.1/Shadertoys_Installer.lua" alt="Download Installer"><img src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMEAAAAqCAIAAACFo6iKAAABhGlDQ1BJQ0MgcHJvZmlsZQAAKJF9kT1Iw0AcxV9TxQ8qDlYQcchQO1kQFXHUKhShQqgVWnUwufQLmjQkKS6OgmvBwY/FqoOLs64OroIg+AHi5uak6CIl/i8ptIjx4Lgf7+497t4BQr3MNKtjHNB020wl4mImuyp2vSKIHoQxiKjMLGNOkpLwHV/3CPD1Lsaz/M/9OfrUnMWAgEg8ywzTJt4gnt60Dc77xGFWlFXic+Ixky5I/Mh1xeM3zgWXBZ4ZNtOpeeIwsVhoY6WNWdHUiKeII6qmU76Q8VjlvMVZK1dZ8578haGcvrLMdZojSGARS5AgQkEVJZRhI0arToqFFO3HffzDrl8il0KuEhg5FlCBBtn1g//B726t/OSElxSKA50vjvMxCnTtAo2a43wfO07jBAg+A1d6y1+pAzOfpNdaWuQI6N8GLq5bmrIHXO4AQ0+GbMquFKQp5PPA+xl9UxYYuAV617zemvs4fQDS1FXyBjg4BKIFyl73eXd3e2//nmn29wNP3XKZaMemlQAAAAlwSFlzAAALEwAACxMBAJqcGAAAAAd0SU1FB+UDCRQeNSko5ZsAAAAZdEVYdENvbW1lbnQAQ3JlYXRlZCB3aXRoIEdJTVBXgQ4XAAAPTklEQVR42u2ceXRUVZ7HP+/Vqy2VSipLpUKWgmwSAoYtIIgioODuae0+ntbRc8ZxoRFtuxWObeu4TSPqGWzHdnQaux2POme6j9ozdgtKi0AA2cMSw5KNkJCQpLKnUqn1vTd/8IpUhUSo0HgYu74nf3Duve8uv/d9v9/3d+8tBFVVASAQoqmb5l7cfgKyqihoFXHEAQIIAkZJSDSQY2N8GgZJq5IAVaXOxdsVfNRNn4pbPf1IHHGMAKtAssDtKTw8g4mZCAKCqqpVLTy4lV3BuH3iiAGz9LxzFVNzEfu9rNodJ1AcMWNvkBd20zuIeLCZdZ64QeIYCzZ6qWhC/Kb9tACKI46Y4VY52I7YHHdCcVwAmgYQ++NKKI4LQF8QKahccDcq88zMspKZiMWAotLvo2mA7W6OBuK7BN9z+BWkC6GQUeARB7cWMtFOmgW9OFTlDdExwP4WPq7nv3rjpv7eQjm9xzg2/NDK49OZkYMp3IdfxhdCgAQ9ZgmnDaeNhQXcXsfqKioCcYN/PzFGDq3M4okrcFgB+v0cbWdnMw19dATQCWQZKUxjXi75aSSbuGMKk+w8s4P/cccNHucQAL/I5ql5JJkIKexo5Hff8MHZ0aqd5GMsdXDfVCbaKXGw5hqUcj6N0yjOobttrJhDkonBIB8c4JkaOhWAdIFbUzHrEKDdz8d99Cm82srGTl6ayXWF5KWyai7Nm6k4v0zQJpCtHx56j4fwy9+m06+1MCMJi4Q7yJ4+tnmHqjJE7BJARwhXWAYKkCdhFlGgPkhAHZJ6eXp00CXjUcjRI4JX4XgoajiHSLqECqdC9CqkiGRJAF0ybfI5FjjbxJU2bHq8Mt+4WT/612UTyZIQRppAgsAEfZQ9VGgJ0Sd/d9lMbBxKEVlZRpqFgMy7FayowR+uKjLw7DwciQAVp/h4s7aG/UEe2sPvBK4tpMTBihLuOnReYz3k4JdXR90dUFVUlZP9lDewpoGm6Jf0DzaWT6XEgUmPKCAreIMcOMUbh/h0AODhLB65Ap3IF9XcVak9lafj44Xk2QjIPLuN33aEe0tm9SIMOnY28WE1ry7AoqfXx882a72dxuMTeGAGssKz2/kPF/dm8PxVCAJ/qGRZ9ahLW5LA46XMyiHBgE5EUfEHqelk7SHe6Rqh/b8Ucs9UgMYe7t7CkQgaLbHyznVIuuFWavfwdSOv13E4eIlxaKWTyQ6ATfW8WDtEIEAHJgmzBGDSRW9DKTxZwR9TKErnhoncfvy8hJFZR7J5hPJUC5MdXJnLsq/ZF9bpKzNZOQ+7BSCk4A6QZMBkZlEBxXZSt/Kf3eztwyBhNTLZQaZImwJQbKbEjlFChQWZrO3QWDvFTkYiQHM/Jh3JJhIN2Mz8tJTtu+gKuzGzhM2MrGLUaQtPSQCw6Ed35Mmsms+EFABZpd+PRU+SibIcCtNw7ORXzdF2EFicj80MkGhkSRpH2odqDSK2BCRxBCtNtHOlkxXb+fwibyOLMbW+pQi9jk4Pb1TSEcsJyYEAH1Til7GZ+HFBbFPc1MA/b+H5ct7YzfYGfCEkkZk5PDUFkwBQZmD5LOwWZJWtDfxkPfd8xqNfsK8ZFbKSeKKMQol1blwDAOOSmWQIx75M9DotqBVmhD8plVmZAINBKjqiYsJVeSwdN3ZzJwo8UaYRqLKVxzdwz2csXcdfa5BVbGaWz2KeKeqRB9JxpoS/eJFbR7He/lM8u4Xnyvn1TjbVMeBHFChx8OT0i+6HYuDQ7clMSAXY08SGwZhHeq2Fph6A6VmUxOL+Gnr4VSMvNPJYNUu2s3orvT4EgYUFzDejh0cvw2lDVdlcz/07+H036wd5u5P7t7GrEaDYwfIJAFXtAGlmiq2amJjpQAxzpDCVIj1AiYFcG0DPIOt6oiZj0HH/dK4wjNHcTzqZkglwqJVlW3nDxfpB3uvlwT38+QgqOBJZMTlK3SyZgFlPr48qF0DpOJaM5J473axq4sVGHq9l8Q6e2ozLDTAzh4fSLhkOLUjHYkCFDU2MYWfSo3KgBSDXRrEpxofDr9mr8mIzW+pRwWbitlwmSiwsQBAYCPB6JXURIqkyyIeHGQyiE7ipiDSRShdBBUFgjgMgW6QgHeBYB6pKgoEb0gFmWbAnAhx20RwhPlweFJW8FH42Cf2YzH1zEQYdIYX3Ktnhjwr3bx2haxBBYH4eJWGOzjFRlgPQ0MWGGmSFdAs3ZI9sIjEi+XjTxZ+OACQaWOTkot5JjYFDmUmIAn0+aseanx/rJqhglMhNvKBJr2siEEIQKEomz8w4q8aDTWcF/re66HRr+uAKM+tdeAMAk+3YBGZYcSQSUvhLDb1+DDrmZACUpJKgR1E51BaV3Ww8TkM3gsBNxfw4JeZp50lMsAGc7GNL9/DazV7qXQBmAwtsWuEPxmmybNMJ/tBCnw9gcR5O3XlogFZ6fQDjky4ZP5RoBHD76QoBmKBUYlr4zyYNWVsUmBJRNUmnDdPkJSQDpJouaNINgygqQJKZTLM2brdnKDOP3A9o8wAk6LHr2eWjsRdgnI2JepZkoRPxBVl/isZugKIMgNmZAP0+yjujOguGePcg/hBJRh6bTr4utmlPMKITAdw+Tp2V+cvQPKCJnqywfRbnIwp0etjYxj4/h9q0SS48D1q0BPAFARyWi5vnS7HGEzXsFyca+O08itK1cgGs4ZVPcbD1jqFUc2M9PzlEjzL0rPA3WtIYPPQxF5dn4rAw0cIkO6JAXTeHfRx1MS2L/BQWWDQN2+5m3Vke96UWFjeyoIBp2SyfcFFezZk+77FRaAeo6+Kgl/E6djdz1QSMOm7P5/2KS+VHEzH4IU9Ai68pOoBDAV7YQ88gKWZSzNjM6IQh4akVmqhs5blv6FEAsk1aFtrjv6BJ5yVoQtjtpc2rmTLVgkEYYX2ZFi3D6ggC7GrHLyOKzBtHkR0V6jroVClvRVEx6flRDo4kgANtI4/+ykE6PegE7i7VfPN5otGPrABYTWTpRviaT4f4oMIpH8D1TpKMAHmpfLmYzxZzx2Tthc3MZfa5dH22AZMeoN1zyeghlxtVxWaiwKKVfO7h0S3Ud43iJFS2NrB0N8fCsrQ4BYOOoEzzhZ143OLEIKGq1PbR4KXNDVBsZ5FleMuH00m3AvR42OMFWN+B148AiwuwmZAVvjqFClX9uDwYdCwuwKLHL3OwfeTRN3j4qIqQgsPKjZfF4FOPh7RImpvMgrNypYVm8jMAvAHKe5mk5yqn5mvtFkoyKLFTmKoNl23lesc5hluUhc0E0Nh/yfih7Z0MBhEFrnMOFX7u4aflI9BIVdnWwIO7qAkNjTQtC6C5j2rfGINWgsCzOVxTgAC9Pv58kuoQm4+jqiQa+XkphRHfd6meeydr6nh9rXYmUxOiugsgLwVJpNfLzm6AqgDNPQCXpWse7i9do87lpVqOuRDAYYktnK2vIyAjifzj5cyL8GFOHctKSEtAhW0NHA5wm50cG8C+Ztbu5p092t8nVQRkBIGbC8gQo6alRLzURzO4YxLAQIBNTZeMHvrvHp7rY6KdueNZcIQtYR6sH0Ao59+uoSAtgkAneGAXtRGJ8WOZ5KcBVLVRGcsGfF4Kz4xHEkkxMjODslyMEqrKpnrKvQThN9XMz2O8jYUFvKvj/cO4/GSbub+UGTmaBvr3E0N5b42L2TnaB13XpZ2Z9Knsb6MsV2tW08UR/6imb1b4zX5euw7LKAGlKJ23J0WrHIEvmnmpkRsLmJ7N1HG8NZ93D9HgIc3AXcVcW4gA7W7WHAG4MR9JJCDzp6O83DrUT5aOK51kJ1OSyZyEoXK7lafHI0KykWnpzMrV4mxFM2u7LqWzji9qKUxjnJVHSth/gP6we1g3gFDO69dQkBYm0M4oAhXquO9yTBIDAf5YG9sUF+WxKC+qJKRwoIXVVfhVgL0B3t7LinmkJ3B1HnPHMxjEoteSoNZ+XtsXNZnN7dwpa0SsaqcnvIqdbfyTgiSiQlXbOb7d9zu5oZYflIwcy+Y4meMcXtjr53/7ea2CVRacNkrHsSYTTwCzpO2V9/l4ax/bvNxsYXKmpus/6ojq5JTM3mayk7EY+FEen53UyqdnMT0rOiVVOebi5f2X2HnZaw1cX0hxBjcVs6KL5xuH/OdnAwhbWXM1re7hBEoWeHkqJZkAm+r45PzCszdEr3d4fFRVmsJnricj0uNXWmn9imWlTHJg0pOgJ6jg9nPwFG9UDj+e+7Kblj5SE5AVNpwaKq/yUNNJlhVPgC0RYsin0OclJOOJcJ8+WF3FZAcZFoIynhCAT6ZncFSFdDop+bCXzq/4+eWU5ZBgIEGPrNLvo7aTtZWs7QSYloIk0OtlWyP1weFsXtfIXCdGicJUlJP0Do5w5to2wNdN/LqWo6GLziHh/k/V38dyV3VpOq8uIslEv583d/N8I8EIzV9mxC1THTHvfB0vXc4dU9CL1Hdx31dsOz8xlCiQG32rQYHaILJy7rsfNj2dAfZF3/2IRIEeo4AKNQHkiKQ6T49JQIb6AGcWYQjfA+mRaY3e18mVsIqocDyIX9VuYoyGpiADEbY6fffDbqAvSNVA1N2PVJFMCQHaQkPnu5HffaEBEXwqTUGKDMOt1Bxi4Lu6+3FnYuwcAl7JZ/lsLAa8Ib6s5e0jfDEw8ozvS2XZVGbkoBNodfPLct7rJo7vE+5MHNM9xiePo6osLcNm5rZJzMllbwt7mjk6QFsAScBppMTGPCelmViNACd6WLUjTqBLAgtVgM3CORoMyUchqvDsB8d4n/oXDdT38+gMShxkJHLzRG68jH4/ARkBTHqshiFZs/MEqw+ycTD++v5/4AxLzvDmDO0WqixUh9No7L/reKeLv27ioVxuKcSZis2k7WidSQq6Bjnm4pNq3uxAjv8c+yL7ldHcxpl3Pxo/Rmw/7N+bv1VaSeIFzL5R5ukTPN3ID62UJjMuCasBRaXHR0sfe/r4Ku57vlvnMcxPRHqO0ag2rP1o1PyWTWpJunD1rvJJfzhjV8MZThx/H0JKLyJa9X/TcYQ4gb63dDk76gHJEmJWQtxicYwdORbEyXbVGvcccZzLLY0oj6wCpXbEmU5hvilupb9fWmw+Dw8SGcUi288xMnsCgqKoe09w7w5q5Lhh44gB+SIfzGVuPoKqqorKoZP8awUbB3DFN3LiOBcyBBZYWDmDGeMRT//fwqcrPH6q22jsVXu8gl/WLr3HEccZiAJGHTYTThvFmSSGJdD/AcnAv2JO4VH0AAAAAElFTkSuQmCC" /></a>

Using Base64 in a Markdown Image does work on GitHub Pages, but not on GitHub:<br />
![Download Image Test](data:image/png;base64,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)

Using the Image does work on GitHub, but not on GitHub Pages:<br />
[![Download](img_download.png)](https://github.com/nmbr73/Shadertoys/releases/download/v0.1-alpha.1/Shadertoys_Installer.lua)


Usage
-----
[![YouTube Demo](https://img.shields.io/youtube/views/oyndG0pLEQQ?style=social)](https://youtu.be/oyndG0pLEQQ)

In the Fusion page of DaVinci Resolve right click into the working area. In the context menu under 'Add tool' you'll find a 'Shadertoys/' submenu. That submenu corresponds to the repository's directory structure and provides access to all fuses installed.

Alternatively you can open the *'Select Tool'* dialog (Shift+Space Bar) and start typing "ST-" to filter for all our shadertoy fuses.


Connect
-------
[![Discord](https://img.shields.io/discord/793508729785155594?label=discord)](https://discord.gg/Zb48E4z3Pg)

... meet us on Discord

<!-- regrettably the iframe works on github pages bit not on github :-/ ...  iframe src="https://discord.com/widget?id=793508729785155594&theme=dark" width="350" height="500" allowtransparency="true" frameborder="0" sandbox="allow-popups allow-popups-to-escape-sandbox allow-same-origin allow-scripts"></iframe -->


Contribute
----------
[![GitHub Watchers](https://img.shields.io/github/watchers/nmbr73/Shadertoys?style=social)](https://github.com/nmbr73/Shadertoys) [![GitHub Stars](https://img.shields.io/github/stars/nmbr73/Shadertoys?style=social)](https://github.com/nmbr73/Shadertoys) [![GitHub Forks](https://img.shields.io/github/forks/nmbr73/Shadertoys?style=social)](https://github.com/nmbr73/Shadertoys)

...

Fuses
-----

Okay, so far there's not much here, which of course seems a bit silly after that long and thorough introduction ... but hey: it's a start.


- [Abstract Shaders](AbstractShader/)
  - [BumpyReflectingBalls](AbstractShader/BumpyReflectingBalls.md) ported by [JiPi](Profiles/JiPi.md)
  - [Crazyness](AbstractShader/Crazyness.md) ported by [nmbr73](Profiles/nmbr73.md)
  - [Cross Distance](AbstractShader/CrossDistance.md) ported by [nmbr73](Profiles/nmbr73.md)
  - [Favela](AbstractShader/Favela.md) ported by [nmbr73](Profiles/nmbr73.md)
  - [FlightThroughANebula](AbstractShader/FlightThroughANebula.md) ported by [JiPi](Profiles/JiPi.md) :new:
  - [Kali 3D](AbstractShader/Kali3D.md) ported by [JiPi](Profiles/JiPi.md)
  - [Noisecube](AbstractShader/Noisecube.md) ported by [JiPi](Profiles/JiPi.md)
  - [Rainbow Slices](AbstractShader/RainbowSlices.md) ported by [nmbr73](Profiles/nmbr73.md)
  - [Vine](AbstractShader/Vine.md) ported by [JiPi](Profiles/JiPi.md)
- Blob
  - [FunWithMetaballs](BlobShader/FunWithMetaballs.md) ported by [JiPi](Profiles/JiPi.md)
  - [TorturedBlob](BlobShader/TorturedBlob.md) ported by [JiPi](Profiles/JiPi.md)
- Distortion
  - [FbmWarp](DistortionShader/FbmWarp.md) ported by [JiPi](Profiles/JiPi.md) :new:
- Miscellaneous
  - [Fire_Water](MiscShader/Fire_Water.md) ported by [JiPi](Profiles/JiPi.md)
  - [FractalLand](MiscShader/FractalLand.md) ported by [nmbr73](Profiles/nmbr73.md)
  - [WildKifs4D](MiscShader/WildKifs4D.md) ported by [JiPi](Profiles/JiPi.md)
- Object
  - [Dancy Tree Doodle](ObjectShader/DancyTreeDoodle.md) ported by [JiPi](Profiles/JiPi.md)
  - [Dancy Tree Doodle 3D](ObjectShader/DancyTreeDoodle3D.md) ported by [JiPi](Profiles/JiPi.md)
  - [Lonely Voxel](ObjectShader/LonelyVoxel.md) ported by [JiPi](Profiles/JiPi.md)
  - [HW3Swing](ObjectShader/HW3Swing.md) ported by [JiPi](Profiles/JiPi.md)
- [Planet Shaders](PlanetShader/)
  - [Cracker Cars](PlanetShader/CrackerCars.md) ported by [JiPi](Profiles/JiPi.md)
  - [EARF](PlanetShader/EARF.md) ported by [JiPi](Profiles/JiPi.md)
  - [Fake3DScene](PlanetShader/Fake3DScene.md) ported by [JiPi](Profiles/JiPi.md)
  - [RayCastSphere](PlanetShader/RayCastSphere.md) ported by [JiPi](Profiles/JiPi.md)
- Recursiv
  - [Spilled](RecursivShader/Spilled.md) ported by [JiPi](Profiles/JiPi.md)
  - [TDSOTM_Nebula](RecursivShader/TDSOTM_Nebula.md) ported by [JiPi](Profiles/JiPi.md) :new:
- Tunnel
  - [Try Not To Hit The Walls](TunnelShader/TNTHTW.md) ported by [JiPi](Profiles/JiPi.md)
  - [Velocibox.fuse](TunnelShader/Velocibox.md) ported by [nmbr73](Profiles/nmbr73.md)

Work in Progress
----------------

- [Voxel Edges](AbstractShader/VoxelEdges.md) currently under construction by [nmbr73](Profiles/nmbr73.md)
- [FbmWarp](AbstractShader/FbmWarp.md) currently under construction by [JiPi](Profiles/JiPi.md)

Overview
========

[![AbstractShader/Crazyness.fuse](AbstractShader/Crazyness_320x180.png)](AbstractShader/Crazyness.md)
[![AbstractShader/CrossDistance.fuse](AbstractShader/CrossDistance_320x180.png)](AbstractShader/CrossDistance.md)
[![AbstractShader/Favela.fuse](AbstractShader/Favela_320x180.png)](AbstractShader/Favela.md)
[![AbstractShader/Kali3D.fuse](AbstractShader/Kali3D_320x180.png)](AbstractShader/Kali3D.md)
[![AbstractShader/Noisecube.fuse](AbstractShader/Noisecube_320x180.png)](AbstractShader/Noisecube.md)
[![AbstractShader/RainbowSlices.fuse](AbstractShader/RainbowSlices_320x180.png)](AbstractShader/RainbowSlices.md)
[![ObjectShader/DancyTreeDoodle.fuse](ObjectShader/DancyTreeDoodle_320x180.png)](ObjectShader/DancyTreeDoodle.md)
[![ObjectShader/DancyTreeDoodle3D.fuse](ObjectShader/DancyTreeDoodle3D_320x180.png)](ObjectShader/DancyTreeDoodle3D.md)
[![ObjectShader/LonelyVoxel.fuse](ObjectShader/LonelyVoxel_320x180.png)](ObjectShader/LonelyVoxel.md)
[![PlanetShader/CrackerCars.fuse](PlanetShader/CrackerCars_320x180.png)](PlanetShader/CrackerCars.md)
[![PlanetShader/Fake3DScene.fuse](PlanetShader/Fake3DScene_320x180.png)](PlanetShader/Fake3DScene.md)
[![BlobShader/TorturedBlob.fuse](BlobShader/TorturedBlob_320x180.png)](BlobShader/TorturedBlob.md)
[![PlanetShader/RayCastSphere.fuse](PlanetShader/RayCastSphere_320x180.png)](PlanetShader/RayCastSphere.md)
[![PlanetShader/EARF.fuse](PlanetShader/EARF_320x180.png)](PlanetShader/EARF.md)
[![TunnelShader/Velocibox.fuse](TunnelShader/Velocibox_320x180.png)](TunnelShader/Velocibox.md)
[![FunWithMetaballs](BlobShader/FunWithMetaballs_320x180.png)](BlobShader/FunWithMetaballs.md)
[![HW3Swing](ObjectShader/HW3Swing_320x180.png)](ObjectShader/HW3Swing.md)
[![Vine](AbstractShader/Vine_320x180.png)](AbstractShader/Vine.md)
[![BumpyReflectingBalls](AbstractShader/BumpyReflectingBalls_320x180.png)](AbstractShader/BumpyReflectingBalls.md)
[![Fire_Water](MiscShader/Fire_Water_320x180.png)](MiscShader/Fire_Water.md)
[![WildKifs4D](MiscShader/WildKifs4D_320x180.png)](MiscShader/WildKifs4D.md)
[![MiscShader/FractalLand.fuse](MiscShader/FractalLand_320x180.png)](MiscShader/FractalLand.md)
[![Spilled](RecursivShader/Spilled_320x180.png)](RecurssivShader/Spilled.md)
[![TDSOTM_Nebula](RecursivShader/TDSOTM_Nebula_320x180.png)](RecurssivShader/TDSOTM_Nebula.md)
[![FlightThroughANebula](AbstractShader/FlightThroughANebula_320x180.png)](AbstractShader/FlightThroughANebula.md)
[![FbmWarp](DistortionShader/FbmWarp_320x180.png)](DistortionShader/FbmWarp.md)


Work in Progress
----------------

### JiPi

Coming Soon

[![Working](Working/LiquidXstals_320x180.png)](https://www.shadertoy.com/view/ldG3WR)
[![Working](Working/Bonzomatic8_320x180.png)](https://www.shadertoy.com/view/tlsXWf)
[![TransparentDistortion](https://user-images.githubusercontent.com/78935215/109943088-19f07780-7cd5-11eb-8183-31ecafe9f446.gif)](https://www.shadertoy.com/view/ttBBRK)
[![DiffuisonGathering](https://user-images.githubusercontent.com/78935215/109943592-a56a0880-7cd5-11eb-97c0-a899d167d6e7.gif)](https://www.shadertoy.com/view/3sGXRy)


### nmbr73

[![AbstractShader/VoxelEdges.fuse](AbstractShader/VoxelEdges_320x180.png)](AbstractShader/VoxelEdges.md)
