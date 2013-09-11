//
//  FLAMyScene.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAPlayScene.h"
#import "FLAWorldNode.h"

@interface FLAPlayScene ()

@property (nonatomic, strong) FLAWorldNode *world;

@end

@implementation FLAPlayScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

        // Setting this anchor point makes it easier since all our calculations
        // will be around the center
        self.anchorPoint = CGPointMake (0.5,0.5);

        self.world = [FLAWorldNode node];
        [self addChild:self.world];

        self.physicsWorld.gravity = CGVectorMake(0, 0);
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{

}

@end
