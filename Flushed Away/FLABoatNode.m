//
//  FLABoatNode.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLABoatNode.h"

@implementation FLABoatNode

- (instancetype)init
{
    self = [super initWithImageNamed:@"Spaceship"];
    if (self) {
        const CGFloat radius = 10;
        self.size = CGSizeMake(radius*2, radius*2);
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
        self.physicsBody.mass = 50;
    }
    return self;
}

@end
