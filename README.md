cordova-statusTap
=================

Capture tap events on the status bar.

This plugin is aimed at libraries like Sencha for users who want to execute custom code like scrolling their list views on status tap.

By j-mcnally and [triceam](https://github.com/triceam/cordova-statusTap)

Installation
============

To use this plugin, all you have to do is add this to your project use the PhoneGap CLI:

```
phonegap local plugin add https://github.com/j-mcnally/cordova-statusTap
```
The CLI tooling sets up all JS file references, and the plugin will initialize itself.  

Then to add a listener for the tap implement after PhoneGap/Cordova's onDeviceReady has been fired:

```
window.addEventListener("statusTap", function() {
  alert("status tap");
});
```

If you want to scroll a div based on this event, you can do something like the following (note, this is jQuery syntax):

```
window.addEventListener("statusTap", function() {
	var target = $("#scroller");
	
	//disable touch scroll
	target.css({
		'-webkit-overflow-scrolling' : 'auto',
		'overflow-y' : 'hidden'
	});
	
	//animate
	target.animate({ scrollTop: 0}, 300, "swing", function(){
		
		//re-enable touch scrolling
		target.css({
			'-webkit-overflow-scrolling' : 'touch',
			'overflow-y' : 'scroll'
		});
	});
});
```

This disables touch scrolling to kill an inertial scrolling in progress, animates it, then re-enables touch scrolling once the animation is complete.



That's it... very simple.


Details
============

Updated to Cordova 3.0 by triceam

Triceam's Changes include:

1. Updated for PhoneGap/Cordova CLI usage
2. Added auto-initialization - no need to manually initialize anymore
3. Updated ARC compatibility
