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
    
#warning DEFINE FIX HERE
    Fix fix = Fix_View_SubClass;
    
    // KVO_New       : breaks animations
    // KVO_Old       : works but i don't have the slightest idea why
    // DidAppear     : works but the view bumps
    // View_SubClass : works nicely, i know why, but maybe be a bit harder to use as a solution if we use things like UITableViewController
    
    self.window = [[UIWindow alloc] initWithFrame:f];
    [self.window.layer setMasksToBounds:NO];
    [self.window.layer setOpaque:NO];
    [self.window setRootViewController:[[ViewController alloc] initWithFix:fix]];
    self.window.rootViewController.view.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    ViewController *vc = [[ViewController alloc] initWithFix:fix];
    vc.view.backgroundColor = [UIColor redColor];
    self.modal = vc;
    
    [self toyAround:NO];
    
    return YES;
}

- (void)toyAround:(BOOL)log
{
    if(log)
    {
        NSLog(@"window y: %f", self.window.frame.origin.y);
        NSLog(@"rootview y: %f", self.window.rootViewController.view.frame.origin.y);
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.window.rootViewController presentViewController:self.modal animated:YES completion:^{
            if(log)
            {
                NSLog(@"window y: %f", self.window.frame.origin.y);
                NSLog(@"rootview y: %f", self.window.rootViewController.view.frame.origin.y);
            }
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
                    [self toyAround:log];
                }];
            });
        }];
    });
}

@end
