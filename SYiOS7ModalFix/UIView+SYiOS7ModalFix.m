//
//  UIView+SYiOS7ModalFix.m
//  SYiOS7ModalFix
//
//  Created by rominet on 03/12/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//

#import "UIView+SYiOS7ModalFix.h"
#import <objc/runtime.h>

static char *kUIView_SYIsMainView = "kUIView_SYIsMainView";

@implementation UIView (SYiOS7ModalFix)

@dynamic sy_isMainView;

#pragma mark - Category Property

- (void)setSy_isMainView:(BOOL)sy_isMainView {
    objc_setAssociatedObject(self, kUIView_SYIsMainView, @(sy_isMainView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (BOOL)sy_isMainView {
    NSNumber *number = objc_getAssociatedObject(self, kUIView_SYIsMainView);
    return [number boolValue];
}

#pragma mark - Method Swizzling

+ (void)applyiOS7ModalFix_View
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(setFrame:);
        SEL swizzledSelector = @selector(fix_SetFrame:);
        
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

//UIApplicationDidChangeStatusBarFrameNotification

- (void)fix_SetFrame:(CGRect)frame
{
    if(self.sy_isMainView && [self runsOniOS7])
    {
        if(frame.origin.y < 0)
            frame.origin.y = 0;
        
        if(self.window)
        {
            CGFloat fixedHeight = self.window.frame.size.height;
            if(frame.size.height > fixedHeight)
                frame.size.height = fixedHeight;
        }
    }
    
    [self fix_SetFrame:frame];
}

- (BOOL)runsOniOS7
{
    return ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending &&
            [[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] == NSOrderedAscending);
}

@end
