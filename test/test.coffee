coffee      = require 'coffee-script/register'
moment      = require 'moment'
mocha       = require 'mocha'
rimraf      = require 'rimraf'
sizeOf      = require 'image-size'
_           = require 'lodash'
should      = require('chai').should()
exists      = require('fs').existsSync
join        = require('path').join
each        = require('lodash').each

Metalsmith  = require 'metalsmith'
plugin      = require '..'

describe 'metalsmith-image-resize', () ->

   beforeEach (done) ->
      rimraf __dirname + '/build', done
   
   describe 'using default options', ()->
      
      it 'should resize jpg images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin()
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.jpg", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 1024
                  dimensions.height.should.equal 1024               
                  done()
   
      it 'should resize gif images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin()
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.gif", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 1024
                  dimensions.height.should.equal 853               
                  done()
   
      it 'should resize png images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin()
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.png", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 1024
                  dimensions.height.should.equal 1070               
                  done()
   
   describe 'when using width option', ()->
      
      it 'should resize jpg images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin
               width: 512
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.jpg", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 512
                  dimensions.height.should.equal 512               
                  done()
   
      it 'should resize gif images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin
               width: 512
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.gif", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 512
                  dimensions.height.should.equal 427               
                  done()
   
      it 'should resize png images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin
               width: 512
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.png", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 512
                  dimensions.height.should.equal 535               
                  done()

   describe 'when using height option', ()->
      
      it 'should resize jpg images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin
               height: 500
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.jpg", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 500
                  dimensions.height.should.equal 500               
                  done()
   
      it 'should resize gif images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin
               height: 500
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.gif", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 600
                  dimensions.height.should.equal 500               
                  done()
   
      it 'should resize png images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin
               height: 500
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.png", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 479
                  dimensions.height.should.equal 500               
                  done()

   describe 'when using exact width and height option', ()->
      
      it 'should resize jpg images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin
               width: 1000
               height: 500
               exact: true
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.jpg", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 1000
                  dimensions.height.should.equal 500               
                  done()
   
      it 'should resize gif images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin
               width: 1000
               height: 500
               exact: true
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.gif", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 1000
                  dimensions.height.should.equal 500               
                  done()
   
      it 'should resize png images', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin
               width: 1000
               height: 500
               exact: true
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.png", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 1000
                  dimensions.height.should.equal 500               
                  done()

   describe 'when filtering file types', ()->
      
      it 'should resize jpg images if included in pattern', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin
               width: 1000
               height: 500
               exact: true
               pattern: ['*.jpg']
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.jpg", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 1000
                  dimensions.height.should.equal 500               
                  done()
   
      it 'should not resize gif images if not included in pattern', (done)->
         
         Metalsmith(__dirname)
            .source('fixtures/src')
            .use plugin
               width: 1000
               height: 500
               exact: true
               pattern: ['*.jpg']
            .build (err, files) ->
               should.not.exist(err)
               sizeOf __dirname + "/build/earth.gif", (err, dimensions) ->
                  should.not.exist(err)
                  dimensions.width.should.equal 3600
                  dimensions.height.should.equal 3000               
                  done()

   afterEach (done) ->
      rimraf __dirname + '/build', done
   
