Colorful lines entwine and fade across the screen

[![Vine](Vine_screenshot.png)](Vine.fuse)

This shader consists of an image buffer that recursively processes the image. It is important that the color depth should be set to at least "float16", otherwise the thread will not deliver a good result due to the lack of resolution ("black" is not achieved).

Have fun playing