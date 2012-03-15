(function() {
  var CachedStorage, Math, getDomain, math,
    __indexOf = Array.prototype.indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  getDomain = function(url) {
    var full_domain;
    full_domain = url.match(/[a-z]+:\/\/([^\/]+)/i)[1];
    return full_domain.match(/((^[A-Fa-f\d\.:]+$)|(^[^\.]+$)|((?:(?:[^\.]+\.)?((?:[^\.\s]{2})(?:(?:\.[^\.\s][^\.\s])|(?:[^\.\s]+)))))$)/)[0];
  };

  CachedStorage = (function() {

    function CachedStorage(name, _default) {
      this.name = name;
      this["default"] = _default != null ? _default : [];
      if (localStorage[this.name]) {
        this.cache = JSON.parse(localStorage[this.name]);
      } else {
        this.cache = this["default"];
      }
    }

    CachedStorage.prototype.contains = function(elem) {
      return __indexOf.call(this.cache, elem) >= 0;
    };

    CachedStorage.prototype.add = function(elem) {
      this.cache.push(elem);
      return this._update();
    };

    CachedStorage.prototype.addOnce = function(elem) {
      if (!this.contains(elem)) return this.add(elem);
    };

    CachedStorage.prototype.remove = function(elem) {
      this.cache.splice(this.cache.indexOf(elem), 1);
      return this._update();
    };

    CachedStorage.prototype._update = function() {
      return localStorage[this.name] = JSON.stringify(this.cache);
    };

    return CachedStorage;

  })();

  Math = (function() {

    function Math() {
      this.domains = new CachedStorage('enabled');
    }

    Math.prototype.toggleIcon = function(tab) {
      var domain;
      domain = getDomain(tab.url);
      if (this.domains.contains(domain)) {
        chrome.browserAction.setIcon({
          path: "icon_enabled.png"
        });
        return chrome.browserAction.setTitle({
          title: "Disable MathML & LaTeX on " + domain
        });
      } else {
        chrome.browserAction.setIcon({
          path: "icon.png"
        });
        return chrome.browserAction.setTitle({
          title: "Enable MathML & LaTeX on " + domain
        });
      }
    };

    Math.prototype.processTab = function(tab) {
      var domain;
      domain = getDomain(tab.url);
      if (this.domains.contains(domain)) {
        return chrome.tabs.executeScript(tab.id, {
          file: 'inject.js'
        });
      }
    };

    Math.prototype.toggleTab = function(tab) {
      var domain;
      domain = getDomain(tab.url);
      if (this.domains.contains(domain)) {
        this.domains.remove(domain);
      } else {
        this.domains.addOnce(domain);
      }
      return chrome.tabs.reload(tab.id);
    };

    return Math;

  })();

  math = new Math;

  chrome.tabs.onUpdated.addListener(function(tabId, changeInfo, tab) {
    if (changeInfo.status === 'loading') {
      math.processTab(tab);
      return math.toggleIcon(tab);
    }
  });

  chrome.tabs.onActiveChanged.addListener(function(tabId, selectInfo) {
    return chrome.tabs.get(tabId, function(tab) {
      return math.toggleIcon(tab);
    });
  });

  chrome.browserAction.onClicked.addListener(function(tab) {
    return math.toggleTab(tab);
  });

}).call(this);
