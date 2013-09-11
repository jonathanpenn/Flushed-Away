//
//  FLABackStoryScene.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLABackStoryScene.h"
#import "FLAHelpScreen.h"

@interface FLABackStoryScene ()

@property (strong, nonatomic) UILabel* backstoryLabel;

@end

@implementation FLABackStoryScene

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [SKColor blackColor];
        self.anchorPoint = CGPointMake(0.5, 0.5);
    }
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    UILabel* backstoryLabel = [[UILabel alloc] init];
    backstoryLabel.textAlignment = NSTextAlignmentJustified;
    backstoryLabel.numberOfLines = 0;
    backstoryLabel.textColor = [UIColor colorWithRed:79/255.0f green:179/255.0f blue:237/255.0f alpha:1];
    backstoryLabel.font = [UIFont boldSystemFontOfSize:18];[UIFont boldSystemFontOfSize:18];
    CGRect labelFrame = CGRectMake(35, view.bounds.size.height, 360, view.bounds.size.height);
    
    NSString* backstory = @"While preparing to test your amazing shrinking ray on a full size boat, your two year old child accidentally activated it. Both you and the boat are now smaller than a toy.\n\nYour child then put you in the toilet and flushed it.\n\nWith more toys thrown down the drain, will you be able to last long enough for the shrinking ray to wear off?";

    backstoryLabel.text = backstory;
    
    CGSize backstorySize = [backstory sizeWithFont:backstoryLabel.font constrainedToSize:CGSizeMake(labelFrame.size.width, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    labelFrame.size.height = backstorySize.height;
    labelFrame.origin.x = (self.size.width/2) - labelFrame.size.width/2;
    
    backstoryLabel.frame = labelFrame;
    
    [view addSubview:backstoryLabel];
    
    self.backstoryLabel = backstoryLabel;

    [UIView animateWithDuration:23.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        CGRect labelFrame = self.backstoryLabel.frame;
        labelFrame.origin.y = -labelFrame.size.height-100;
        self.backstoryLabel.frame = labelFrame;
    } completion:^(BOOL finished) {
        [self goToNextScene];
    }];
}

- (void)goToNextScene
{
    [UIView animateWithDuration:0.0
                          delay:0.0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{self.backstoryLabel.frame = ((CALayer *)self.backstoryLabel.layer.presentationLayer).frame;}
                     completion:^(BOOL finished){}
     ];
    [self.backstoryLabel removeFromSuperview];
    SKScene *scene = [FLAHelpScreen sceneWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    SKTransition *transition = [SKTransition fadeWithDuration:1];
    
    // Present the scene.
    [self.view presentScene:scene transition:transition];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self goToNextScene];
}

@end