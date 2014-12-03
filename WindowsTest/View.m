//
//  View.m
//  WindowsTest
//
//  Created by rominet on 03/12/14.
//  Copyright (c) 2014 Syan.me. All rights reserved.
//

#import "View.h"

@implementation View

- (void)setFrame:(CGRect)frame
{
    if(self.overrideFrame)
    {
        if(frame.origin.y == 518)
            frame.origin.y = 568;
        
        if(frame.origin.y < 0)
            frame.origin.y = 0;
    }
    
    [super setFrame:frame];
}

@end
