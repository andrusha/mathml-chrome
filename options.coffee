$ ->
	return unless localStorage['enabled']?

	for domain in JSON.parse localStorage['enabled']
		do (domain) ->
			$("<li><a href='http://#{domain}/'>#{domain}</a></li>").appendTo("ul.domains")