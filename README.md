cordova-statusTap
=================

Capture tap events on the status bar.

This plugin is aimed at libraries like Sencha for users who want to execute custom code like scrolling their list views on status tap.

Installation
============

Add
```
<script type="text/javascript" src="js/taptoscroll.js"></script>
```
to index.html

Add `taptoscroll.js` to your www folder

Add 

```
window.plugins.tapToScroll.initListener();
```

to onDeviceReady.


Then to add a listener for the tap implement

```
        window.addEventListener("statusTap", function() {
          alert("status tap");
        });
```

Also make sure to add the .h and .m files to your main project.

And add the following to your config.xml
`<plugin name="TapToScroll" value="TapToScroll" />`
