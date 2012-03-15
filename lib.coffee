getDomain = (url) ->
	full_domain = url.match(/[a-z]+:\/\/([^\/]+)/i)[1]
	# credits goes to "southeringtonp"
	# http://splunk-base.splunk.com/answers/9736/revisiting-regex-to-extract-domain-name-from-an-fqdn
	full_domain.match(/((^[A-Fa-f\d\.:]+$)|(^[^\.]+$)|((?:(?:[^\.]+\.)?((?:[^\.\s]{2})(?:(?:\.[^\.\s][^\.\s])|(?:[^\.\s]+)))))$)/)[0]