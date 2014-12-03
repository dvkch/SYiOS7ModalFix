//
//  UIView+SYiOS7ModalFix.h
//  SYiOS7ModalFix
//
//  Created by rominet on 03/12/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SYiOS7ModalFix)

@property (nonatomic, assign) BOOL sy_isMainView;
+ (void)applyiOS7ModalFix_View;

@end
