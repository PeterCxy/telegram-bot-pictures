# Meizhi - Chinese of 'girls'
request = require 'request'

exports.setup = (telegram, store) ->

	unrecognized = (msg) ->
		console.log 'Nothing to do'
		# Should send back a message

	setLast = (id, value) ->
		store.put 'meizhi', id, value, (err) =>
			console.log 'stored' if !err

	getLast = (id, callback)  ->
		store.get 'meizhi', id, callback

	randomDate = (startYear, startMonth) ->
		date = new Date
		year = Math.floor(Math.random() * (date.getFullYear() - startYear + 1)) + startYear
		month = Math.floor(Math.random() * (date.getMonth() - startMonth + 2)) + startMonth
		day = Math.floor(Math.random() * (if month == date.getMonth() + 1 then date.getDay() else 31)) + 1
		[year, month, day]

	addZero = (num) ->
		if num < 10 then '0' + num else num

	gank = (msg) ->
		telegram.sendChatAction msg.chat.id, 'upload_photo'
		setLast msg.chat.id, 'gank'
		[year, month, day] = randomDate 2015, 5
		url = "http://gank.io/#{year}/#{addZero month}/#{addZero day}"
		console.log url
		request.get url, (error, response, body) =>
			if !error
				regex = ///
					<img[^>]+src="([^">]+)"
				///
				url = (body.match regex)[1]
				if url? and url.startsWith 'http'
					telegram.sendPhoto msg.chat.id, (request url)
				else
					telegram.sendMessage msg.chat.id, ':P'
				
	meizitu = (msg) ->
		telegram.sendChatAction msg.chat.id, 'upload_photo'
		setLast msg.chat.id, 'meizitu'
		[year, month, day] = randomDate 2014, 1
		url = "http://pic.meizitu.com/wp-content/uploads/#{year}a/#{addZero month}/#{addZero day}/#{addZero Math.floor(Math.random() * 8) + 1}.jpg"
		console.log url
		stream = request url
		telegram.sendPhoto msg.chat.id, stream if stream

	(msg, source) ->
		doHandle = (msg, src) =>
			handler = switch src
				when 'gank' then gank
				when 'meizitu' then meizitu
				else unrecognized

			handler msg
	
		if source?
			doHandle msg, source
		else
			getLast msg.chat.id, (err, data) =>
				console.log data
				if err or !data? or data.trim() == ''
					doHandle msg, 'gank'
				else
					doHandle msg, data
