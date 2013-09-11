//
//  FLAToyNode.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLAToyNode.h"
#import "FLAPlayScene.h"
#import "FLADrainNode.h"

enum {
    NodeTypeBear = 0,
    NodeTypeBike,
    NodeTypeCar,
    NodeTypeDuck,
    NodeTypeHorse,
    NodeTypePlane,
    NodeTypeScooter,
    NodeTypeSoldier,
    NodeTypeCount
};

static NSArray* s_methodNames;

@implementation FLAToyNode

+ (instancetype)randomToyNode
{
    int rand = arc4random_uniform(NodeTypeCount);
    
    if (!s_methodNames) {
        s_methodNames = @[@"bearToyNode", @"bikeToyNode", @"carToyNode", @"duckToyNode", @"horseToyNode", @"planeToyNode", @"scooterToyNode", @"soldierToyNode"];
    }
    
    NSString* selectorString = s_methodNames[rand];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [self performSelector:NSSelectorFromString(selectorString)];
#pragma clang diagnostic pop
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


#pragma mark - Collision Handling

- (void)collidedWith:(SKNode *)node
{
    FLAPlayScene *scene = (id)self.scene;

    if ([node isKindOfClass:[FLADrainNode class]]) {
        [scene toy:self sankDownDrain:(FLADrainNode *)node];
    }
}


#pragma mark - Private

+ (instancetype)toyNodeWithImageNamed:(NSString*)image mass:(CGFloat)mass
{
    FLAToyNode* node = [FLAToyNode spriteNodeWithImageNamed:image];
    const CGFloat maxWidth = 20;
    node.size = CGSizeMake(maxWidth, maxWidth / node.texture.size.width * node.texture.size.height);
    node.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:MAX(node.size.height, node.size.width)/2];
    node.physicsBody.mass = mass;
    node.physicsBody.categoryBitMask = FLABodyCategoryToy;
    node.physicsBody.contactTestBitMask = FLABodyCategoryDrain | FLABodyCategoryBoat;
    node.physicsBody.collisionBitMask = 0;

    return node;
}

@end
