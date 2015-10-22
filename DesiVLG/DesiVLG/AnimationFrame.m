

#import "AnimationFrame.h"
#import <QuartzCore/QuartzCore.h>

@implementation AnimationFrame

@synthesize lastIndex;
@synthesize rootAnimationLayer;
@synthesize animationImages;

- (id)init 
{    
    if ((self = [super init])) {
        self.animationImages = [NSMutableArray array];
        self.rootAnimationLayer = [CALayer layer];
    }
    
    return self;
}

- (void)dealloc
{
    [animationImages removeAllObjects];
    [animationImages release];
    
    [rootAnimationLayer release];
    
    [super dealloc];
}

- (void)sendFrameToBack:(AnimationFrame *)aFrame 
{
    CALayer *rootLayer = aFrame.rootAnimationLayer.superlayer;
    
    [rootAnimationLayer removeFromSuperlayer];
    
    [rootLayer insertSublayer:rootAnimationLayer below:aFrame.rootAnimationLayer];
}

- (void)sendFrameToFront:(AnimationFrame *)aFrame 
{
    CALayer *rootLayer = rootAnimationLayer.superlayer;
    
    [rootAnimationLayer removeFromSuperlayer];
    
    [rootLayer insertSublayer:rootAnimationLayer above:aFrame.rootAnimationLayer];
}

- (void)addLayers:(CALayer *)layer, ... 
{
    int index = [layer.superlayer.sublayers count];
    
    va_list args;
    va_start(args, layer);
    
    for (CALayer *arg = layer; arg != nil; arg = va_arg(args, CALayer *)) {
        [animationImages addObject:arg];
    }
    
    va_end(args);
    
    lastIndex = index;
}

@end
