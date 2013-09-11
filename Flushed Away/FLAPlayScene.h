//
//  FLAMyScene.h
//  Flushed Away
//

//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class FLADrainNode;
@class FLABoatNode;
@class FLAToyNode;

@interface FLAPlayScene : SKScene

- (void)boat:(FLABoatNode *)boat sankDownDrain:(FLADrainNode *)drain;
- (void)toy:(FLAToyNode *)toy sankDownDrain:(FLADrainNode *)drain;



@end
