{exec} = require 'child_process'

task 'build', 'Build Bot', (options) ->
	exec 'coffee -o lib -c src', (err, stdout, stderr) =>
		throw err if err


