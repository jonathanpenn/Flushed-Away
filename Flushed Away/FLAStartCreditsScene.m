//
//  FLAStartCreditsScene.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAStartCreditsScene.h"

@implementation FLAStartCreditsScene

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [SKColor blackColor];
        self.anchorPoint = CGPointMake(0.5, 0.5);

        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Helvetica"];
        label.fontSize = 20;
        label.fontColor = [SKColor whiteColor];
        label.text = @"Credits";
        label.position = CGPointMake(0, 0);
        label.alpha = 1;
        [self addChild:label];
    }
    return self;
}

@end
