class CachedStorage
	constructor: (@name, @default = []) ->
		if localStorage[@name]
			@cache = JSON.parse localStorage[@name]
		else
			@cache = @default

	contains: (elem) ->
		elem in @cache

	add: (elem) ->
		@cache.push elem
		@_update()

	addOnce: (elem) ->
		@add elem unless @contains elem

	remove: (elem) ->
		@cache.splice @cache.indexOf(elem), 1
		@_update()

	_update: ->
		localStorage[@name] = JSON.stringify @cache