(function(){var e,c,d,g=Array.prototype.indexOf||function(b){for(var a=0,f=this.length;a<f;a++)if(a in this&&this[a]===b)return a;return-1};c=function(b){return b.match(/[a-z]+:\/\/([^\/]+)/i)[1].match(/((^[A-Fa-f\d\.:]+$)|(^[^\.]+$)|((?:(?:[^\.]+\.)?((?:[^\.\s]{2})(?:(?:\.[^\.\s][^\.\s])|(?:[^\.\s]+)))))$)/)[0]};e=function(){function b(a,b){this.name=a;this["default"]=b!=null?b:[];this.cache=localStorage[this.name]?JSON.parse(localStorage[this.name]):this["default"]}b.prototype.contains=function(a){return g.call(this.cache,
a)>=0};b.prototype.add=function(a){this.cache.push(a);return this._update()};b.prototype.addOnce=function(a){if(!this.contains(a))return this.add(a)};b.prototype.remove=function(a){this.cache.splice(this.cache.indexOf(a),1);return this._update()};b.prototype._update=function(){return localStorage[this.name]=JSON.stringify(this.cache)};return b}();d=new (function(){function b(){this.domains=new e("enabled")}b.prototype.toggleIcon=function(a){a=c(a.url);return this.domains.contains(a)?(chrome.browserAction.setIcon({path:"icon_enabled.png"}),
chrome.browserAction.setTitle({title:"Disable MathML & LaTeX on "+a})):(chrome.browserAction.setIcon({path:"icon.png"}),chrome.browserAction.setTitle({title:"Enable MathML & LaTeX on "+a}))};b.prototype.processTab=function(a){if(this.domains.contains(c(a.url)))return chrome.tabs.executeScript(a.id,{file:"inject.js"})};b.prototype.toggleTab=function(a){var b;b=c(a.url);this.domains.contains(b)?this.domains.remove(b):this.domains.addOnce(b);return chrome.tabs.reload(a.id)};return b}());chrome.tabs.onUpdated.addListener(function(b,
a,c){if(a.status==="loading")return d.processTab(c),d.toggleIcon(c)});chrome.tabs.onActiveChanged.addListener(function(b){return chrome.tabs.get(b,function(a){return d.toggleIcon(a)})});chrome.browserAction.onClicked.addListener(function(b){return d.toggleTab(b)})}).call(this);
