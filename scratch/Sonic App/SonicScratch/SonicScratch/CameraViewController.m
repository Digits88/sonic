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
@synthesize introImageView;
@synthesize cameraOverlayView;
@synthesize cameraOverlayImage;

@synthesize picker;
@synthesize originalImage;

// preload camera?
@synthesize preloadCamera;



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
    
    // set the image backup
    [introImageView setImage:[UIImage imageNamed:@"intro.png"]];
}

- (void) viewDidAppear:(BOOL)animated {
    // set something here that we can query and launch with
    if (preloadCamera) {
        [self presentViewController:picker animated:YES completion:^(void) {
            // on completion of camera init
            
        }];
        preloadCamera = (BOOL *) NO;
    }
}

- (void) viewWillAppear:(BOOL)animated {

}

- (void)viewDidUnload
{
    [self setOriginalImage:nil];
    [self setCameraOverlayView:nil];
    [self setCameraOverlayImage:nil];
    [self setIntroImageView:nil];
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
//        [svc setOldCoupon:NO];
        NSLog(@"telling svc to load the instructions image");
//        [[svc instructions] setImage:[UIImage imageNamed:@"scratch_instructions.png"]];
        svc.instructionsImageData = [UIImage imageNamed:@"scratch_instructions.png"];
        svc.oldCoupon = (BOOL *) YES;
    }
}


- (void) imagePickerControllerDidCancel: (UIImagePickerController *) p {
    [self dismissModalViewControllerAnimated: YES];
}

- (void) imagePickerController: (UIImagePickerController *) p didFinishPickingMediaWithInfo: (NSDictionary *) info {
    originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum (originalImage, nil, nil , nil);
    
    [self dismissViewControllerAnimated:YES completion:^(void) {
        // using a block to call the segue
        [self performSegueWithIdentifier:@"sendImage" sender:self];
    }];
    //[self dismissModalViewControllerAnimated: YES];
}

- (IBAction)cameraActionButton:(id)sender {
    // take the picture
    NSLog(@"taking picture");
    [picker takePicture];
    [introImageView setImage:nil];
}

- (IBAction)openCamera:(id)sender {
    [self presentViewController:picker animated:YES completion:^(void) {
        // on completion of camera init
    }];
    
//    [self loadCamera];
}

- (IBAction)buttonToDismissCamera:(id)sender {
    [picker dismissViewControllerAnimated:YES completion:^(void) {
        // do nothing here
    }];
}
@end
