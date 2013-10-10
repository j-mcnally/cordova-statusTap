function TapToScroll() {
};

TapToScroll.prototype.initListener = function() {

    function success(args) {
        // successCallback && successCallback(args);
    }

    function fail(args) {
        // failCallback && failCallback(args);
    }

	return cordova.exec(null, null, 'TapToScroll', 'initListener');
};

module.exports = new TapToScroll();
