var RBAuthority = function(){
	var _P = {
		init : function( params ) {
			
			// load JQuery using Google AJAX libraries
			document.write("<script src='http://www.google.com/jsapi'></script>")
			
			// This $ hack is to bypass possible collision of the $ sign with other libs
			// since JQuery is loaded dynamically, noConflict() is futile.
			document.write("<script> if (typeof($) != 'undefined') {var oldLib = $; var change_back = true;} </script>");
			document.write("<script>google.load('jquery', '1.3.2');</script>");
			document.write("<script> if (typeof(change_back) != 'undefined') {$ = oldLib;} </script>");
		},
		loadCore : function() {
			
			if (typeof(debug) == "undefined" ) {
				var url = "http://railsbridge.org";
			} else {
				var url = "http://railsbridge.dev";
			}
			
			// load core functions after JQuery was loaded.
			document.write("<script src='" + url + "/javascripts/railsbridge-post-authority-core.js'></script>");
		}
	};
	return {
		init : function( params ) {
			_P.init( params );
			_P.loadCore();
		}
	};
}();


RBAuthority.init();
