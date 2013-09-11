//
//  FLAToyNode.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAToyNode.h"

@implementation FLAToyNode

- (instancetype)init
{
    self = [super initWithImageNamed:@"toy-duck"];
    if (self) {
        const CGFloat radius = 25;
        self.size = CGSizeMake(radius*2, radius*2);
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
    }
    return self;
}

@end
