if (!rails_ver) {
	var rails_ver = "unknown";
}

if (!module) {
	var module = "unknown";
}

var title = $("title").text();
var post_url = window.location;

$.ajax({
  dataType: 'jsonp',
  data: "title=" + title + "&permlink=" + post_url,
  url: 'http://localhost:3000/post_authorities/get_auth.json',
  success: function (data) {
	document.write("This post is: " + data.authority + ". <a href='http://railsbridge.org'>RailsBridge</a>");
  }
});
