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
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) SKLabelNode *timeLabelNode;

@property (nonatomic, assign) NSTimeInterval startTimeInterval;

@end

@implementation FLAPlayScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor blackColor];

        // Setting this anchor point makes it easier since all our calculations
        // will be around the center
        self.anchorPoint = CGPointMake (0.5, 0.5);

        self.physicsWorld.gravity = CGVectorMake(0, 0);
        self.physicsWorld.contactDelegate = self;

        [self resetScene];

        [self startSounds];
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    [self.world update:currentTime];
    
    if (!self.startTimeInterval) {
        self.startTimeInterval = currentTime;
    }
    
    NSTimeInterval newTime = currentTime - self.startTimeInterval;
    
    self.timeLabelNode.text = [NSString stringWithFormat:@"Time Elapsed: %0.1fs", newTime];
}

- (void)resetScene
{
    [self removeAllChildren];
    [self removeAllActions];

    self.world = [FLAWorldNode node];
    [self addChild:self.world];
    [self.world setup];

    self.timeLabelNode = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
    self.timeLabelNode.fontSize = 16;
    self.timeLabelNode.fontColor = [SKColor yellowColor];
    self.timeLabelNode.text = @"0.0";
    self.timeLabelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    self.timeLabelNode.position = CGPointMake(-220, 120);
    self.timeLabelNode.alpha = 1;
    [self addChild:self.timeLabelNode];
}

- (void)didMoveToView:(SKView *)view
{
    self.progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
    self.progressView.progress = 1.0;
    
    self.progressView.frame = CGRectMake(10, self.size.height - 20, 100, 10);
    [self.view addSubview:self.progressView];
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

- (void)boatHealthDidChange:(CGFloat)health
{
    self.progressView.progress = health / 100;
    
    if (self.progressView.progress <= 0) {
        [self endGame];
    }
}

- (void)endGame
{
    self.paused = YES;
    self.world.alpha = 0.5;
}


#pragma mark - Passing on touches to world

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.world touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.world touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.world touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.world touchesCancelled:touches withEvent:event];
}

@end
