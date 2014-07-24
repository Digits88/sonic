//
//  ScratchViewController.m
//  SonicCamera
//
//  Created by Michael Newell on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScratchViewController.h"

@interface ScratchViewController ()

@end

@implementation ScratchViewController
@synthesize myLabel;
@synthesize myLabelData;
@synthesize backgroundImage;
@synthesize backgroundImageData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSLog(@"mylabel: %@", myLabelData);
    NSLog(@"backgroundImage: %@", backgroundImageData);
    [myLabel setText:myLabelData];
    [backgroundImage setImage:backgroundImageData];
}

- (void)viewDidUnload
{
    [self setMyLabel:nil];
    [self setBackgroundImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
