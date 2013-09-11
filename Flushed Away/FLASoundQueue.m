//
//  FLASoundQueue.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLASoundQueue.h"

@interface FLASoundQueue () <AVAudioPlayerDelegate>
@property (nonatomic, strong) NSMutableArray *soundQueue;
@property (nonatomic, strong) AVAudioPlayer *currentlyPlaying;
@property (nonatomic) BOOL loopLastAudio;
@end

@implementation FLASoundQueue

- (void)queueSoundFileNamed:(NSString *)filename loop:(BOOL)loop
{
    NSAssert(self.loopLastAudio == NO, @"Cannot add another sound if the last one added will loop forever");

    NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:@"aif"];
    AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [player prepareToPlay];
    [self.soundQueue addObject:player];

    if (loop) { self.loopLastAudio = YES; }
}

- (void)stopAndClear
{
    [self.currentlyPlaying stop];
    self.currentlyPlaying.delegate = nil;
    self.currentlyPlaying = nil;
    self.soundQueue = nil;
    self.loopLastAudio = NO;
}

- (void)start
{
    if (self.currentlyPlaying) return;
    [self playNext];
}

- (void)playNext
{
    if ([self.soundQueue count] == 0) return;
    self.currentlyPlaying = [self.soundQueue firstObject];
    self.currentlyPlaying.delegate = self;

    [self.currentlyPlaying play];

    if ([self.soundQueue count] == 1 && self.loopLastAudio) {
        self.currentlyPlaying.numberOfLoops = -1;
    }
}

- (NSMutableArray *)soundQueue
{
    if (!_soundQueue) {
        _soundQueue = [NSMutableArray array];
    }
    return _soundQueue;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    self.currentlyPlaying.delegate = nil;
    [self.soundQueue removeObject:self.currentlyPlaying];
    [self playNext];
}

@end
