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
@end

@implementation FLAStartCreditsScene

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [SKColor blackColor];
        self.anchorPoint = CGPointMake(0.5, 0.5);

        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
        label.fontSize = 30;
        label.fontColor = [SKColor whiteColor];
        label.text = @"Flushed Away";
        label.position = CGPointMake(0, 0);
        label.alpha = 1;
        [self addChild:label];

        SKLabelNode *byLine = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
        byLine.fontSize = 20;
        byLine.fontColor = [SKColor whiteColor];
        byLine.text = @"By Jonathan Penn and Michele Titolo";
        byLine.position = CGPointMake(0, -30);
        byLine.alpha = 0;
        [self addChild:byLine];

        [self runAction:[SKAction sequence:@[
                                             [SKAction waitForDuration:7.0],
                                             [SKAction runBlock:^{ [self goToNextScene]; }]
                                             ]]];
        [label runAction:[SKAction sequence:@[
                                             [SKAction waitForDuration:5.0],
                                             [SKAction fadeAlphaTo:0 duration:1],
                                             ]]];
        [byLine runAction:[SKAction sequence:@[
                                               [SKAction waitForDuration:2],
                                               [SKAction fadeAlphaTo:1 duration:2],
                                               [SKAction waitForDuration:1],
                                               [SKAction fadeAlphaTo:0 duration:1]
                                               ]]];
        [[FLASoundQueue sharedSoundQueue] queueSoundFileNamed:@"intro_music" loop:NO];
        [[FLASoundQueue sharedSoundQueue] start];
    }
    return self;
}

- (void)goToNextScene
{
    [self removeAllActions];

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
