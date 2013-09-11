//
//  FLABackStoryScene.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLABackStoryScene.h"
#import "FLAPlayScene.h"

@implementation FLABackStoryScene

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [SKColor blackColor];
        self.anchorPoint = CGPointMake(0.5, 0.5);

        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        label.fontSize = 20;
        label.fontColor = [SKColor whiteColor];
        label.text = @"Backstory";
        label.position = CGPointMake(0, 0);
        label.alpha = 1;
        [self addChild:label];

        double delayInSeconds = 2.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            SKScene *scene = [FLAPlayScene sceneWithSize:self.view.bounds.size];
            scene.scaleMode = SKSceneScaleModeAspectFill;

            SKTransition *transition = [SKTransition fadeWithColor:[SKColor whiteColor] duration:2];

            // Present the scene.
            [self.view presentScene:scene transition:transition];
        });
    }
    return self;
}

@end