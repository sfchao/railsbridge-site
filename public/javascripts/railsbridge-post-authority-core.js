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
  data: {'rails_ver': rails_ver, 'module' : module},
  jsonp: 'jsonp_callback',
  url: 'http://localhost:3000/javascripts/elad.json',
  success: function (data) {
    alert(data.authority)
  }
});
