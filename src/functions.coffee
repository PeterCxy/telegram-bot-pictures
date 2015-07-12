exports.setup = (telegram, store) ->
	meizhi = require './meizhi'

	[
			cmd: "meizhi"
			num: 1
			opt: 1
			desc: "A random picture of girls ('meizhi' in Chinese). Available [source]: gank (gank.io), meizitu (meizitu.com)"
			act: meizhi.setup telegram, store
	]

