exports.setup = (telegram, store) ->
	meizhi = require './meizhi'

	[
			cmd: "meizhi"
			args: "[source]"
			num: -1
			desc: "A random picture of girls ('meizhi' in Chinese). Available [source]: gank (gank.io), meizitu (meizitu.com)"
			act: meizhi.setup telegram, store
	]

