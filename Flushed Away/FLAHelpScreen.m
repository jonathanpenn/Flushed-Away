//
//  FLAHelpScreen.m
//  Flushed Away
//
//  Created by Michele Titolo on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAHelpScreen.h"
#import "FLAPlayScene.h"

@implementation FLAHelpScreen

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {

        
        self.backgroundColor = [SKColor blackColor];
        self.anchorPoint = CGPointMake(0.5, 0.5);
        
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        label.fontSize = 20;
        label.fontColor = [SKColor whiteColor];
        label.text = @"How To Play";
        label.position = CGPointMake(0, 20);
        label.alpha = 1;
        [self addChild:label];
        
        SKLabelNode *instructionLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        instructionLabel.fontSize = 18;
        instructionLabel.fontColor = [SKColor whiteColor];
        instructionLabel.text = @"Drag your finger on the screen to move the boat.";
        instructionLabel.position = CGPointMake(0, -15);
        instructionLabel.alpha = 1;
        [self addChild:instructionLabel];
        
        SKLabelNode *instructionLabel2 = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        instructionLabel2.fontSize = 18;
        instructionLabel2.fontColor = [SKColor whiteColor];
        instructionLabel2.text = @"Avoid collisions and falling down the drain.";
        instructionLabel2.position = CGPointMake(0, -34);
        instructionLabel2.alpha = 1;
        [self addChild:instructionLabel2];
        
        SKLabelNode *tapLabel = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        tapLabel.fontSize = 16;
        tapLabel.fontColor = [SKColor lightGrayColor];
        tapLabel.text = @"Tap anywhere to begin";
        tapLabel.position = CGPointMake(0, -67);
        tapLabel.alpha = 1;
        [self addChild:tapLabel];

    }
    return self;
}

- (void)play
{
    SKScene *scene = [FLAPlayScene sceneWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKTransition *transition = [SKTransition fadeWithColor:[SKColor whiteColor] duration:1];
    transition.pausesIncomingScene = YES;
    
    // Present the scene.
    [self.view presentScene:scene transition:transition];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self play];
}

@end
