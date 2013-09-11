//
//  FLAToyNode.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAToyNode.h"

@implementation FLAToyNode

+ (instancetype)toyNodeWithImageNamed:(NSString*)image mass:(CGFloat)mass
{
    FLAToyNode* node = [FLAToyNode spriteNodeWithImageNamed:image];
    node.size = CGSizeMake(node.texture.size.width/2, node.texture.size.height/2);
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:MAX(node.size.height, node.size.width)/2];
    node.physicsBody.mass = mass;
    
    return node;
}

+ (instancetype)bearToyNode
{
    return [self toyNodeWithImageNamed:@"toy-bear" mass:65];
}

+ (instancetype)bikeToyNode
{
     return [self toyNodeWithImageNamed:@"toy-bike" mass:89];
}

+ (instancetype)carToyNode
{
     return [self toyNodeWithImageNamed:@"toy-car" mass:95];
}

+ (instancetype)duckToyNode
{
     return [self toyNodeWithImageNamed:@"toy-duck" mass:50];
}

+ (instancetype)horseToyNode
{
     return [self toyNodeWithImageNamed:@"toy-horse" mass:93];
}

+ (instancetype)planeToyNode
{
     return [self toyNodeWithImageNamed:@"toy-plane" mass:99];
}

+ (instancetype)scooterToyNode
{
     return [self toyNodeWithImageNamed:@"toy-scooter" mass:78];
}

+ (instancetype)soldierToyNode
{
     return [self toyNodeWithImageNamed:@"toy-soldier" mass:52];
}

@end
