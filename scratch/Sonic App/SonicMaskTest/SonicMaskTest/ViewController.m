//
//  ViewController.m
//  SonicMaskTest
//
//  Created by Michael Newell on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// image assets
@synthesize couponView;
@synthesize cameraView;
@synthesize maskView;
@synthesize canvasView;
@synthesize touchDetector;

// touch related
@synthesize activeMotion;
@synthesize startPoint;

/*
 
 TOUCH EVENTS
 
 */

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    startPoint = [[touches anyObject] locationInView:touchDetector];
    activeMotion = NO;
//    NSLog(@"touch started");
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint newPoint = [[touches anyObject] locationInView:touchDetector];
    activeMotion = YES;
//    NSLog(@"touch moved");
    [self drawLineFrom:startPoint To:newPoint];
    startPoint = newPoint;
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint newPoint = [[touches anyObject] locationInView:touchDetector];
    activeMotion = NO;
    if(!activeMotion) {
        [self drawLineFrom:startPoint To:newPoint];
        
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(delayOneSecond:) userInfo:nil repeats:NO];
        
    }
}

/*
 
 MASK ACTIONS
 
 */

- (void) drawLineFrom:(CGPoint)start To:(CGPoint)end {
    
    UIGraphicsBeginImageContextWithOptions(maskView.frame.size, YES, 1);
    [maskView.image drawInRect:CGRectMake(0, 0, maskView.frame.size.width, maskView.frame.size.height)];
    
    // set line properties
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 44.0f);
    
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0f, 1.0f, 1.0f, 1.0f);
    
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), YES);
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), start.x, start.y);
    
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), end.x, end.y);
    
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    CGContextFlush(UIGraphicsGetCurrentContext());
    
    [[self maskView] setImage:UIGraphicsGetImageFromCurrentImageContext()];
    
    UIGraphicsEndImageContext();
    
}

CGImageRef createMaskWithImage(CGImageRef image) {
    int maskWidth               = CGImageGetWidth(image);
    int maskHeight              = CGImageGetHeight(image);
    //  round bytesPerRow to the nearest 16 bytes, for performance's sake
    int bytesPerRow             = (maskWidth + 15) & 0xfffffff0;
    int bufferSize              = bytesPerRow * maskHeight;
    
    //  allocate memory for the bits 
    CFMutableDataRef dataBuffer = CFDataCreateMutable(kCFAllocatorDefault, 0);
    CFDataSetLength(dataBuffer, bufferSize);
    
    //  the data will be 8 bits per pixel, no alpha
    CGColorSpaceRef colourSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef ctx            = CGBitmapContextCreate(CFDataGetMutableBytePtr(dataBuffer),
                                                        maskWidth, maskHeight,
                                                        8, bytesPerRow, colourSpace, kCGImageAlphaNone);
    //  drawing into this context will draw into the dataBuffer.
    CGContextDrawImage(ctx, CGRectMake(0, 0, maskWidth, maskHeight), image);
    CGContextRelease(ctx);
    
    //  now make a mask from the data.
    CGDataProviderRef dataProvider  = CGDataProviderCreateWithCFData(dataBuffer);
    CGImageRef mask                 = CGImageMaskCreate(maskWidth, maskHeight, 8, 8, bytesPerRow,
                                                        dataProvider, NULL, FALSE);
    
    CGDataProviderRelease(dataProvider);
    CGColorSpaceRelease(colourSpace);
    CFRelease(dataBuffer);
    
    return mask;
}



- (UIImage*) maskImage:(UIImage *)image withMask:(UII *)maskImage {
    
//	CGImageRef maskRef = maskImage.CGImage; 
    
    CGImageRef maskRef = maskImage;
    
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
                                        CGImageGetHeight(maskRef),
                                        CGImageGetBitsPerComponent(maskRef),
                                        CGImageGetBitsPerPixel(maskRef),
                                        CGImageGetBytesPerRow(maskRef),
                                        CGImageGetDataProvider(maskRef), NULL, false);
    
	CGImageRef masked = CGImageCreateWithMask([image CGImage], mask);
	return [UIImage imageWithCGImage:masked];
    
}

- (void) delayOneSecond:(NSTimer*) t {
    
    UIImage *tmpImage = [couponView image];
    UIImage *tmpMask = [maskView image];
    CGImageRef tmpMaskRef = createMaskWithImage(tmpMask.CGImage);
    UIImage *tmpImageForCanvasView = [self maskImage:tmpImage withMask:tmpMaskRef];
    [canvasView setImage:tmpImage];
    NSLog(@"touch ended with image: %@", tmpImageForCanvasView);
}

/*
 
 DEFAULT ACTIONS
 
 */

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setCouponView:nil];
    [self setCameraView:nil];
    [self setMaskView:nil];
    [self setCanvasView:nil];
    [self setTouchDetector:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
