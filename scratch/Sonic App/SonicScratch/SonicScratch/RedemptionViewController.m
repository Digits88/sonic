//
//  RedemptionViewController.m
//  SonicScratch
//
//  Created by Michael Newell on 7/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RedemptionViewController.h"

@interface RedemptionViewController ()

@end

@implementation RedemptionViewController

/*
 
 CUSTOM ACTIONS
 
 */


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"redemptionBackSegue"]) {
        ScratchViewController *svc = [segue destinationViewController];
//        [svc setOldCoupon:YES];
        NSLog(@"telling svc not to load the instructions image");
        svc.instructionsImageData = nil;
        svc.oldCoupon = (BOOL *) NO;
    }
}

/*
 
 DEFAULT ACTIONS
 
 */

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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
