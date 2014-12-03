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
    
    self.modal = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [self toyAround];
    
    return YES;
}

- (void)toyAround
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.window.rootViewController presentViewController:self.modal animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
                    NSLog(@"window y: %f", self.window.frame.origin.y);
                    NSLog(@"rootview y: %f", self.window.rootViewController.view.frame.origin.y);
                    
                    [self toyAround];
                }];
            });
        }];
    });
}

@end
