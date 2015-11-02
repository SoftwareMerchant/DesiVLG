

#import "GenericAnimationView.h"

@implementation GenericAnimationView

@synthesize imageStackArray;
@synthesize textInset;
@synthesize textOffset;
@synthesize fontSize;
@synthesize font;
@synthesize fontAlignment;
@synthesize textTruncationMode;
@synthesize animationType;

- (id)initWithAnimationType:(AnimationType)aType
                     frame:(CGRect)aFrame
{
    self = [super init];
    if (self) {
        // Initialization code
        
        animationType = aType;
        
        textOffset = CGPointZero;
        textInset = CGPointZero;
        
        self.imageStackArray = [NSMutableArray array];
        
        templateWidth = aFrame.size.width;
        templateHeight = aFrame.size.height;
        self.frame = aFrame;
        
    }
    return self;
}

- (void)dealloc
{
    [imageStackArray removeAllObjects];
    [super dealloc];
}

- (BOOL)printText:(NSString *)tickerString 
       usingImage:(UIImage *)aImage
  backgroundColor:(UIColor *)aBackgroundColor
        textColor:(UIColor *)aTextColor {
    
    // render in context only if there is text
    if (tickerString) {
        
        CALayer *backingLayer = [CALayer layer];
        backingLayer.contentsGravity = kCAGravityResizeAspect;
        // set opaque to improve rendering speed
        backingLayer.opaque = YES;
        
        if (aImage) {
            [backingLayer setContents:(id)aImage.CGImage];
        }
        
        if (aBackgroundColor) {
            backingLayer.backgroundColor = aBackgroundColor.CGColor;
        }
        
        backingLayer.frame = CGRectMake(0, 0, templateWidth, templateHeight);
        
        // Composite text onto image layer by rendering a text layer in a new graphics context
        // For dynamic resizing need to compute the bounds based on font ascender and descender, and set the autoresizing mask
        CATextLayer *label = [CATextLayer layer];
        // for crisp text, set text layer to screen resolution
        label.contentsScale = [[UIScreen mainScreen] scale];
        label.contentsGravity = kCAGravityResizeAspect;
        label.string = tickerString;
        label.font = (__bridge CFTypeRef _Nullable)(font);
        label.fontSize = fontSize;
        label.alignmentMode = fontAlignment;
        label.truncationMode = textTruncationMode;
        
        if (aTextColor) {
            label.foregroundColor = aTextColor.CGColor;
        }
        
        CGRect boundsAfterInset = CGRectInset(backingLayer.bounds, textInset.x, textInset.y);
        label.bounds = boundsAfterInset;
        label.position = CGPointMake(backingLayer.position.x + textOffset.x, backingLayer.position.y + textOffset.y);
        
        [backingLayer addSublayer:label];
        
        CGFloat scale = [[UIScreen mainScreen] scale];
        CGSize size = CGSizeMake(backingLayer.frame.size.width*scale, backingLayer.frame.size.height*scale);
        UIGraphicsBeginImageContextWithOptions(size, NO, scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [backingLayer renderInContext:context];
        
        templateImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        [label removeFromSuperlayer];
        
    } else {
        templateImage = aImage;
    }

    if (templateImage) {
        return YES;
    }
    
    return NO;
}

- (CALayer *)layerWithFrame:(CGRect)aFrame
             contentGravity:(NSString *)aContentGravity
               cornerRadius:(float)aRadius
                doubleSided:(BOOL)aValue
{
    CALayer *layer = [CALayer layer];
    layer.frame = aFrame;
    if (aContentGravity) {
        layer.contentsGravity = aContentGravity;
    }
    layer.cornerRadius = aRadius;
    layer.doubleSided = NO;
    layer.masksToBounds = YES;
    layer.doubleSided = NO;
    layer.contentsGravity = kCAGravityResizeAspect;
    
    return layer;
}

// Pop the last set of images and push back onto the stack, to prepare for the next animation sequence
- (void)rearrangeLayers:(DirectionType)aDirectionType :(int)step {
    // for subclass to implement
}

@end
