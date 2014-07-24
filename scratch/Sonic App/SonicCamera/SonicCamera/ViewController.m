//
//  ViewController.m
//  SonicCamera
//
//  Created by Michael Newell on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize picker;
@synthesize originalImage;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    [picker setAllowsEditing:NO];
    [picker setDelegate:self];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier] isEqualToString:@"sendImage"]) {
        ScratchViewController *svc = [segue destinationViewController];
        svc.myLabelData = @"New Label String";
        svc.backgroundImageData = [self originalImage];
    }
}

- (void) imagePickerControllerDidCancel: (UIImagePickerController *) p {
    [self dismissModalViewControllerAnimated: YES];
}

- (void) imagePickerController: (UIImagePickerController *) p didFinishPickingMediaWithInfo: (NSDictionary *) info {
    originalImage = (UIImage *) [info objectForKey:UIImagePickerControllerOriginalImage];
    UIImageWriteToSavedPhotosAlbum (originalImage, nil, nil , nil);
//    [[p parentViewController] dismissModalViewControllerAnimated: YES];
    [self dismissViewControllerAnimated:NO completion:^(void) {
        // using a block to call the segue
        [self performSegueWithIdentifier:@"sendImage" sender:self];
    }];
}



- (IBAction)openCamera:(id)sender {
    [self presentViewController:picker animated:YES completion:^(void) {
        // on completion of camera init
    }];
}
@end
