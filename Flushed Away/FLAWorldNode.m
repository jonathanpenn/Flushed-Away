//
//  FLAWorldNode.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAWorldNode.h"
#import "FLABoatNode.h"
#import "FLAToyNode.h"
#import "FLADrainNode.h"

@interface FLAWorldNode ()

@property (nonatomic, strong) FLABoatNode *boat;
@property (nonatomic, strong) FLAToyNode *duck;
@property (nonatomic, strong) FLADrainNode *drain;

@end

@implementation FLAWorldNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.drain = [FLADrainNode node];
        [self addChild:self.drain];

        self.boat = [FLABoatNode node];
        [self addChild:self.boat];
        self.boat.physicsBody.angularVelocity = 0.3;
        
        self.duck = [FLAToyNode node];
        [self addChild:self.duck];
        self.duck.physicsBody.angularVelocity = 0.5;
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
}

@end
