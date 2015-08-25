exports.name = 'pictures'
exports.desc = 'Just picture fetcher'

exports.setup = (telegram, store) ->
	meizhi = require './meizhi'
	yande = require './yande'

	[
			cmd: "meizhi"
			num: 1
			opt: 1
			desc: "A random picture of girls ('meizhi' in Chinese). Available [source]: gank (gank.io), meizitu (meizitu.com)"
			act: meizhi.setup telegram, store
		,
			cmd: "anime"
			num: 1
			opt: 1
			desc: "Search for anime pictures or get a random picture if the [query] is null."
			act: yande.setup telegram

	]
