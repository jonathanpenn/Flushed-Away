//
//  FLAStartCreditsScene.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAStartCreditsScene.h"
#import "FLABackStoryScene.h"

@implementation FLAStartCreditsScene

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [SKColor blackColor];
        self.anchorPoint = CGPointMake(0.5, 0.5);

        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        label.fontSize = 20;
        label.fontColor = [SKColor whiteColor];
        label.text = @"Flushed Away";
        label.position = CGPointMake(0, 0);
        label.alpha = 1;
        [self addChild:label];
        
        [self performSelector:@selector(goToNextScene) withObject:self afterDelay:2.0];
    }
    return self;
}

- (void)goToNextScene
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(goToNextScene) object:self];
    SKScene *scene = [FLABackStoryScene sceneWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKTransition *transition = [SKTransition fadeWithColor:[SKColor whiteColor] duration:2];
    
    // Present the scene.
    [self.view presentScene:scene transition:transition];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self goToNextScene];
}

@end
