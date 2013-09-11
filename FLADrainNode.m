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

        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
        self.physicsBody.mass = 100000;
        self.physicsBody.collisionBitMask = 0;
        self.physicsBody.contactTestBitMask = 0;
        self.physicsBody.resting = YES;
    }
    return self;
}

- (void)applyForceToNode:(SKNode *)node
{
    CGVector v = GravityVectorFromPointToPointWithMass(node.position,
                                                       self.position,
                                                       self.physicsBody.mass);
    [node.physicsBody applyForce:v];
}

@end
