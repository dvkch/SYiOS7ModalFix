//
//  ViewController.h
//  WindowsTest
//
//  Created by rominet on 03/12/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    Fix_None,
    Fix_KVO_New,
    Fix_KVO_Old,
    Fix_DidAppear,
    Fix_View_SubClass,
} Fix;

@interface ViewController : UIViewController

@property (nonatomic, assign) Fix fix;

- (id)initWithFix:(Fix)fix;

@end

