//
//  FLAEndGameNode.m
//  Flushed Away
//
//  Created by Jonathan on 9/11/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAEndGameNode.h"

@implementation FLAEndGameNode

- (instancetype)init
{
    self = [super init];
    if (self) {
        SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Copperplate"];
        label.fontSize = 20;
        label.fontColor = [SKColor whiteColor];
        label.text = @"Game Over";
        label.position = CGPointMake(0, 0);
        label.alpha = 1;
        [self addChild:label];
    }
    return self;
}

@end
