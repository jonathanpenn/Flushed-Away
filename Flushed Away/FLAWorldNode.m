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
@property (nonatomic, strong) FLADrainNode *drain;

@property (nonatomic, strong) NSMutableSet *toys;

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
        self.boat.position = CGPointMake(50, 80);
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    [self.drain applyForceToNode:self.boat];
}

@end
