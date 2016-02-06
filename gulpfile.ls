require! <[async fs glob gulp gulp-cached gulp-chmod gulp-concat gulp-filter
gulp-insert gulp-jade gulp-livereload gulp-livescript gulp-markdown gulp-print
gulp-remember gulp-replace gulp-rename gulp-stylus gulp-util main-bower-files sh streamqueue
tiny-lr gulp-plumber]>
spawn = require \child_process .spawn

port = parse-int fs.read-file-sync \port
tiny-lr-port = 35729
test-mode = true

paths =
  app: \app/
  bin: \bin/
  public: \public/
  input: \input/
  output: \output/
paths.html = paths.app+\/**/*.html
paths.jade = paths.app+\/**/*.jade
paths.css = paths.app+\/**/*.css
paths.styl = paths.app+\/**/*.styl
paths.js = paths.app+\/**/*.js
paths.ls = paths.app+\/**/*.ls
paths.res = paths.app+\/res/**
paths.php = paths.app+\/**/*.php
html-files = [paths.html]
jade-files = [paths.jade]
css-files = [paths.css]
styl-files = [paths.styl]
js-files = [paths.js]
ls-files = [paths.ls]

tiny-lr-server = tiny-lr!
livereload = -> gulp-livereload tiny-lr-server

gulp.task \res ->
  gulp.src paths.res
    .pipe gulp.dest paths.public+\/res
  gulp.src main-bower-files /.*\/images\/*/i
    .pipe gulp.dest paths.public+\res/images
  gulp.src \bower_components/semantic-ui/dist/themes/*
    .pipe gulp.dest paths.public+\/themes
  gulp.src \bower_components/semantic-ui/dist/themes/default/assets/fonts/*
    .pipe gulp.dest paths.public+\/fonts

gulp.task \bin ->
  gulp.src paths.bin+\build.ls
    .pipe gulp-plumber error-handler: on-error
    .pipe gulp-cached \bin
    .pipe gulp-livescript {+bare}
    .pipe gulp.dest paths.bin

gulp.task \css ->
  css-bower = gulp.src main-bower-files!
    .pipe gulp-print -> it
    .pipe gulp-plumber error-handler: on-error
    .pipe gulp-filter \*.css
    .pipe gulp-replace /(\.\.\/)?themes\/default\/assets/g \.
  styl-app = gulp.src paths.styl
    .pipe gulp-print -> it
    .pipe gulp-plumber error-handler: on-error
    .pipe gulp-cached \css
    .pipe gulp-stylus use: <[nib]>
    .pipe gulp-remember \css
  streamqueue {+object-mode}
    .done css-bower, styl-app
    .pipe gulp-concat \app.css
    .pipe gulp.dest paths.public
    .pipe livereload!

gulp.task \do ->
  gulp.src <[do.ls]>
    .pipe gulp-plumber error-handler: on-error
    .pipe gulp-cached \do
    .pipe gulp-livescript {+bare}
    .pipe gulp-insert.prepend "#!/usr/bin/node\n"
    .pipe gulp-rename extname: ''
    .pipe gulp-chmod 755
    .pipe gulp.dest paths.public

gulp.task \html ->
  jade = gulp.src paths.app+\/**/*.jade
    .pipe gulp-plumber error-handler: on-error
    .pipe gulp-cached \html
    .pipe gulp-jade {+pretty}
    .pipe gulp.dest paths.public
    .pipe livereload!
  gulp.src \README.md .pipe gulp-markdown!
    .pipe gulp.dest paths.public
    .pipe livereload!

gulp.task \js ->
  js-bower = gulp.src main-bower-files! .pipe gulp-filter \*.js
  ls-app = gulp.src paths.ls
    .pipe gulp-plumber error-handler: on-error
    .pipe gulp-cached \js
    .pipe gulp-livescript {+bare}
    .pipe gulp-remember \js
  streamqueue {+object-mode}
    .done js-bower, ls-app
    .pipe gulp-concat \app.js
    .pipe gulp.dest paths.public
    .pipe livereload!

gulp.task \server <[do]> ->
  Do = require "./#{paths.public}/do"
  require! \express
  express-server = express!
  express-server.use require(\connect-livereload)!
  express-server.get \/do (req, res) !-> Do req._parsedUrl.query, res
  express-server.use express.static paths.public
  express-server.listen port
  gulp-util.log "Listening on port: #port"

gulp.task \stat <[bin]> ->
  async.each-series glob.sync(paths.input+name)
  , (video, cb) !->
    spawn \node [paths.bin+\/build.js video] .stdout
    .on \data -> process.stdout.write it.to-string!
    .on \close -> cb!
  , -> process.stdout.write it if it

gulp.task \php ->
  gulp.src paths.app+\/**/*.php
    .pipe gulp.dest paths.public
    .pipe livereload!

gulp.task \watch <[build server]> ->
  tiny-lr-server.listen tiny-lr-port, -> return gulp-util.log it if it
  gulp.watch paths.bin+\build.js, <[bin]>
  gulp.watch paths.styl, <[css]>
  gulp.watch [paths.jade,\README.md] <[html]>
  gulp.watch paths.ls, <[js]>
  gulp.watch paths.php, <[php]>
  gulp.watch <[do.ls]>, <[do]>

gulp.task \build <[web]>
gulp.task \default <[watch]>
gulp.task \web <[bin css html js do php res]>

on-error = ->
  gulp-util.log(gulp-util.colors.red('Error'), it.message) if it
  this.emit \end
# vi:et:ft=ls:nowrap
