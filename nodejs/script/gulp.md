---
title: NodeJs script gulp
---

　　　** [i5ting_toc](https://github.com/i5ting/i5ting_ztree_toc)是nodejs的模块。主要帮助markdown文档生成目录结构。 **

```
	var gulp = require('gulp');
	var clean = require('gulp-clean');
	var minifyCss = require('gulp-minify-css');
	var minifyHtml = require('gulp-minify-html');
	var uglify = require('gulp-uglify');
	var shell = require('gulp-shell');
	var ts = require('gulp-typescript');
	gulp.task("clean",function() {
	    return gulp.src("./dst/*")
	    .pipe(clean());           //plugins为加载的gulp-load-plugins插件,它可以自动加载项目依赖(package.json定义)
	});
	gulp.task("css",function() {
	    return gulp.src(["public/**/*.css","!public/**/*.min.css"])
	    .pipe(minifyCss({compatibility: "ie8"}))
	    .pipe(gulp.dest("./dst/"));
	});
	gulp.task("js",function() {
	    return gulp.src(["public/**/*.js","!public/**/*.min.js"])
	   .pipe(ts({
	      target: "es5",
	      allowJs: true,
	      module: "commonjs",
	      moduleResolution: "node"
	    }))
	    .pipe(uglify())
	    .pipe(gulp.dest("./dst/"));
	});
	gulp.task("html",function() {
	    return gulp.src("public/**/*.html")
	    .pipe(minifyHtml())
	    .pipe(gulp.dest("./dst/"));
	});
	gulp.task("default",["css","js","html","mv"],function() {
	    console.log("gulp task finished!");
	});
	gulp.task("watch",function() {
	    gulp.watch("public/*",["default"]);
	});
	gulp.task("mv",function() {
	    return gulp.src("./dst/*")
	    .pipe(shell([
	        "cp -r ./dst/* ./public/"
	    ]));
	});

```