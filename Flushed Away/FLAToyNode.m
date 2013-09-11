//
//  FLAToyNode.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAToyNode.h"

@implementation FLAToyNode

+ (instancetype)toyNodeWithImageNamed:(NSString*)image
{
    FLAToyNode* node = [FLAToyNode spriteNodeWithImageNamed:image];
    node.size = node.texture.size;
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:node.texture.size.width];
    
    return node;
}

+ (instancetype)bearToyNode
{
    return [self toyNodeWithImageNamed:@"toy-bear"];
}

+ (instancetype)bikeToyNode
{
     return [self toyNodeWithImageNamed:@"toy-bike"];
}

+ (instancetype)carToyNode
{
     return [self toyNodeWithImageNamed:@"toy-car"];
}

+ (instancetype)duckToyNode
{
     return [self toyNodeWithImageNamed:@"toy-duck"];
}

+ (instancetype)horseToyNode
{
     return [self toyNodeWithImageNamed:@"toy-horse"];
}

+ (instancetype)planeToyNode
{
     return [self toyNodeWithImageNamed:@"toy-plane"];
}

+ (instancetype)scooterToyNode
{
     return [self toyNodeWithImageNamed:@"toy-scooter"];
}

+ (instancetype)soldierToyNode
{
     return [self toyNodeWithImageNamed:@"toy-soldier"];
}

@end
