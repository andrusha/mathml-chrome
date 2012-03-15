inject = ->
	return if MathJax?

	config = document.createElement 'script'
	config.setAttribute 'type', 'text/x-mathjax-config'
	config.innerHTML = """
			MathJax.Hub.Config({
			  tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']]}
			});
		"""

	cdn = document.createElement 'script'
	cdn.setAttribute 'type', 'text/javascript'
	cdn.setAttribute 'src', 'http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML'

	document.head.appendChild config
	document.head.appendChild cdn

inject()