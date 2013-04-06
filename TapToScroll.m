//
//  TapToScroll.m
//  taptoscroll
//
//  Created by Justin McNally on 2/11/13.
//
//

#import "TapToScroll.h"


@implementation TapToScroll

@synthesize recognizer;


- (CDVPlugin*)initWithWebView:(UIWebView*)theWebView {
  self = [super initWithWebView:theWebView];
  if (self) {
    initialized = NO;
    overlay = [[UIWindow alloc] initWithFrame:[UIApplication sharedApplication].statusBarFrame];
    webView = theWebView;
  }
  return self;
}

-(void) initListener:(CDVInvokedUrlCommand*)command {
  if (!initialized) {
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    [tapRecognizer setNumberOfTouchesRequired:1];
    [self setRecognizer:tapRecognizer];
    [overlay setFrame:CGRectMake(0, 0, [UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height)];
    UIView *test = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height)];
    

    overlay.windowLevel = UIWindowLevelStatusBar+1.f;
    [overlay setRootViewController:[[UIViewController alloc] init]];
    [overlay setHidden:NO];
    [[[overlay rootViewController] view] setFrame:CGRectMake(0, 0, [UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height)];
    [[[overlay rootViewController] view] setBackgroundColor:[UIColor clearColor]];

    [[[overlay rootViewController] view] addGestureRecognizer:[self recognizer]];
  }
  initialized = YES;
}

-(void) tapped:(UITapGestureRecognizer *)sender {
  [webView stringByEvaluatingJavaScriptFromString:@"var evt = document.createEvent(\"Event\"); evt.initEvent(\"statusTap\",true,true); window.dispatchEvent(evt);"];
}


-(void) dealloc {
  [super dealloc];
  NSLog(@"dealloc");
}

@end
