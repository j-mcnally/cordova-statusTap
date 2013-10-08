

var exec = require('cordova/exec');

var TapToScroll = function() {
	exec(null, null, "TapToScroll", "initListener",[]);  
}

/*

TapToScroll.prototype.initListener = function() {
cordova.exec(null, null, "TapToScroll", "initListener",[]);
};

if(!window.plugins) {
  window.plugins = {};
}
if(!window.plugins.tapToScroll) {
  window.plugins.tapToScroll = new TapToScroll();
}



module.exports = new TapToScroll();
*/