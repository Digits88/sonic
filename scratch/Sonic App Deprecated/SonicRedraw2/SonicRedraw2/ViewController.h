//
//  ViewController.h
//  SonicRedraw2
//
//  Created by Michael Newell on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// image assets
@property (weak, nonatomic) IBOutlet UIImageView *coupon;
@property (weak, nonatomic) IBOutlet UIImageView *camera;
@property (weak, nonatomic) IBOutlet UIImageView *touchDetector;
@property (weak, nonatomic) IBOutlet UIImageView *mask;

// touch related
@property BOOL *activeMotion; // do we have motion
@property CGPoint startPoint; // last detected touchpoint

@end
