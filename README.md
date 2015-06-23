metalsmith-image-resize
===============

A [Metalsmith](http://metalsmith.io) plugin that resizes images using [GraphicsMagick](http://www.graphicsmagick.org/)

Usage
-----

You must have [GraphicsMagick](http://www.graphicsmagick.org/) installed on your system for this plugin to work.

```javascript
var imageResize = require('metalsmith-image-resize');
Metalsmith.use(imageResize());
```

This will look for image files in your metalsmith files collection and resize them to have a maximum width of 1024 pixels.  By default, it will resize files with the extensions `png`, `jpg`, `jpeg`, `gif` and `svg`.

You can specify the maximum size of the image:

```javascript
var imageResize = require('metalsmith-image-resize');

Metalsmith.use(imageResize(
   { 
      width: 1024,
      height: 1024
   }
));
```

This will generate an image with a width no larger than 1024 pixels and a height no larger than 1024 pixels, maintaining the aspect ratio of the image.

If you want to force the image to be a specific size, stretching or squashing as necessary, you can add `exact: true` to the options.

If you want to resize files to an exact size, you can pass a width and height option.

```javascript
var imageResize = require('metalsmith-image-resize');

Metalsmith.use(imageResize(
   { 
      width: 200,
      height: 200,
      exact: true
   }
));
```

If you only want to resize certain files, you can specify a pattern.  This should be an array of file globs, and all files matching the patterns will be resized.

```javascript
var imageResize = require('metalsmith-image-resize');

Metalsmith.use(imageResize(
   { 
      pattern: ['photo-*.jpg', '**/*.png']
   }
));
```

Tests
-----
   
`$ npm test`
   
Licence
-------

GPLv2
