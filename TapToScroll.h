//
//  TapToScroll.h
//  taptoscroll
//
//  Created by Justin McNally on 2/11/13.
//
//

#import <Cordova/CDV.h>
#import <Cordova/CDVPlugin.h>

@interface TapToScroll : CDVPlugin {
  BOOL initialized;
  UIWindow *overlay;
  UIWebView *webView;
}


@property (nonatomic, retain) UITapGestureRecognizer *recognizer;


-(void) initListener:(CDVInvokedUrlCommand*)command;


@end
