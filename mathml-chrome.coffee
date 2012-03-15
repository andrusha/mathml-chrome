class Math
	constructor: ->
		@domains = new CachedStorage 'enabled'

	toggleIcon: (state, tab) ->
		if state
			chrome.browserAction.setIcon path: "icon_enabled.png", tabId: tab.id
			chrome.browserAction.setTitle title: "Disable Math on this domain", tabId: tab.id
		else
			chrome.browserAction.setIcon path: "icon.png", tabId: tab.id
			chrome.browserAction.setTitle title: "Enable Math on this domain", tabId: tab.id

	processTab: (tab) ->
		domain = getDomain(tab.url)
		if @domains.contains domain
			alert 'yay!'

	toggleTab: (tab) ->
		domain = getDomain(tab.url)
		if @domains.contains domain
			@domains.remove domain
			@toggleIcon()
		else
			@domains.addOnce domain
			@toggleIcon true
		chrome.tabs.reload tab.id

#

math = new Math

chrome.tabs.onUpdated.addListener (tabId, changeInfo, tab) ->
	math.processTab tab if changeInfo.status is 'complete'

chrome.browserAction.onClicked.addListener (tab) ->
	math.toggleTab tab