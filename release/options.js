(function() {

  $(function() {
    var domain, _i, _len, _ref, _results;
    if (localStorage['enabled'] == null) return;
    _ref = JSON.parse(localStorage['enabled']);
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      domain = _ref[_i];
      _results.push((function(domain) {
        return $("<li><a href='http://" + domain + "/'>" + domain + "</a></li>").appendTo("ul.domains");
      })(domain));
    }
    return _results;
  });

}).call(this);
