class Math
	constructor: ->
		@domains = new CachedStorage 'enabled'

	toggleIcon: (tab) ->
		domain = getDomain(tab.url)
		if @domains.contains domain
			chrome.browserAction.setIcon path: "icon_enabled.png"
			chrome.browserAction.setTitle title: "Disable MathML & LaTeX on #{domain}"
		else
			chrome.browserAction.setIcon path: "icon.png"
			chrome.browserAction.setTitle title: "Enable MathML & LaTeX on #{domain}"

	processTab: (tab) ->
		domain = getDomain(tab.url)
		if @domains.contains domain
			alert 'yay!'

	toggleTab: (tab) ->
		domain = getDomain(tab.url)
		if @domains.contains domain
			@domains.remove domain
		else
			@domains.addOnce domain
		chrome.tabs.reload tab.id

#

math = new Math

chrome.tabs.onUpdated.addListener (tabId, changeInfo, tab) ->
	if changeInfo.status is 'loading'
		math.processTab tab
		math.toggleIcon tab

chrome.tabs.onActiveChanged.addListener (tabId, selectInfo) ->
	chrome.tabs.get tabId, (tab) ->
		math.toggleIcon tab

chrome.browserAction.onClicked.addListener (tab) ->
	math.toggleTab tab