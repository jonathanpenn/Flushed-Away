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

@interface FLABoatNode ()
@end

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
        self.color = [SKColor redColor];
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

        self.colorBlendFactor = 1.0;
        double delayInSeconds = 0.3;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.colorBlendFactor = 0;
        });
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

    self.lastDraggedVector = CGVectorMake(- sinf(ang)*dt*20,
                                          cosf(ang)*dt*20);

    CGFloat distRemaining = hypotf(dx, dy);
    if (distRemaining < dt) {
        self.position = position;
    } else {
        self.position = CGPointMake(curPosition.x - sinf(ang)*dt,
                                    curPosition.y + cosf(ang)*dt);
    }
}

@end
