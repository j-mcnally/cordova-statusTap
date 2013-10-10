//
//  TapToScroll.m
//  taptoscroll
//
//  Created by Justin McNally on 2/11/13.
//
//

#import "TapToScroll.h"

@interface RotationLessViewController : UIViewController

@end

@implementation RotationLessViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
  return NO;
}

-(BOOL)shouldAutorotate {
  return  NO;
}

@end


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
            [overlay setFrame:CGRectMake(0, 0, [UIApplication sharedApplication].statusBarFrame.size.width, [UIApplication sharedApplication].statusBarFrame.size.height)];
            

            overlay.windowLevel = UIWindowLevelStatusBar+1.f;
            [overlay setRootViewController:[[RotationLessViewController alloc] init]];
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
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationWillChange:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationDidChange:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}


-(void) orientationWillChange: (NSNotification *)notification {
  [[[overlay rootViewController] view]  setHidden:YES];
}


-(void) orientationDidChange: (NSNotification *)notification {
  [[[overlay rootViewController] view]  setHidden:NO];
  [self rotateToStatusBarFrame];

}

-(void) tapped:(UITapGestureRecognizer *)sender {
  [webView stringByEvaluatingJavaScriptFromString:@"var evt = document.createEvent(\"Event\"); evt.initEvent(\"statusTap\",true,true); window.dispatchEvent(evt);"];
}


- (void)rotateToStatusBarFrame {

  UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    
  CGFloat pi = (CGFloat)M_PI;
	if (orientation == UIDeviceOrientationPortrait) {
		overlay.transform = CGAffineTransformIdentity;
    overlay.frame = [UIApplication sharedApplication].statusBarFrame;
	}else if (orientation == UIDeviceOrientationLandscapeLeft) {
    overlay.transform = CGAffineTransformMakeRotation(pi * (90.f) / 180.0f);
    overlay.frame = [UIApplication sharedApplication].statusBarFrame;
  }else if (orientation == UIDeviceOrientationLandscapeRight) {
    overlay.transform = CGAffineTransformMakeRotation(-pi * (90.f) / 180.0f);
    overlay.frame = [UIApplication sharedApplication].statusBarFrame;
  }else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
    overlay.transform = CGAffineTransformMakeRotation(-pi);
    overlay.frame = [UIApplication sharedApplication].statusBarFrame;
  }
  overlay.windowLevel = UIWindowLevelStatusBar+1.f;
 
}


-(void) dealloc {
#if ! __has_feature(objc_arc)
  [super dealloc];
#endif
  NSLog(@"dealloc");
}

@end
