module.exports = function(grunt) {

  'use strict';

  // define tasks
  grunt.initConfig({

    clean: {
      build: [
        'dist'
      ],
      tmp: [
        'dist/styles.css'
      ],
    }, // end: clean


    jshint: {
      all: ['assets/js/app.js']
    }, // end: jshint


    compass: {
      dist: {
        options: {
          sassDir: 'assets/sass/',
          cssDir: 'assets/css/',
          javascriptsDir: 'assets/js/',
          fontsDir: 'assets/fonts/',
          environment: 'production',
          outputStyle: 'nested',
          noLineComments: true
        }
      }
    }, // end: compass


    concat: {
      js: {
        src: [
          'assets/js/*.js'
        ],
        dest: 'dist/app.js'
      },
      css: {
        src: [
          'assets/css/app.css',
          'assets/bower_components/font-awesome/font-awesome.css',
        ],
        dest: 'dist/styles.css'
      },
    }, // end: concat


    cssmin: {
      minify: {
        // cwd: 'assets/css/',
        src: 'dist/styles.css',
        dest: 'dist/app.css'
      }
    }, // end: cssmin


    uglify: {
      js: {
        options: {
          mangle: false,
          compress: true,
          preserveComments: false,
        },
        files: {
          'dist/app.js': 'dist/app.js'
        }
      }
    }, // end: uglify


    htmlmin: {
      post: {
        options: {
          removeComments: true,
          collapseWhitespace: true,
          collapseBooleanAttributes: true
          removeAttributeQuotes: true,
          removeRedundantAttributes: true,
          removeEmptyAttributes: true
        },
        files: {
          'dist/index.html': 'index.html',
        }
      }
    }, // end: cssmin

  });


  // load tasks
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-htmlmin');
  // grunt.loadNpmTasks('grunt-targethtml');
  // grunt.loadNpmTasks('grunt-contrib-watch');


  // register tasks
  grunt.registerTask('default', [
    'clean:build',
    'jshint',
    'compass',
    'concat',
    'cssmin',
    'uglify',
    // 'clean:tmp',
    // 'targethtml'
  ]);

};