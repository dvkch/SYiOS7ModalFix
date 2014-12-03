//
//  UIViewController+SYiOS7ModalFix.m
//  SYiOS7ModalFix
//
//  Created by rominet on 03/12/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//

#import "UINavigationController+SYiOS7ModalFix.h"
#import "UIView+SYiOS7ModalFix.h"
#import <objc/runtime.h>

@implementation UINavigationController (SYiOS7ModalFix)

#pragma mark - Method Swizzling

+ (void)applyiOS7ModalFix_NavigationController
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(loadView);
        SEL swizzledSelector = @selector(fix_LoadView);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - iOS7 Modal Fix

- (void)fix_LoadView
{
    [self fix_LoadView];
    [self.view setSy_isMainView:YES];
}

@end
