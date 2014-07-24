//
//  MapViewController.m
//  SonicScratch
//
//  Created by Michael Newell on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize mapBGImage;

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
}

- (void)viewDidUnload
{
    [self setMapBGImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)openMapDetails:(id)sender {
    UIImage *mapDetailsImage = [UIImage imageNamed:@"map_details.png"];
    [mapBGImage setImage:mapDetailsImage];
}

- (IBAction)closeMapDetails:(id)sender {
    UIImage *mapDetailsImage = [UIImage imageNamed:@"map.png"];
    [mapBGImage setImage:mapDetailsImage];
}
@end
