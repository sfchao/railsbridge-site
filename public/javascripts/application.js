$(document).ready(function(){
	initMenu();
	setupExternalLinks();
	setupPostsFilter();
});

function initMenu(){
	$('#menuTrigger').click(function() {
		triggerEffect(this,'toolbarContainer','slide', '/images/rbnDownButton.png', '/images/rbnUpButton.png');
	});
}

function setupExternalLinks(){
	
	$('a[rel="external"]').each(function(link) {
        if(link.attr('href') != '' & link.attr('href') != '#')
        {
            link.attr('target','_blank');
        }
    });
}

// Toggle the RailsBridge Toolbar in an unobtrusive way
// Event.observe(window, 'load', function() { 
// 	init() 
// 	$$('a[rel="external"]').each(function(link)
//     {
//         if(link.readAttribute('href') != '' & link.readAttribute('href') != '#')
//         {
//             link.writeAttribute('target','_blank');
//         }
//     });
// });

// function init(){
// 	$('menuTrigger').observe('click', function() {
// 		triggerEffect(this,'toolbarContainer','slide', '/images/rbnDownButton.png', '/images/rbnUpButton.png');
// 	});
// }

function triggerEffect(srcElement,divId, effect, firstImg, secondImg){
  
  $("#" + divId).slideToggle("normal", function(){
	image = srcElement.getElementsByTagName('img')[0];
	var new_image = $(image).attr("src").match(firstImg) ? secondImg : firstImg;
    $(image).attr("src", new_image); 
  });
  return false;
  // Effect.toggle(divId, effect, {
  //    beforeStart:function(){
  //      image = srcElement.getElementsByTagName('img')[0];
  //      image.src = image.src.match(firstImg) ? secondImg : firstImg;
  //    },
  // 	duration:0.2
  //  });
  //  return false;
}

// Modification from original http://twitter.com/javascripts/blogger.js
// Just a quick fix to clean up the code, make html validate, some ajax to add a loader in case Twitter is slow
// and then appear once it loads.
function twitterCallback2(twitters) {
  var statusHTML = [];
  for (var i=0; i<twitters.length; i++){
    var username = twitters[i].user.screen_name;
    var status = twitters[i].text.replace(/((https?|s?ftp|ssh)\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g, function(url) {
      return '<a href="'+url+'">'+url+'</a>';
    }).replace(/\B@([_a-z0-9]+)/ig, function(reply) {
      return  reply.charAt(0)+'<a href="http://twitter.com/'+reply.substring(1)+'">'+reply.substring(1)+'</a>';
    });
    statusHTML += '<li><span>'+status+'</span> <small><a href="http://twitter.com/'+username+'/statuses/'+twitters[i].id+'">'+relative_time(twitters[i].created_at)+'</a></small</li>';
  }
  $('twitterList').innerHTML = '<ul>' + statusHTML + '</ul>';
  $('twitterPreloader').hide();
  $('twitterList').blindDown({ duration: 2 });
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



function setupPostsFilter(){
	if ($("#status_token_select")) {
	//	alert('select');
	}
}