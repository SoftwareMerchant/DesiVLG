

#import "GenericAnimationView.h"

@interface FlipView : GenericAnimationView {
    
}

@property (nonatomic) float sublayerCornerRadius;

// use this method to add a static overlay layer on top of the animation layers
// set the zPosition to a value higher than all the animation layers
- (void)addOverlay;

- (BOOL)printText:(NSString *)tickerString 
       usingImage:(UIImage *)aImage
  backgroundColor:(UIColor *)aBackgroundColor
        textColor:(UIColor *)aTextColor;

// rearrangment is necessary because layers of the current frame that face away from the viewer
// need to mirror content from the next or previous frames, depending on direction
- (void)rearrangeLayers:(DirectionType)aDirectionType :(int)step;

@end
