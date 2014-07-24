//
//  ViewController.m
//  SonicRedraw
//
//  Created by Michael Newell on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

// image assets
@synthesize mask;
@synthesize coupon;
@synthesize camera;
@synthesize scratch;
@synthesize touchDetector;
//@synthesize workingImage;

// touch related
@synthesize activeMotion;
@synthesize startPoint;

/*
 
 TOUCH EVENTS
 
 */

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    startPoint = [[touches anyObject] locationInView:touchDetector];
    activeMotion = NO;
//    NSLog(@"touch began");
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint newPoint = [[touches anyObject] locationInView:touchDetector];
    activeMotion = YES;
    [self drawLineFrom:startPoint To:newPoint];
    startPoint = newPoint;
//    NSLog(@"touch moved");
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint newPoint = [[touches anyObject] locationInView:touchDetector];
    activeMotion = NO;
    if(!activeMotion) {
//        [self drawLineFrom:startPoint To:newPoint];
        
    }
    [self scratch:self];
    NSLog(@"touch ended");
}

/*
 
 MASK ACTIONS
 
 */

- (void) drawLineFrom:(CGPoint)start To:(CGPoint)end {
    
    //    NSLog(@"Drawing line from %@ to %@", start, end);
    
    // define rectangle for drawing
    UIGraphicsBeginImageContext(mask.frame.size);
    [mask.image drawInRect:CGRectMake(0, 0, mask.frame.size.width, mask.frame.size.height)];
    
    // set line properties
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 44.0f);
//    CGContextSetRGBFillColor(UIGraphicsGetCurrentContext(), 1.0f, 1.0f, 1.0f, 1.0f);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0f, 1.0f, 1.0f, 1.0f);
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), NO);
//    CGFloat blur = 10.0;
//    CGSize offset = {5,5};
//    CGContextSetShadow(UIGraphicsGetCurrentContext(), offset, blur);
    
    // move context to starting point
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), start.x, start.y);
    
    // define path to end point
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), end.x, end.y);
    
    // stroke
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    // flush the context and be sure all drawing operations were processed
    CGContextFlush(UIGraphicsGetCurrentContext());
    
    // get context and pass it to the image view
//    mask.image = UIGraphicsGetImageFromCurrentImageContext();
    [[self mask] setImage:UIGraphicsGetImageFromCurrentImageContext()];
//    workingImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // end image context
    UIGraphicsEndImageContext();
    
//    [self scratch:self];
    
}

- (void) scratch:(id) sender {

    CGContextRef ctx;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;
    NSUInteger bitsPerComponent = 8;
    
    
    // mask image reference
    CGImageRef imageRef = [self.mask.image CGImage];
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    NSUInteger bytesPerRow = bytesPerPixel * width;
    unsigned char *rawData = malloc(height * width * bytesPerPixel);
    CGContextRef context = CGBitmapContextCreate(rawData, width, height,
												 bitsPerComponent, bytesPerRow, colorSpace,
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef); // writes the data from mask.image to the context which links to rawData
    CGContextRelease(context);
    
    // coupon image reference
    CGImageRef couponImageRef = [self.coupon.image CGImage];
    unsigned char *couponRawData = malloc(height * width * bytesPerPixel);;
    CGContextRef couponContext = CGBitmapContextCreate(couponRawData, width, height,
												 bitsPerComponent, bytesPerRow, colorSpace,
												 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(couponContext, CGRectMake(0, 0, width, height), couponImageRef);     
    CGContextRelease(couponContext);
    
    
	
    // Now your rawData contains the image data in the RGBA8888 pixel format.
    int byteIndex = (bytesPerRow * 0) + 0 * bytesPerPixel;
    int dimensions = width * height;
    for (int ii = 0 ; ii < dimensions ; ++ii)
    {
        // Get color values to construct a UIColor (example)
        //		  CGFloat red   = (rawData[byteIndex]     * 1.0) / 255.0;
        //        CGFloat green = (rawData[byteIndex + 1] * 1.0) / 255.0;
        //        CGFloat blue  = (rawData[byteIndex + 2] * 1.0) / 255.0;
        //        CGFloat alpha = (rawData[byteIndex + 3] * 1.0) / 255.0;
		
        // grayscale an image
		//int outputColor = (rawData[byteIndex] + rawData[byteIndex+1] + rawData[byteIndex+2]) / 3;
		
//        CGFloat red =       (rawData[byteIndex]         * 1.0) / 255.0;
//        CGFloat green =     (rawData[byteIndex + 1]     * 1.0) / 255.0;
//        CGFloat blue =      (rawData[byteIndex + 2]     * 1.0) / 255.0;
//        CGFloat alpha =     (rawData[byteIndex + 3]     * 1.0) / 255.0;
        
        // set if black
        if (rawData[byteIndex + 3] > 0.1) { 
            // this is the pixel data we want to set
//            rawData[byteIndex]      =  0.0;
//            rawData[byteIndex+1]    =  0.0;
//            rawData[byteIndex+2]    =  255.0;
//            rawData[byteIndex+3]    =  100.0;
            rawData[byteIndex] =       couponRawData[byteIndex];
            rawData[byteIndex+1] =     couponRawData[byteIndex + 1];
            rawData[byteIndex+2] =     couponRawData[byteIndex + 2];
            rawData[byteIndex+3] =     (rawData[byteIndex+3]);
        } else {
            rawData[byteIndex] =       0.0;
            rawData[byteIndex+1] =     0.0;
            rawData[byteIndex+2] =     0.0;
            rawData[byteIndex+3] =     0.0;
        }
		
        byteIndex += 4;
    }
	
	ctx = CGBitmapContextCreate(rawData,  
								CGImageGetWidth( imageRef ),  
								CGImageGetHeight( imageRef ),  
								8,  
								CGImageGetBytesPerRow( imageRef ),  
								CGImageGetColorSpace( imageRef ),  
								kCGImageAlphaPremultipliedLast ); 
	
	imageRef = CGBitmapContextCreateImage (ctx);  
	UIImage* rawImage = [UIImage imageWithCGImage:imageRef];  
	
	CGContextRelease(ctx);  
	
//	self.mask.image = rawImage;  
//	[self.mask setImage:self.workingImage];
    [[self mask] setImage:rawImage];
	
	free(rawData);
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
    [self setMask:nil];
    [self setCoupon:nil];
    [self setCamera:nil];
    [self setScratch:nil];
    [self setTouchDetector:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
