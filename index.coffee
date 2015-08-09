###
 * Open Terminal Here - Atom package
 * https://github.com/blueimp/atom-open-terminal-here
 *
 * Copyright 2015, Sebastian Tschan
 * https://blueimp.net
 *
 * Licensed under the MIT license:
 * http://opensource.org/licenses/MIT
###

quotePath = (path) ->
  "'" + path.replace(/'/g, "'\\''") + "'"

switch require('os').platform()

  when 'darwin'
    defaultApp = 'Terminal.app'
    getCmd = (app, args, dirpath) ->
      "open -a #{quotePath app} #{args} #{quotePath dirpath}"

  when 'win32'
    defaultApp = 'cmd'
    quotePath = (path) ->
      '"' + path.replace(/"/g, '""') + '"'
    getCmd = (app, args, dirpath) ->
      "start /D #{quotePath dirpath} #{quotePath app} #{args}"

  else
    defaultApp = 'x-terminal-emulator'
    getCmd = (app, args, dirpath) ->
      "#{quotePath app} #{args} #{quotePath dirpath}"

module.exports =

  config: {
    app:
      type: 'string'
      default: defaultApp
    args:
      type: 'string'
      default: ''
  },

  activate: ->
    atom.commands.add '.tree-view .selected, atom-text-editor, atom-workspace',
      'open-terminal-here:open': (event) ->

        event.stopImmediatePropagation()

        filepath = @getPath?() || @getModel?().getPath?() ||
          atom.workspace.getActivePaneItem()?.buffer?.file?.path ||
          atom.project.getDirectories()[0]?.path

        return if not filepath

        if require('fs').lstatSync(filepath).isFile()
          dirpath = require('path').dirname(filepath)
        else
          dirpath = filepath

        app = atom.config.get 'open-terminal-here.app'
        args = atom.config.get 'open-terminal-here.args'

        require('child_process').exec getCmd(app, args, dirpath),
          cwd: dirpath
