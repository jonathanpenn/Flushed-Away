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
#import "FLASwirlNode.h"
#import <math.h>

@interface FLAWorldNode ()

@property (nonatomic, strong) FLABoatNode *boat;
@property (nonatomic, strong) FLADrainNode *drain;
@property (nonatomic, strong) FLASwirlNode *swirl1, *swirl2;

@property (nonatomic) NSTimeInterval lastTimeToySpawned;

@end

@implementation FLAWorldNode

- (void)setup
{
    CGFloat max = MAX(self.scene.size.width, self.scene.size.height);

    self.swirl1 = [FLASwirlNode node];
    self.swirl1.size = CGSizeMake(max, max);
    self.swirl1.alpha = 0.2;
    [self addChild:self.swirl1];
    SKAction *spin1 = [SKAction rotateByAngle:1 duration:5];
    [self.swirl1 runAction:[SKAction repeatActionForever:spin1]];

    self.swirl2 = [FLASwirlNode node];
    self.swirl2.size = CGSizeMake(max, max);
    self.swirl2.alpha = 0.1;
    self.swirl2.zRotation = 1;
    [self addChild:self.swirl2];
    SKAction *spin2 = [SKAction rotateByAngle:2 duration:5];
    [self.swirl2 runAction:[SKAction repeatActionForever:spin2]];

    self.drain = [FLADrainNode node];
    [self addChild:self.drain];

    self.boat = [FLABoatNode node];
    self.boat.position = CGPointMake(-50, 50);
    CGFloat radius = sqrt(pow(self.boat.position.x,2) + pow(self.boat.position.y, 2));
    self.boat.physicsBody.velocity = TangentVelocityVectorFromPosition(self.boat.position, (M_PI / 3), radius);

    [self addChild:self.boat];
}
- (void)update:(NSTimeInterval)currentTime
{
    if (self.boat.physicsBody.affectedByGravity) {
        [self.drain applyForceToNode:self.boat];
    }

    [self enumerateChildNodesWithName:@"toy" usingBlock:^(SKNode *toy, BOOL *stop) {
        if (toy.physicsBody.affectedByGravity) {
            [self.drain applyForceToNode:toy];
        }
    }];

    if (currentTime > self.lastTimeToySpawned + 3) {
        [self spawnToy];
        self.lastTimeToySpawned = currentTime;
    }
}

- (void)spawnToy
{
    FLAToyNode *toy = [FLAToyNode randomToyNode];
    const CGFloat radius = MAX(self.scene.size.width, self.scene.size.height)/2;
    const CGFloat angle = arc4random_uniform(2*M_PI * 100) / 100.f;
    toy.position = CGPointMake(radius * cos(angle), radius * sin(angle));
    toy.name = @"toy";
    toy.physicsBody.velocity = VectorFromSpeedAngleAndPosition(100, angle, toy.position);//TangentVelocityVectorFromPosition(toy.position, angle, radius);
//    NSLog(@"Toy %@", toy);
    [self addChild:toy];
}

@end
