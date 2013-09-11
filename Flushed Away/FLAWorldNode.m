//
//  FLAWorldNode.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAWorldNode.h"
#import "FLABoatNode.h"

@interface FLAWorldNode ()

@property (nonatomic, strong) FLABoatNode *boat;

@end

@implementation FLAWorldNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.boat = [FLABoatNode node];
        [self addChild:self.boat];
        self.boat.physicsBody.angularVelocity = 0.3;
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
}

@end
