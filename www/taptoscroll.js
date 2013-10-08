

var exec = require('cordova/exec');

var TapToScroll = function() {
	exec(null, null, "TapToScroll", "initListener",[]);  
}

module.exports = new TapToScroll();
