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

@property (nonatomic) BOOL touching;
@property (nonatomic) CGPoint touchPoint;

@end

@implementation FLAWorldNode

- (void)setup
{
    CGFloat max = MAX(self.scene.size.width, self.scene.size.height);

    self.swirl1 = [FLASwirlNode node];
    self.swirl1.size = CGSizeMake(max, max);
    self.swirl1.alpha = 0.2;
    [self addChild:self.swirl1];
    SKAction *spin1 = [SKAction rotateByAngle:-2 duration:5];
    [self.swirl1 runAction:[SKAction repeatActionForever:spin1]];

    self.swirl2 = [FLASwirlNode node];
    self.swirl2.size = CGSizeMake(max, max);
    self.swirl2.alpha = 0.1;
    self.swirl2.zRotation = 1;
    [self addChild:self.swirl2];
    SKAction *spin2 = [SKAction rotateByAngle:-3 duration:5];
    [self.swirl2 runAction:[SKAction repeatActionForever:spin2]];

    self.drain = [FLADrainNode node];
    self.drain.position = CGPointZero;
    [self addChild:self.drain];

    self.boat = [FLABoatNode node];
    CGPoint orbitingCenter = self.drain.position;
    CGPoint startPoint = CGPointMake(orbitingCenter.x, orbitingCenter.y + 100);
    self.boat.position = startPoint;
    CGFloat force = 100;
    CGVector vector = VectorFromSpeedAndAngle(force, Deg2Rad(90) + 0);
    self.boat.physicsBody.velocity = vector;

    [self addChild:self.boat];
}

- (void)update:(NSTimeInterval)currentTime
{
    if (self.paused) return;

    if (self.touching) {
        [self.boat moveTowards:self.touchPoint withTimeInterval:0.6];
    } else {
        if (self.boat.physicsBody.affectedByGravity) {
            [self.drain applyForceToNode:self.boat];
        }
    }

    [self enumerateChildNodesWithName:@"toy" usingBlock:^(SKNode *toy, BOOL *stop) {
        if (toy.physicsBody.affectedByGravity) {
            [self.drain applyForceToNode:toy];
        }
    }];

    if (currentTime > self.lastTimeToySpawned + 3) {
        if (self.lastTimeToySpawned != 0) {
            [self spawnToy];
        }
        self.lastTimeToySpawned = currentTime;
    }
}

- (void)spawnToy
{
    FLAToyNode *toy = [FLAToyNode randomToyNode];
    const CGFloat radius = MAX(self.scene.size.width, self.scene.size.height)/2;
    const CGFloat angle = arc4random_uniform(2*M_PI * 100) / 100.f;

    CGPoint orbitingCenter = self.drain.position;
    CGPoint startPoint = CGPointMake(orbitingCenter.x, orbitingCenter.y - radius);
    toy.position = RotatePointAroundPoint(startPoint, orbitingCenter, angle);
    CGFloat force = 150;
    CGVector vector = VectorFromSpeedAndAngle(force, Deg2Rad(90) + angle);
    toy.physicsBody.velocity = vector;
    toy.physicsBody.angularVelocity = arc4random_uniform(20) / 10.f;

    toy.name = @"toy";
    [self addChild:toy];
}


#pragma mark - Touch Handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touching = YES;
    self.touchPoint = [[touches anyObject] locationInNode:self];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touchPoint = [[touches anyObject] locationInNode:self];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touching = NO;
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.touching = NO;
}

@end
