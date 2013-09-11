//
//  FLAStartCreditsScene.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAStartCreditsScene.h"
#import "FLABackStoryScene.h"
#import "FLASoundQueue.h"

@interface FLAStartCreditsScene ()
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation FLAStartCreditsScene

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [SKColor blackColor];
        self.anchorPoint = CGPointMake(0.5, 0.5);

        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
        label.fontSize = 23;
        label.fontColor = [SKColor whiteColor];
        label.text = @"Flushed Away";
        label.position = CGPointMake(0, 0);
        label.alpha = 1;
        [self addChild:label];

        self.timer = [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(goToNextScene) userInfo:nil repeats:NO];

        [[FLASoundQueue sharedSoundQueue] queueSoundFileNamed:@"intro_music" loop:NO];
        [[FLASoundQueue sharedSoundQueue] start];
    }
    return self;
}

- (void)goToNextScene
{
    [self.timer invalidate];
    self.timer = nil;

    SKScene *scene = [FLABackStoryScene sceneWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKTransition *transition = [SKTransition fadeWithDuration:1];
    
    // Present the scene.
    [self.view presentScene:scene transition:transition];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self goToNextScene];
}

@end
