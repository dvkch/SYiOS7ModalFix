//
//  ViewController.m
//  WindowsTest
//
//  Created by rominet on 03/12/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//

#import "ViewController.h"
#import "View.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithFix:(Fix)fix {
    self = [super init];
    if(self) {
        self.fix = fix;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    self.view = [View new];
    
    [(View *)self.view setOverrideFrame:(self.fix == Fix_View_SubClass)];
    
    UIView *v = [UIView new];
    v.backgroundColor = [UIColor greenColor];
    v.frame = CGRectMake(100, 100, 200, 200);
    [self.view addSubview:v];
    
    if(self.fix == Fix_KVO_New || self.fix == Fix_KVO_Old)
    {
        [self.view addObserver:self forKeyPath:@"frame" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld) context:NULL];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"frame"] && object == self.view) {
        NSValue *value = (self.fix == Fix_KVO_New ? change[@"new"] : change[@"old"]);
        CGRect frame = [value CGRectValue];
        
        if(frame.origin.y == 518)
        {
            frame.origin.y = 568;
            self.view.frame = frame;
        }
        if(frame.origin.y < 0)
        {
            frame.origin.y = 0;
            self.view.frame = frame;
        }
        return;
    }
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(self.fix == Fix_DidAppear)
    {
        self.view.frame = self.view.window.bounds;
    }
}

@end
