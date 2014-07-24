//
//  ViewController.h
//  SonicRedraw
//
//  Created by Michael Newell on 7/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// image assets
@property (weak, nonatomic) IBOutlet UIImageView *mask;
@property (weak, nonatomic) IBOutlet UIImageView *coupon;
@property (weak, nonatomic) IBOutlet UIImageView *camera;
@property (weak, nonatomic) IBOutlet UIImageView *scratch;
@property (weak, nonatomic) IBOutlet UIImageView *touchDetector;
//@property (nonatomic, retain) UIImage *workingImage;

// touch related
@property BOOL *activeMotion; // do we have motion
@property CGPoint startPoint; // last detected touchpoint

@end
