//
//  FLASoundQueue.h
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FLASoundQueue : NSObject

- (void)queueSoundFileNamed:(NSString *)filename loop:(BOOL)loop;

- (void)stopAndClear;
- (void)start;

@end
