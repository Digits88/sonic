//
//  ViewController.h
//  SonicCamera
//
//  Created by Michael Newell on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScratchViewController.h"

@interface ViewController : UIViewController
<UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *picker;
@property (strong, nonatomic) UIImage *originalImage;



- (IBAction)openCamera:(id)sender;
@end
