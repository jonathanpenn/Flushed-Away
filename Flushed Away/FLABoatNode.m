//
//  FLABoatNode.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAPlayScene.h"
#import "FLABoatNode.h"
#import "FLADrainNode.h"
#import "FLAToyNode.h"

#define kStartHealth    100.0f
#define kMinDamage      10

@implementation FLABoatNode

- (instancetype)init
{
    self = [super initWithImageNamed:@"Spaceship"];
    if (self) {
        const CGFloat radius = 10;
        self.size = CGSizeMake(radius*2, radius*2);
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:radius];
        self.physicsBody.mass = 100;
        self.physicsBody.categoryBitMask = FLABodyCategoryBoat;
        self.physicsBody.contactTestBitMask = FLABodyCategoryDrain;
        self.physicsBody.collisionBitMask = FLABodyCategoryToy;
        self.physicsBody.linearDamping = 0.2;
        self.health = kStartHealth;
    }
    return self;
}

- (void)collidedWith:(SKNode *)node
{
    FLAPlayScene *scene = (id)self.scene;

    if ([node isKindOfClass:[FLADrainNode class]]) {
        [scene boat:self sankDownDrain:(FLADrainNode *)node];
    }
    else if ([node isKindOfClass:[FLAToyNode class]]){
        // We are colliding with another kind of object
        
        CGFloat damage = kMinDamage + (node.physicsBody.mass/SpeedFromVector(node.physicsBody.velocity));
        self.health -= damage;
        
        [scene boat:self healthDidChange:self.health];
    }
}

- (void)moveTowards:(CGPoint)position withTimeInterval:(NSTimeInterval)timeInterval
{
    self.physicsBody.velocity = CGVectorMake(0, 0);
    CGPoint curPosition = self.position;
    CGFloat dx = position.x - curPosition.x;
    CGFloat dy = position.y - curPosition.y;
    CGFloat dt = 150 * timeInterval;

    CGFloat ang = PolarAdjust(AngleBetweenPoints(position, curPosition));
    self.zRotation = ang;

    CGFloat distRemaining = hypotf(dx, dy);
    if (distRemaining < dt) {
        self.position = position;
    } else {
        self.position = CGPointMake(curPosition.x - sinf(ang)*dt,
                                    curPosition.y + cosf(ang)*dt);
    }
}

@end
