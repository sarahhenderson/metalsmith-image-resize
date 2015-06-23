_        = require 'lodash'
gm       = require 'gm'
async    = require 'async'
multimatch = require('multimatch')

module.exports = (options) ->
   
   options ?= {}
   defaults = 
      pattern: ['**/*.png', '**/*.jpg', '**/*.jpeg', '**/*.gif', '**/*.svg']
      width: 1024
      height: null
      exact: false
   
   _.defaults options, defaults
   
   (files, metalsmith, next) ->
      
      filenames = _.keys(files)
      matched = multimatch(filenames, options.pattern)

      getSize = (file, image, meta, done) ->
         image.size (err, value) ->
            _.assign meta, value
            done(null, file, image, meta)

      getFormat = (file, image, meta, done) ->
         image.format (err, value) ->
            meta.format = value
         done(null, file, image, meta)

      calculateSize = (file, image, meta, done) ->
         meta.resizeNeeded = meta.width > options.width or meta.height > options.height
         meta.resizeNeeded = meta.resizeNeeded or meta.exact
         done(null, file, image, meta)

      resizeImage = (file, image, meta, done) ->
         if meta.resizeNeeded and options.exact
            image.resize(options.width, options.height, "!") 
         else
            image.resize(options.width, options.height) 
         done(null, file, image, meta)
         
      outputImage = (file, image, meta, done) ->
         done(null, file, image, meta) if not meta.resizeNeeded
         image.toBuffer meta.format, (err, buffer) ->
            done(err) if err?
            file.contents = buffer if not err?
            done(null, file, image, meta)

      resizeFile = (filename, done) ->
         file = files[filename]
         image = gm(file.contents, filename)
         meta = {}
         
         async.waterfall [
            (done) -> done(null, file, image, meta)
            getSize
            getFormat
            calculateSize
            resizeImage
            outputImage
         ], done

      async.each matched, resizeFile, next
