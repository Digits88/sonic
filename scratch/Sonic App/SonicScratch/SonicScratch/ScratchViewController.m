//
//  ScratchViewController.m
//  SonicScratch
//
//  Created by Michael Newell on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScratchViewController.h"

@interface ScratchViewController ()

@end

@implementation ScratchViewController
// image assets
@synthesize coupon;
@synthesize camera;
@synthesize touchDetector;
@synthesize mask;
@synthesize backgroundImageData;
@synthesize instructions;
@synthesize couponButtons;

// touch related
@synthesize activeMotion;
@synthesize startPoint;

// state of the coupon
@synthesize oldCoupon;
@synthesize instructionsImageData;

/*
 
 TOUCH EVENTS
 
 */

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    startPoint = [[touches anyObject] locationInView:touchDetector];
    activeMotion = NO;
    [instructions setImage:nil];
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
        // fade the buttons in
        [couponButtons setImage:[UIImage imageNamed:@"coupon_buttons.png"]];
    }
    [self scratch:self];
    NSLog(@"touch ended");
}

/*
 
 MASK ACTIONS
 
 */

- (void) drawLineFrom:(CGPoint)start To:(CGPoint)end {
    
    // define rectangle for drawing
    UIGraphicsBeginImageContext(mask.frame.size);
    [mask.image drawInRect:CGRectMake(0, 0, mask.frame.size.width, mask.frame.size.height)];
    
    // set line properties
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 44.0f);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 1.0f, 1.0f, 1.0f, 1.0f);
    CGContextSetShouldAntialias(UIGraphicsGetCurrentContext(), NO);
    
    // move context to starting point
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), start.x, start.y);
    
    // define path to end point
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), end.x, end.y);
    
    // stroke
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    // flush the context and be sure all drawing operations were processed
    CGContextFlush(UIGraphicsGetCurrentContext());
    
    // get context and pass it to the image view
    [[self mask] setImage:UIGraphicsGetImageFromCurrentImageContext()];
    
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

        // set if black
        if (rawData[byteIndex + 3] > 0.1) { 
            rawData[byteIndex] =       couponRawData[byteIndex];
            rawData[byteIndex+1] =     couponRawData[byteIndex + 1];
            rawData[byteIndex+2] =     couponRawData[byteIndex + 2];
            rawData[byteIndex+3] =     rawData[byteIndex+3];
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
	
    [[self mask] setImage:rawImage];
	
	free(rawData);
    free(couponRawData);
}

/*
 
 DEFAULT EVENTS
 
 */

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) loadCouponBG {
    [coupon setImage:[UIImage imageNamed:@"coupon.png"]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [camera setImage:backgroundImageData];    
    [instructions setImage:instructionsImageData];
    if (!oldCoupon) {
        [couponButtons setImage:[UIImage imageNamed:@"coupon_buttons.png"]];
        [self loadCouponBG];
    } else {
        [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(loadCouponBG) userInfo:nil repeats:NO];
    }
}

//- (void) viewDidAppear:(BOOL)animated {
//    [super viewDidUnload];
//    
//    if (!oldCoupon) {
//        [instructions setImage:[UIImage imageNamed:@"scratch_instructions.png"]];
//    } else {
//        [instructions setImage:nil];
//    }
//    
//}

- (void)viewDidUnload
{
    [self setCoupon:nil];
    [self setCamera:nil];
    [self setTouchDetector:nil];
    [self setMask:nil];
    [self setBackgroundImageData:nil];
    [self setInstructions:nil];
    [self setCouponButtons:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
