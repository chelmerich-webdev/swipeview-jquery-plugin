module.exports = (grunt) ->
  grunt.initConfig(
    pkg: grunt.file.readJSON 'package.json'
    coffee:
      options:
        bare: true
      compile:
        expand: true
        flatten: true
        src: ['*.coffee'] 
        dest: ''
        ext: '.js'
    
    watch:
      scripts:
        files: '*.coffee'
        tasks: ['coffee']
        
    foo: 'bar'
  )
  # THis is a comments
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  
  grunt.registerTask 'default', ['coffee']
  
  return