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

@property (nonatomic) NSTimeInterval lastTimeToySpawned;

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

    for (SKNode *toy in self.toys) {
        [self.drain applyForceToNode:toy];
    }

    if (currentTime > self.lastTimeToySpawned + 3) {
        [self spawnToy];
        self.lastTimeToySpawned = currentTime;
    }
}

- (void)spawnToy
{
    FLAToyNode *toy = [FLAToyNode node];

    [self addChild:toy];
    [self.toys addObject:toy];
}

@end
