// Toggle the RailsBridge Toolbar in an unobtrusive way
Event.observe(window, 'load', function() { init() });
function init(){
	$('menuTrigger').observe('click', function() {
		triggerEffect(this,'toolbarContainer','slide', 'images/rbnDownButton.png', 'images/rbnUpButton.png');
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