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
        self.physicsBody.collisionBitMask = 0;
    }
    return self;
}

- (void)collidedWith:(SKNode *)node
{
    FLAPlayScene *scene = (id)self.scene;

    if ([node isKindOfClass:[FLADrainNode class]]) {
        [scene boat:self sankDownDrain:(FLADrainNode *)node];
    }
}

@end
