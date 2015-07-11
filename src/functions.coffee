exports.help = [
		cmd: "meizhi"
		args: "[source]"
		des: "A random picture of girls ('meizhi' in Chinese). Available [source]: gank (gank.io), meizitu (meizitu.com)"
]

meizhi = require './meizhi'

exports.setup = (telegram, server, store) ->
	# -1: unspecified number of parameters
	server.route 'meizhi', -1, meizhi.setup telegram, store

