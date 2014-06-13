module.exports = (grunt) ->

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    meta:
      temp    : 'build',
      build   : 'app/assets',
      banner  : '/* <%= pkg.name %> v<%= pkg.version %> - <%= grunt.template.today("yyyy/m/d") %>\n' +
                '   <%= pkg.homepage %>\n' +
                '   Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author %>' +
                ' - Licensed <%= _.pluck(pkg.license, "type").join(", ") %> */\n'

    source:
      coffee: [
        'source/entities/*.coffee'
        'source/atoms/*.coffee'
        'source/molecules/*.coffee'
        'source/organisms/*.coffee'
        'source/*.coffee'
        'source/*.*.coffee']
      stylus: [
        'source/style/atom.*.styl'
        'source/style/molecule.*.styl'
        'source/style/organism.*.styl'
        'source/style/app.styl'
        'source/style/app.*.styl']
      scaffold: [
        'source/organisms/*.yaml']

    build:
      js: [
        'atoms.build/atoms.js'
        'atoms.build/extension.*.js']
      css: [
        'atoms.build/atoms.css'
        'atoms.build/extension.*.css']

    concat:
      app       : files: '<%= meta.temp %>/<%= pkg.name %>.coffee': '<%= source.coffee %>'
      build_css : files: '<%= meta.build %>/css/atoms.css'        : '<%= build.css %>'

    coffee:
      app: files: '<%= meta.temp %>/<%= pkg.name %>.js'           : '<%= meta.temp %>/<%= pkg.name %>.coffee'

    stylus:
      app:
        options: compress: true, import: [ '__init']
        files: '<%=meta.build%>/css/atoms.<%=pkg.name%>.css'      : '<%=source.stylus%>'

    uglify:
      options: banner: "<%= meta.banner %>"
      app:
        options: mangle: false
        files: '<%= meta.build %>/js/atoms.<%= pkg.name %>.js'    : '<%= meta.temp %>/<%= pkg.name %>.js'
      build_js:
        options: mangle: false
        files: '<%= meta.build %>/js/atoms.js'                    : '<%= build.js %>'

    yaml:
      scaffold:
        options:
          space: 2
        files: [
          expand  : true
          flatten : true
          src     : '<%= source.scaffold %>'
          dest    : '<%= meta.build %>/scaffold/'
        ]

    notify:
      coffee:
        options: title: 'atoms.<%= pkg.name %>.js', message: 'grunt:uglify:app'
      stylus:
        options: title: 'atoms.<%= pkg.name %>.css', message: 'grunt:stylus:app'

    watch:
      coffee:
        files: ['<%= source.coffee %>']
        tasks: ['concat:app', 'coffee:app', 'uglify:app', 'notify:coffee']
      stylus:
        files: ['<%= source.stylus %>']
        tasks: ['stylus:app', 'notify:stylus']
      scaffold:
        files: ['<%= source.scaffold %>']
        tasks: ['yaml:scaffold']

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-yaml'
  grunt.loadNpmTasks 'grunt-notify'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'default', ['concat:app', 'coffee:app', 'uglify:app', 'stylus:app', 'yaml:scaffold']
  grunt.registerTask 'build', ['uglify:build_js', 'concat:build_css']
