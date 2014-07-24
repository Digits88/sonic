//
//  CameraViewController.m
//  SonicScratch
//
//  Created by Michael Newell on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CameraViewController.h"

@interface CameraViewController ()

@end

@implementation CameraViewController
@synthesize cameraOverlayView;
@synthesize cameraOverlayImage;

@synthesize picker;
@synthesize originalImage;

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
    picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [picker setContentSizeForViewInPopover:CGSizeMake(320.0, 460.0)];
    CGAffineTransform cameraTransform = CGAffineTransformMakeScale(1.23, 1.23);
    picker.cameraViewTransform = cameraTransform;
    [picker setShowsCameraControls:NO];
    [picker setCameraOverlayView:cameraOverlayView];
    [picker setAllowsEditing:NO];
    [picker setDelegate:self];
}

- (void)viewDidUnload
{
    [self setOriginalImage:nil];
    [self setCameraOverlayView:nil];
    [self setCameraOverlayImage:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
 
 CUSTOM ACTIONS
 
 */

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"sendImage"]) {
        ScratchViewController *svc = [segue destinationViewController];
        svc.backgroundImageData = [self originalImage];
    }
}


- (void) imagePickerControllerDidCancel: (UIImagePickerController *) p {
    [self dismissModalViewControllerAnimated: YES];
}

- (void) imagePickerController: (UIImagePickerController *) p didFinishPickingMediaWithInfo: (NSDictionary *) info {
    originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum (originalImage, nil, nil , nil);
    
    [self dismissViewControllerAnimated:NO completion:^(void) {
        // using a block to call the segue
        [self performSegueWithIdentifier:@"sendImage" sender:self];
    }];
    //[self dismissModalViewControllerAnimated: YES];
}

- (IBAction)cameraActionButton:(id)sender {
    // take the picture
    NSLog(@"taking picture");
    [picker takePicture];
}

- (IBAction)openCamera:(id)sender {
    [self presentViewController:picker animated:YES completion:^(void) {
        // on completion of camera init
    }];
}
@end
