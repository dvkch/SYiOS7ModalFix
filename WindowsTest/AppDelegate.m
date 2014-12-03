//
//  AppDelegate.m
//  WindowsTest
//
//  Created by rominet on 03/12/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) UIViewController *modal;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect f = [[UIScreen mainScreen] bounds];
    f.origin.y      += 50;
    f.size.height   -= 50;
    
    self.window = [[UIWindow alloc] initWithFrame:f];
    //    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window.layer setMasksToBounds:NO];
    [self.window.layer setOpaque:NO];
    [self.window setRootViewController:[ViewController new]];
    self.window.rootViewController.view.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor redColor];
    
    self.modal = vc;
    
    [self toyAround];
    
    return YES;
}

- (void)toyAround
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.window.rootViewController presentViewController:self.modal animated:YES completion:^{
            CGRect f = self.modal.view.frame;
            f.origin.y = 0;
            self.modal.view.frame = f;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
                    CGRect f = self.window.rootViewController.view.frame;
                    f.origin.y = 0;
                    self.window.rootViewController.view.frame = f;
                    
                    NSLog(@"window y: %f", self.window.frame.origin.y);
                    NSLog(@"rootview y: %f", self.window.rootViewController.view.frame.origin.y);
                    
                    [self toyAround];
                }];
            });
        }];
    });
}

@end
