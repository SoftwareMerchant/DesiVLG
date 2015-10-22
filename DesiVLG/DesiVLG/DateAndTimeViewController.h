//
//  DateAndTimeViewController.h
//  AwesomeTPWidget
//
//  Created by Nisarg Vora on 10/15/15.
//  Copyright © 2015 Nisarg Vora. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MZDayPicker.h"

@class FlipView;
@class AnimationDelegate;


@interface DateAndTimeViewController : UIViewController <UIGestureRecognizerDelegate> {
    
    int step;
    
    AnimationDelegate *animationDelegate;
    AnimationDelegate *animationDelegate2;
    
    BOOL runWhenRestart;
    
}

@property (weak, nonatomic) IBOutlet MZDayPicker *dayPicker;

@property (nonatomic, retain) FlipView *flipView;
@property (nonatomic, retain) FlipView *flipView2;

@property (nonatomic, retain) UIView *panRegion;
@property (nonatomic, retain) UIView *panRegion2;

@property (nonatomic, retain) UIPanGestureRecognizer *panRecognizer;
@property (nonatomic, retain) UIPanGestureRecognizer *panRecognizer2;


- (void)panned:(UIPanGestureRecognizer *)recognizer;
- (void)panned2:(UIPanGestureRecognizer *)recognizer2;
- (void)animationDidFinish:(int)direction;

@end