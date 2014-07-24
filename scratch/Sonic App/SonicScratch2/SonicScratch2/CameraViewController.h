//
//  CameraViewController.h
//  SonicScratch
//
//  Created by Michael Newell on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScratchViewController.h"

@interface CameraViewController : UIViewController
<UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) UIImage *originalImage;

// camera overlay
@property (weak, nonatomic) IBOutlet UIView *cameraOverlayView;
@property (weak, nonatomic) IBOutlet UIImageView *cameraOverlayImage;
- (IBAction)cameraActionButton:(id)sender;



- (IBAction)openCamera:(id)sender;

@end
