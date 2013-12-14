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
      all: ['src/assets/js/app.js']
    }, // end: jshint


    compass: {
      dist: {
        options: {
          sassDir: 'src/assets/sass/',
          cssDir: 'src/assets/css/',
          javascriptsDir: 'src/assets/js/',
          fontsDir: 'src/assets/fonts/',
          environment: 'production',
          outputStyle: 'nested',
          noLineComments: true
        }
      }
    }, // end: compass


    concat: {
      js: {
        src: [
          'src/assets/js/*.js'
        ],
        dest: 'dist/app.js'
      },
      css: {
        src: [
          'src/assets/css/app.css',
          'src/assets/bower_components/font-awesome/font-awesome.css',
        ],
        dest: 'dist/styles.css'
      },
    }, // end: concat


    cssmin: {
      minify: {
        // cwd: 'src/assets/css/',
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
          removeComments: false,
          collapseWhitespace: true,
          collapseBooleanAttributes: true,
          removeAttributeQuotes: true,
          removeRedundantAttributes: true,
          removeEmptyAttributes: true
        },
        files: {
          'dist/index.html': 'src/index.html',
        }
      }
    }, // end: cssmin


    copy: {
      main: {
        src: 'src/build',
        dest: 'dist/build',
      }
    }, // end: copy


    aws: grunt.file.readJSON('aws.json'),
    s3: {
      options: {
        accessKeyId: "<%= aws.accessKeyId %>",
        secretAccessKey: "<%= aws.secretAccessKey %>",
        bucket: 'io-structed-con'
      },
      publish: {
        cwd: 'dist/',
        src: '**'
      }
    } // end: s3

  });


  // load tasks
  grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-jshint');
  grunt.loadNpmTasks('grunt-contrib-compass');
  grunt.loadNpmTasks('grunt-contrib-concat');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-contrib-htmlmin');
  grunt.loadNpmTasks('grunt-contrib-copy');
  grunt.loadNpmTasks('grunt-aws');


  // register tasks
  grunt.registerTask('default', [
    'clean:build',
    'jshint',
    'compass',
    'concat',
    'cssmin',
    'uglify',
    'htmlmin',
    'copy',
    'clean:tmp',
    // 'targethtml'
  ]);

  grunt.registerTask('publish', [ 's3' ]);

};