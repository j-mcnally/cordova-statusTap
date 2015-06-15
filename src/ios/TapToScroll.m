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
    [self.commandDelegate runInBackground:^{
        if (!initialized) {
            
            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
            [tapRecognizer setNumberOfTapsRequired:1];
            [tapRecognizer setNumberOfTouchesRequired:1];
            [self setRecognizer:tapRecognizer];

            [overlay setRootViewController:[[UIViewController alloc] init]];
            [overlay setBackgroundColor:[UIColor clearColor]];
            [overlay setHidden:NO];
            
            [[[overlay rootViewController] view] setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            [[[overlay rootViewController] view] setBackgroundColor:[UIColor clearColor]];

            [self rotateToStatusBarFrame];

            [[[overlay rootViewController] view] addGestureRecognizer:[self recognizer]];
            [self setupRotationListener];
            [overlay setClipsToBounds:YES];
        }
        initialized = YES;
    }];
}


-(void) setupRotationListener {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

-(void) orientationDidChange: (NSNotification *)notification {
  [self rotateToStatusBarFrame];
}

-(void) tapped:(UITapGestureRecognizer *)sender {
    NSLog(@"Status Bar Tapped Event");
  [webView stringByEvaluatingJavaScriptFromString:@"var evt = document.createEvent(\"Event\"); evt.initEvent(\"statusTap\",true,true); window.dispatchEvent(evt);"];
}


- (void)rotateToStatusBarFrame {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [overlay setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20.0)];
        [overlay setWindowLevel:(UIWindowLevelStatusBar+1.f)];
    });
}


-(void) dealloc {
#if ! __has_feature(objc_arc)
  [super dealloc];
#endif
  NSLog(@"dealloc");
}

@end
