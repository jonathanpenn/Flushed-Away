//
//  FLABackStoryScene.m
//  Flushed Away
//
//  Created by Jonathan on 9/10/13.
//  Copyright (c) 2013 Piglettens, Ltd. All rights reserved.
//

#import "FLABackStoryScene.h"
#import "FLAHelpScreen.h"

@interface FLABackStoryScene () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView* scrollView;

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
    CGRect labelFrame = CGRectMake(0, view.bounds.size.height, 360, view.bounds.size.height);
    
    NSString* backstory = @"While preparing to test your amazing shrinking ray on a full size boat, your two year old child accidentally activated it. Both you and the boat are now smaller than a toy.\n\nYour child then put you in the toilet and flushed it.\n\nWith more toys thrown down the drain, will you be able to last long enough for the shrinking ray to wear off?";

    backstoryLabel.text = backstory;
    
    CGSize backstorySize = [backstory sizeWithFont:backstoryLabel.font constrainedToSize:CGSizeMake(labelFrame.size.width, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    labelFrame.size.height = backstorySize.height;
    
    backstoryLabel.frame = labelFrame;

    
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake((self.size.width/2) - labelFrame.size.width/2, 0, labelFrame.size.width, view.bounds.size.height)];
    scrollView.contentSize = CGSizeMake(labelFrame.size.width, labelFrame.size.height * 4);

//    scrollView.backgroundColor = [UIColor whiteColor];
    [scrollView addSubview:backstoryLabel];
    scrollView.userInteractionEnabled = NO;
    
    [view addSubview:scrollView];
    
    self.scrollView = scrollView;
    
    CALayer *layer = scrollView.layer;
    CATransform3D perspectiveTransform = CATransform3DIdentity;
    perspectiveTransform.m34 = 1.0 / -900;
    perspectiveTransform = CATransform3DRotate(perspectiveTransform, 45.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
    layer.transform = perspectiveTransform;
    
    [UIView animateWithDuration:25 delay:1 options:UIViewAnimationOptionCurveLinear animations:^{
        scrollView.contentOffset = CGPointMake(0, scrollView.contentSize.height);
    } completion:^(BOOL finished) {
        [self goToNextScene];
    }];
}

- (void)goToNextScene
{
    [UIView animateWithDuration:0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.scrollView.contentOffset = self.scrollView.contentOffset;
    } completion:^(BOOL finished) {
    }];
    [self.scrollView removeFromSuperview];
    
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