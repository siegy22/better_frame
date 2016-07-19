(function(){
  var baseURL = $("#app-content").data("baseurl");
  var railsURL = $("#app-content").data("railsurl");
  var railsPath = function() {
    var currentURL = window.location.toString();
    return currentURL.replace(baseURL, "");
  }
  var currentRailsPath = function() {
    return $("#rails-path").data("path");
  }

  function fill(url) {
    return $.ajax({url: url, type: "GET", xhrFields: { withCredentials: true }}).done(fillContent); }

  function fillContent(content) { $("#app-content").html(content); }

  function storeURLInHistory() {
    window.history.pushState(null, null, baseURL + currentRailsPath());
  }

  function handleLinks(event) {
    event.preventDefault();
    url_or_path = event.currentTarget.getAttribute("href");
    var expression = /(https?:\/\/(?:www\.|(?!www))[^\s\.]+\.[^\s]{2,}|www\.[^\s]+\.[^\s]{2,})/;
    var url_regex = new RegExp(expression);
    if (!url_or_path.match(url_regex)) {
      url_or_path = railsURL + url_or_path;
    }
    fill(url_or_path).then(storeURLInHistory);
  }

  $(document).on("click", "#app-content a:not([target=\"_blank\"])", handleLinks);

  $(document).on("ajax:success", "#app-content form", function(e, data, status, xhr) {
    fillContent(data);
    storeURLInHistory();
  });

  window.onpopstate = function(event) {
    var currentURL = document.location.toString();
    fill(currentURL.replace(baseURL, railsURL));
  };

  // inital loading
  $(function() {
    fill(railsURL + railsPath()).then(storeURLInHistory);
  });
})(jQuery);
