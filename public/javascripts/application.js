$(document).ready(function(){
	initMenu();
	setupExternalLinks();
	setupPostsFilter();
	setupPostStatusChanger();
	setupDeletePosts();
});

$(document).ajaxSend(function(event, request, settings) {
  if (typeof(AUTH_TOKEN) == "undefined") return;
  // settings.data is a serialized string like "foo=bar&baz=boink" (or null)
  settings.data = settings.data || "";
  settings.data += (settings.data ? "&" : "") + "authenticity_token=" + encodeURIComponent(AUTH_TOKEN);
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
  $('#twitterList').html('<ul>' + statusHTML + '</ul>');
  $('#twitterPreloader').hide();
  $('#twitterList').slideDown({ duration: 2 });
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


function setupPostStatusChanger(){
	if ($("#change_post_authorities")) {
		var statusTokens = {"pending":0, "valid":1, "expired": 2}
		
		
		$("INPUT[@type=checkbox]").click(function(e){
			$(".select_all").removeClass("active_select");
			$("#change_post_authorities OPTION").removeAttr("disabled");
			$("#change_post_authorities OPTION[@value=-1]").attr("disabled", true);
			$("#change_post_authorities").val(-1);
		});
		
		$("#change_post_authorities").change(function(e){
			var selected_value = $(this).val();
			
			var post_ids = new Array;
			// get all marked checkboxes
			$("INPUT[@type=checkbox]:checked").each(function(){
				post_ids.push(this.id.split('_')[1]);
			});
			
			if(post_ids.length > 0) {
				$.ajax({
				  type: 'POST',
				  dataType: 'json',
				  data:{"new_status": selected_value, "posts": post_ids.join(',')},
				  url: '/post_authorities/bulk_process.json',
				  success: function (data) {
					$("INPUT[@type=checkbox]:checked").each(function(){
						var current_id = this.id.split('_')[1];
						var tr_parent = $("#post_" + current_id + "_row")
						
						tr_parent.removeClass("valid");
						tr_parent.removeClass("expired");
						tr_parent.removeClass("pending");
						
						$(this).removeClass("post_valid");
						$(this).removeClass("post_expired");
						$(this).removeClass("post_pending");
						
						tr_parent.addClass(data.new_status);
						$(this).addClass("post_" + data.new_status);
						
					});
					// Update the status TD
					for (index in post_ids) {
						$("#post_" + post_ids[index] + "_status").text(data.new_status_string);
					}
				  }
				});
			} else {
				// do something
			}
		});
	}
}

function setupDeletePosts(){
	if($('button#delete_selected_posts')) {
		$('button#delete_selected_posts').click(function(e){
			var post_ids = new Array;
			$("INPUT[@type=checkbox]:checked").each(function(){
				var current_id = this.id.split('_')[1];
				post_ids.push(current_id);
		//		
			});
			
			if(post_ids.length > 0) {
				$.ajax({
				  type: 'POST',
				  dataType: 'json',
				  data:{"posts": post_ids.join(',')},
				  url: '/post_authorities/bulk_destroy.json',
				  success: function (data) {
					$("INPUT[@type=checkbox]:checked").each(function(){
						var current_id = this.id.split('_')[1];
						$("#post_" + current_id + "_row").fadeOut();
						$("#post_" + current_id + "_row").remove();
						
					});
				  }
				});
			}
		});
	}
}
function setupPostsFilter(){
	if ($(".select_all")) {
		var statusTokens = {"pending":0, "valid":1, "expired": 2}
		$(".select_all").click(function(){
			
			var selected_token = this.id.split('_')[2]; //$("#status_token_select :selected").text();
			
			clearCheckBoxes();
			
			$("#change_post_authorities OPTION[@value=" + statusTokens[selected_token] +"]").attr("disabled", true);
			$("#change_post_authorities").val(statusTokens[selected_token]);
			$(this).addClass('active_select');
			$("INPUT[@type=checkbox].post_" + selected_token).each(function(){
				$(this).attr("checked",true);
			});
		});
	}
	
	if ($('#select_none')) {
		$("#select_none").click(function(){
			clearCheckBoxes();
		});
	}
}

function clearCheckBoxes(){
	$(".select_all").removeClass("active_select");
	$("INPUT[@type=checkbox]").each(function(){
		$(this).attr("checked", false);
	});
	$("#change_post_authorities OPTION").removeAttr("disabled");
	$("#change_post_authorities OPTION[@value=-1]").attr("disabled", true);
	$("#change_post_authorities").val(-1);
	return true;
}