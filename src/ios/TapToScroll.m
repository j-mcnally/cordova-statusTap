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
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    float screenWidth = [UIScreen mainScreen].bounds.size.width;
    float barHeight = [UIApplication sharedApplication].statusBarFrame.size.height;

    CGRect frame;
    
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIDeviceOrientationPortrait) {
        frame = CGRectMake(0, 0, screenWidth, barHeight);
    }
    else if (orientation == UIDeviceOrientationLandscapeLeft) {
        frame = CGRectMake(screenHeight - barHeight, 0, barHeight, screenWidth);
    }
    else if (orientation == UIDeviceOrientationLandscapeRight) {
        frame = CGRectMake(0, 0, barHeight, screenWidth);
    }
    else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        frame = CGRectMake(0, screenHeight - barHeight, screenWidth, barHeight);
    }
    
    [overlay setFrame:frame];
    [overlay setWindowLevel:(UIWindowLevelStatusBar+1.f)];
}


-(void) dealloc {
#if ! __has_feature(objc_arc)
  [super dealloc];
#endif
  NSLog(@"dealloc");
}

@end
