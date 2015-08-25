# Yande.re
request = require 'request'
{korubaku} = require 'korubaku'

exports.setup = (telegram) ->
	(msg, query) ->
		korubaku (ko) =>
			yield telegram.sendChatAction msg.chat.id, 'upload_photo', ko.raw()
			opts =
				url: 'https://yande.re/post.json'
				formData:
					limit: 100

			if query? and (query.trim() isnt '')
				opts.formData.tags = query

			[err, _, body] = yield request.get opts, ko.raw()

			if !err? and body?
				results = JSON.parse body
				if results? and results.length? and results.length > 0
					index = Math.floor Math.random() * results.length
					url = results[index].file_url
					console.log url
					telegram.sendPhoto msg.chat.id, (request url)
