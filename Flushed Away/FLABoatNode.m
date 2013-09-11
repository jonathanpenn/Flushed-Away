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
    self = [super initWithImageNamed:@"boat"];
    if (self) {
        const CGFloat maxWidth = 12;
        self.size = CGSizeMake(maxWidth, maxWidth / self.texture.size.width * self.texture.size.height);
        self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.size];
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

        if (self.injured) return;

        CGFloat damage = kMinDamage + (node.physicsBody.mass/SpeedFromVector(node.physicsBody.velocity));
        self.health -= damage;
        
        [scene boat:self healthDidChange:self.health];
        self.injured = YES;

        self.colorBlendFactor = 1.0;
        double delayInSeconds = 1;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.colorBlendFactor = 0;
            self.injured = NO;
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

    self.lastDraggedVector = CGVectorMake(- sinf(ang)*dt*60,
                                          cosf(ang)*dt*60);

    self.zRotation = ang;
    self.physicsBody.angularVelocity = 0;

    CGFloat distRemaining = hypotf(dx, dy);
    if (distRemaining < dt) {
        self.position = position;
    } else {
        self.position = CGPointMake(curPosition.x - sinf(ang)*dt,
                                    curPosition.y + cosf(ang)*dt);
    }
}

@end
