gulp = require 'gulp'
coffee = require 'gulp-coffee'
logger = require 'gulp-logger'
concat = require 'gulp-concat'
imagemin = require 'gulp-imagemin'
pug = require 'gulp-pug'

##
#  Complie coffeescript files
#  @param {String} none
#  @return {Stream} stream
##
gulp.task 'app_js', ->

    gulp.src('./assets/js/*.coffee')
    .on('error', (err) ->
        gutil.log gutil.colors.red(err.message)
        return
    ).pipe logger(
        before: 'Compling App Javascript'
        after: 'Finished!'
        showChange: true)
    .pipe coffee()
    .pipe gulp.dest('./docs/')
    return


##
#  Move images
#  @param {String} none
#  @return {Stream} stream
##
gulp.task 'app_images', ->

    gulp.src('./assets/images/**/*')
    .pipe imagemin()
    .pipe logger(
        before: 'Compressing Images'
        after: 'Finished!'
        showChange: true)
    .pipe gulp.dest('./docs/assets/img/')

    return


##
#  Move images
#  @param {String} none
#  @return {Stream} stream
##
gulp.task 'app_manifest', ->

    gulp.src('./assets/manifests/*')
    .pipe logger(
        before: 'Moving Manifests'
        after: 'Finished!'
        showChange: true)
    .pipe gulp.dest('./docs/')

    return


##
#  Compile pug to html
#  @param {String} none
#  @return {Stream} stream
##
gulp.task 'app_html', ->
    gulp.src('./assets/views/*.pug')
    .pipe(pug({}))
    .pipe(logger(
        before: 'Compling PUG to HTML'
        after: 'Finished!'
        showChange: true))
    .pipe(gulp.dest('./docs'))
    return

##
#  Default task
#  @param {String} none
#  @return {Boolean} Finished
##
gulp.task 'default', ['app_images', 'app_js','app_manifest','app_html']
