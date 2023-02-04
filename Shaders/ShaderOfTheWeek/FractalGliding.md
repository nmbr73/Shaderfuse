One of the most complex conversions I've done, there was again a lot to learn.
There are 9 float, 6 double float, 4 tripple float, one boolean and one integer, which were originally implemented as global variables. In the first attempt I tried the possibility of global variables in Cuda, unfortunately this led to picture interference (a known problem). So these variables were looped once across the entire program, sometimes as pointers. However, this led to the execution time increasing dramatically. You need a bit of patience, but then you get a great fractal film that is 133 seconds long, divided into an intro and seven scenes.

Have fun playing

![FractalGliding](https://user-images.githubusercontent.com/78935215/144676583-8f728705-53d6-4c52-8302-a9e9a88c780b.gif)


[![FractalGliding](FractalGliding_screenshot.png)](FractalGliding.fuse)