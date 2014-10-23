gulp            = require 'gulp'
gutil           = require 'gulp-util'
watchify        = require 'watchify'
browserify      = require 'browserify'
coffeeify       = require 'coffeeify'
source          = require 'vinyl-source-stream'
del             = require 'del'
tiny_lr         = require 'tiny-lr'
express         = require 'express'
sass            = require 'gulp-sass'
uglify          = require 'gulp-uglify'
buffer          = require 'gulp-buffer'
sourcemaps      = require 'gulp-sourcemaps'
concat          = require 'gulp-concat'
autoprefixer    = require 'gulp-autoprefixer'

paths =
  sass: ['src/styles/**/*.sass']
  index_js: ['./src/initialize.coffee']
  build: ['./build/**/*']
  images: ['src/images']
  templates: ['./src/templates/**/*.html']
  vendorJS: ['./bower_components/**/*.min.js']
  vendorCSS: ['./bower_components/**/*.min.css', './bower_components/**/*-min.css']


## Tasks

gulp.task 'clean', ->
  del ['build'], {force: true}

gulp.task 'indexHtml', ->
  gulp.src(['index.html']).pipe(gulp.dest('./build'))

gulp.task 'templates', ->
  gulp
  .src(paths.templates, {base: "./src/templates"})
  .pipe(gulp.dest('./build/templates/'))

gulp.task 'vendorCSS', ->
  gulp.src(paths.vendorCSS)
  .pipe concat('vendor.css')
  .pipe gulp.dest('./build')

gulp.task 'vendorJS', ->
  gulp.src(paths.vendorJS)
  .pipe concat('vendor.js')
  .pipe gulp.dest('./build')

gulp.task 'jsWatch', ->
  bundler = watchify(browserify paths.index_js,
    cache: {}
    packageCache: {}
    fullPaths: true
    extensions: ['.coffee']
    debug: !gulp.env.production
  ).transform coffeeify

  rebundle = ->
    bundler
    .bundle()
    .pipe source('app.js')
    .pipe buffer()
    .pipe if gulp.env.production then sourcemaps.init(loadMaps: true) else gutil.noop()
    .pipe if gulp.env.production then uglify() else gutil.noop()
    .pipe if gulp.env.production then sourcemaps.write './' else gutil.noop()
    .pipe gulp.dest('./build')

  bundler.on 'update', rebundle
  bundler.on 'log', (msg) -> gutil.log(msg)

  rebundle()

gulp.task 'css', ->
  gulp.src(paths.sass)
  .pipe(sass
    errLogToConsole: true
    sourceComments : 'normal'
  )
  .pipe autoprefixer(
    browsers: ['last 2 versions']
    cascade: false
  )
  .pipe concat('app.css')
  .pipe if gulp.env.production then minifyCSS() else gutil.noop()
  .pipe gulp.dest('./build')

gulp.task 'watch', ->
  servers = createServers(8080, 35729)

  gulp.watch paths.vendorJS, (e) ->
    gutil.log(gutil.colors.cyan(e.path), 'changed')
    gulp.run 'vendorJS'

  gulp.watch paths.vendorCSS, (e) ->
    gutil.log(gutil.colors.cyan(e.path), 'changed')
    gulp.run 'vendorCSS'

  gulp.watch paths.templates, (e) ->
    gutil.log(gutil.colors.cyan(e.path), 'changed')
    gulp.run 'templates'

  gulp.watch 'index.html', (e) ->
    gutil.log(gutil.colors.cyan(e.path), 'changed')
    gulp.run 'indexHtml'

  gulp.watch paths.sass, (e) ->
    gutil.log(gutil.colors.cyan(e.path), 'changed')
    gulp.run 'css'

  gulp.watch paths.build, (e) ->
    gutil.log(gutil.colors.cyan(e.path), 'changed')
    servers.lr.changed
      body:
        files: [e.path]

gulp.task 'default', ['clean', 'indexHtml', 'templates', 'vendorJS', 'vendorCSS', 'jsWatch', 'css'], ->
  gulp.start 'watch'


## Helpers

createServers = (port, lrport) ->
  lr = tiny_lr()
  lr.listen lrport, -> gutil.log "LiveReload listening on", lrport
  app = express()
  app.use (req, res, next) -> redirectToIndex(req, next)
  app.use express.static("./build")
  app.listen port, -> gutil.log "HTTP server listening on", port

  lr: lr
  app: app

redirectToIndex = (req, next) ->
  pathSegments = req.url.split('/')
  firstLevelNest = pathSegments[1]
  file = pathSegments.slice(-1)[0]

  # For handling paths with query string params
  queryString = file.split("?")[1]
  if queryString
    file = file.split("?")[0]

  assets = [
    "app.js"
    "vendor.js"
    "vendor.css"
    "app.css"
  ]

  isNotTemplate = firstLevelNest != "templates"

  if isNotTemplate and file in assets
    req.url = "/#{file}"
  else if isNotTemplate
    req.url = "/"

  next()
