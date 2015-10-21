

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface AnimationFrame : NSObject {
    
}

@property (nonatomic) int lastIndex;
@property (nonatomic, retain) CALayer *rootAnimationLayer;
@property (nonatomic, retain) NSMutableArray *animationImages;

- (void)addLayers:(CALayer *)layer, ...NS_REQUIRES_NIL_TERMINATION;

- (void)sendFrameToBack:(AnimationFrame *)aFrame;
- (void)sendFrameToFront:(AnimationFrame *)aFrame;

@end
