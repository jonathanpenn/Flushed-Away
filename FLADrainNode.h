//
//  FLADrainNode.h
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface FLADrainNode : SKShapeNode
<FLACollisionNode>

- (void)applyForceToNode:(SKNode *)node;

@end
