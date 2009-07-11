// Toggle the RailsBridge Toolbar in an unobtrusive way
Event.observe(window, 'load', function() { init() });
function init(){
	$('menuTrigger').observe('click', function() {
		triggerEffect(this,'toolbarContainer','slide', '/images/rbnDownButton.png', '/images/rbnUpButton.png');
	});
}
function triggerEffect(srcElement,divId, effect, firstImg, secondImg){
  Effect.toggle(divId, effect, {
    beforeStart:function(){
      image = srcElement.getElementsByTagName('img')[0];
      image.src = image.src.match(firstImg) ? secondImg : firstImg;
    },
	duration:0.2
  });
  return false;
}

function relative_time(time_value) {
    var values = time_value.split(" ");
    time_value = values[1] + " " + values[2] + ", " + values[5] + " " + values[3];
    var parsed_date = Date.parse(time_value);
    var relative_to = (arguments.length > 1) ? arguments[1] : new Date();
    var delta = parseInt((relative_to.getTime() - parsed_date) / 1000);
    delta = delta + (relative_to.getTimezoneOffset() * 60);

    if (delta < 60) {
        return 'less than a minute ago';
    } else if (delta < 120) {
        return 'about a minute ago';
    } else if (delta < (60 * 60)) {
        return (parseInt(delta / 60)).toString() + ' minutes ago';
    } else if (delta < (120 * 60)) {
        return 'about an hour ago';
    } else if (delta < (24 * 60 * 60)) {
        return 'about ' + (parseInt(delta / 3600)).toString() + ' hours ago';
    } else if (delta < (48 * 60 * 60)) {
        return '1 day ago';
    } else {
        return (parseInt(delta / 86400)).toString() + ' days ago';
    }
}

function twitterCallback2(twitters) {
    var statusHTML = "";
    for (var i = 0; i < twitters.length; i++) {
        statusHTML += '<li>' +
					  twitters[i].text + '&nbsp;<small>(' +
					  relative_time(twitters[i].created_at) +
					  ')</small></li>';
    }

    $('twitterList').innerHTML = '<ul>' + statusHTML + '</ul>';
    $('twitterPreloader').hide();
    $('twitterList').blindDown({ duration: 2 });
}