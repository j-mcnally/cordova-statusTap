cordova-statusTap
=================

Capture tap events on the status bar.

This plugin is aimed at libraries like Sencha for users who want to execute custom code like scrolling their list views on status tap.

Installation
============

Plugman
-------

If you don't have [node.js](http://nodejs.org/) or [plugman](https://github.com/apache/cordova-plugman) yet, install them, then run

```
plugman --platform ios --project [TARGET-PATH] --plugin [PLUGIN-PATH]

where
  [TARGET-PATH] = path to folder containing your phonegap project
  [PLUGIN-PATH] = path to folder containing this plugin
```

For additional info, take a look at the [plugman documentation](https://github.com/apache/cordova-plugman/blob/master/README.md)

By Hand
-------

Add
```html
<script type="text/javascript" src="js/taptoscroll.js"></script>
```
to index.html

Add `taptoscroll.js` to your www folder

Also make sure to add the .h and .m files to your main project.

And add the following to your config.xml
```xml
<plugin name="TapToScroll" value="TapToScroll" />
```

Usage
=====

Add

```js
window.plugins.tapToScroll.initListener();
```

to onDeviceReady.

Then to add a listener for the tap implement

```js
window.addEventListener("statusTap", function() {
  alert("status tap");
});
```