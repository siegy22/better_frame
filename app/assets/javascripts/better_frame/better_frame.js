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
    return $.ajax({url: url, type: "GET", xhrFields: { withCredentials: true }})
            .done(fillContent)
            .then(fireLoadedEvent); }

  function fillContent(content) { $("#app-content").html(content); }

  function fireLoadedEvent() { $("#app-content").trigger("better_frame:load"); }

  function storeURLInHistory() {
    window.history.pushState(null, null, baseURL + currentRailsPath());
  }

  function handleLinks(event) {
    event.preventDefault();
    var url, url_or_path;
    url_or_path = String(event.currentTarget.getAttribute("href"));
    // if url_or_path starts with a slash assume it's a path
    if (url_or_path.match(/^\//)) {
      url = railsURL + url_or_path;
    } else {
      url = url_or_path;
    }
    fill(url).then(storeURLInHistory);
  }

  $(document).on("click", "#app-content a:not([target=\"_blank\"]):not([data-ignore-better-frame]):not([data-method])", handleLinks);

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
