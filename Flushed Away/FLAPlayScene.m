//
//  FLAMyScene.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAPlayScene.h"
#import "FLAWorldNode.h"
#import "FLASoundQueue.h"

@interface FLAPlayScene ()
<SKPhysicsContactDelegate>

@property (nonatomic, strong) FLAWorldNode *world;
@property (nonatomic, strong) FLASoundQueue *soundQueue;

@end

@implementation FLAPlayScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        [self resetScene];

        [self startSounds];
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    [self.world update:currentTime];
}

- (void)resetScene
{
    [self removeAllChildren];
    [self removeAllActions];

    self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];

    // Setting this anchor point makes it easier since all our calculations
    // will be around the center
    self.anchorPoint = CGPointMake (0.5,0.5);

    self.world = [FLAWorldNode node];
    [self addChild:self.world];
    [self.world setup];

    self.physicsWorld.gravity = CGVectorMake(0, 0);
    self.physicsWorld.contactDelegate = self;
}


#pragma mark - Contact Handling

- (void)didBeginContact:(SKPhysicsContact *)contact
{
    NSAssert([contact.bodyA.node conformsToProtocol:@protocol(FLACollisionNode)], nil);
    NSAssert([contact.bodyB.node conformsToProtocol:@protocol(FLACollisionNode)], nil);
    [(SKNode<FLACollisionNode> *)contact.bodyA.node collidedWith:contact.bodyB.node];
    [(SKNode<FLACollisionNode> *)contact.bodyB.node collidedWith:contact.bodyA.node];
}

- (void)boat:(FLABoatNode *)boat sankDownDrain:(FLADrainNode *)drain
{
    [self sinkNode:(SKNode *)boat completion:^{
        [self resetScene];
    }];
}

- (void)toy:(FLAToyNode *)toy sankDownDrain:(FLADrainNode *)drain
{
    [self sinkNode:(SKNode *)toy completion:nil];
}

- (void)sinkNode:(SKNode *)node completion:(dispatch_block_t)completion
{
    node.physicsBody.linearDamping = 10;
    node.physicsBody.angularVelocity = 15;
    node.physicsBody.affectedByGravity = NO;
    SKAction *drown = [SKAction sequence:@[
                                           [SKAction scaleTo:0 duration:0.3],
                                           [SKAction runBlock:completion],
                                           [SKAction removeFromParent]
                                           ]];
    [node runAction:drown];
}

- (void)startSounds
{
    SKAction *flush = [SKAction playSoundFileNamed:@"toilet_flush_fx.aif" waitForCompletion:NO];
    [self runAction:flush];
    double delayInSeconds = 4.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        self.soundQueue = [[FLASoundQueue alloc] init];
        [self.soundQueue queueSoundFileNamed:@"action_a_music" loop:NO];
        [self.soundQueue queueSoundFileNamed:@"action_b_music_loop" loop:YES];
        [self.soundQueue start];
    });
}

@end
