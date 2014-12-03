//
//  AppDelegate.m
//  WindowsTest
//
//  Created by rominet on 03/12/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong) UIViewController *modal;
@end

@implementation AppDelegate

- (UIViewController *)testVC:(UIColor *)color;
{
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = color;
    
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor greenColor];
    v.frame = CGRectMake(100, 100, 200, 200);
    [vc.view addSubview:v];
    
    return vc;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect f = [[UIScreen mainScreen] bounds];
    f.origin.y      += 50;
    f.size.height   -= 50;
    
    self.window = [[UIWindow alloc] initWithFrame:f];
    [self.window.layer setMasksToBounds:NO];
    [self.window.layer setOpaque:NO];
    [self.window setRootViewController:[self testVC:[UIColor whiteColor]]];
    self.window.rootViewController.view.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    UIViewController *vc = [self testVC:[UIColor redColor]];
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:vc];
    nc.navigationBarHidden = YES;
    
    self.modal = nc;
    [self toyAround:NO];
    
    return YES;
}

- (void)toyAround:(BOOL)log
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.window.rootViewController presentViewController:self.modal animated:YES completion:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5. * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.window.rootViewController dismissViewControllerAnimated:YES completion:^{
                    [self toyAround:log];
                }];
            });
        }];
    });
}

@end
