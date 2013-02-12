var TapToScroll = function() {
  
}

TapToScroll.prototype.initListener = function() {
  cordova.exec("TapToScroll.initListener");
};

if(!window.plugins) {
  window.plugins = {};
}
if(!window.plugins.tapToScroll) {
  window.plugins.tapToScroll = new TapToScroll();
}