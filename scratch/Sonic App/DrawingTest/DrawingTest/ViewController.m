//
//  ViewController.m
//  DrawingTest
//
//  Created by Michael Newell on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
//  code from this German guy: http://alex-maier.eu/?p=346
//
//  tomorrow ill start from here:
//  http://brandontreb.com/image-manipulation-retrieving-and-updating-pixel-values-for-a-uiimage/
//  and
//  http://stackoverflow.com/questions/448125/how-to-get-pixel-data-from-a-uiimage-cocoa-touch-or-cgimage-core-graphics

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize activeMotion;
@synthesize startPoint;
@synthesize canvas;
@synthesize bgImage;


/*
 
 TOUCH EVENTS
 
 */

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    startPoint = [[touches anyObject] locationInView:canvas];
    activeMotion = NO;
    NSLog(@"touch began");
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint newPoint = [[touches anyObject] locationInView:canvas];
    activeMotion = YES;
    [self drawLineFrom:startPoint To:newPoint];
    startPoint = newPoint;
    NSLog(@"touch moved");
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    CGPoint newPoint = [[touches anyObject] locationInView:canvas];
    if(!activeMotion) {
        [self drawLineFrom:startPoint To:newPoint];
    }
    NSLog(@"touch ended");
}

/*
 
 CUSTOM HANDLERS
 
 */

- (void) drawLineFrom:(CGPoint)start To:(CGPoint)end {
    
//    NSLog(@"Drawing line from %@ to %@", start, end);
    
    // define rectangle for drawing
    UIGraphicsBeginImageContext(canvas.frame.size);
    [canvas.image drawInRect:CGRectMake(0, 0, canvas.frame.size.width, canvas.frame.size.height)];
    
    // set line properties
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 8.0f);
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.5f, 0.3f, 0.3f, 0.3f);
    
    // move context to starting point
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), start.x, start.y);
    
    // define path to end point
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), end.x, end.y);
    
    // stroke
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    // flush the context and be sure all drawing operations were processed
    CGContextFlush(UIGraphicsGetCurrentContext());
    
    // get context and pass it to the image view
    canvas.image = UIGraphicsGetImageFromCurrentImageContext();
    
    // end image context
    UIGraphicsEndImageContext();
    
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
    [self setCanvas:nil];
    [self setBgImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
