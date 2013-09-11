//
//  FLADrainNode.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLADrainNode.h"

@implementation FLADrainNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        const CGFloat radius = 15;
        CGRect rect = CGRectMake(0-radius, 0-radius, radius*2, radius*2);
        self.path = [UIBezierPath bezierPathWithOvalInRect:rect].CGPath;
        self.fillColor = [SKColor whiteColor];
    }
    return self;
}

@end
