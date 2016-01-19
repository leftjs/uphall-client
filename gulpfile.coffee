# 引入package
fs = require('fs')
gulp = require('gulp')
runSequence = require('run-sequence')
del = require('del')
uglify = require('gulp-uglify')
concat = require('gulp-concat')
minifyCss = require('gulp-minify-css')
# unCss = require('gulp-uncss')
browserSync = require('browser-sync').create()

# 获取参数
assets = JSON.parse(fs.readFileSync('assets.json'))

# 构建任务部分
gulp.task('default',(callback) ->
  runSequence(['clean'], ['build'], ['serve', 'watch'], callback)
)

gulp.task('clean', (callback)->
  del(['./dist/'], callback)
)

gulp.task('build', (callback) ->
  runSequence(
    ['assetsJs', 'assetsCss', 'assetsFonts'],
    ['appJs', 'appCss', 'copyHtml', 'configJs'],
    callback
  )
)

# 资源文件处理
gulp.task('assetsJs', ->
  gulp.src(assets.assetsJs)
  .pipe(concat('assets.js', {newLine: ';\n'}))
  .pipe(gulp.dest('./dist/assets/js/'))
)

gulp.task('assetsCss', ->
  gulp.src(assets.assetsCss)
  .pipe(concat('assets.css', {newLine: '\n\n'}))
  .pipe(gulp.dest('./dist/assets/css/'))
)

gulp.task('assetsFonts', ->
  gulp.src(assets.assetsFonts)
  .pipe(gulp.dest('./dist/assets/fonts/'))
)

# app文件处理

gulp.task('copyHtml', ->
  gulp.src(['./src/**/*.html'])
  .pipe(gulp.dest('./dist/'))
)

gulp.task('appJs', ->
  gulp.src(assets.appJs)
  .pipe(concat('app.js', {newLine: ';\n'}))
  .pipe(gulp.dest('./dist/assets/js/'))
)

gulp.task('configJs', ->
  gulp.src(assets.configJs)
  .pipe(gulp.dest('./dist/assets/js/'))
)

gulp.task('appCss', ->
  gulp.src(assets.appCss)
  .pipe(concat('app.css', {newLine: '\n\n'}))
  .pipe(gulp.dest('./dist/assets/css/'))
)

gulp.task('serve', ->
  browserSync.init({
    server: {
      baseDir: './dist/'
    }
    port: 7411
  })
)

gulp.task('watch', ->
  gulp.watch('./src/**/*.*', ['reload'])
)

gulp.task('reload', (callback)->
  runSequence(['build'], ['reload-browser'], callback)
)

gulp.task('reload-browser', ->
  browserSync.reload()
)