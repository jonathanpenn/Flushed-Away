//
//  FLAWorldNode.h
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FLAWorldNode : SKNode

/// You must call this after you add the node to the scene
- (void)setup;

- (void)update:(NSTimeInterval)currentTime;

@end
