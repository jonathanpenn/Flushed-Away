#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

typedef NS_OPTIONS(NSUInteger, RCWBodyCategory) {
    FLABodyCategoryDrain        = 1 << 0,
    FLABodyCategoryToy          = 1 << 1,
    FLABodyCategoryBoat         = 1 << 2,
};

@protocol FLACollisionNode <NSObject>
- (void)collidedWith:(SKNode *)node;
@end
