//
//  ScratchViewController.h
//  SonicScratch
//
//  Created by Michael Newell on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScratchViewController : UIViewController
// image assets
@property (weak, nonatomic) IBOutlet UIImageView *coupon;
@property (weak, nonatomic) IBOutlet UIImageView *camera;
@property (weak, nonatomic) IBOutlet UIImageView *touchDetector;
@property (weak, nonatomic) IBOutlet UIImageView *mask;
@property (weak, nonatomic) UIImage *backgroundImageData;

// touch related
@property BOOL *activeMotion;
@property CGPoint startPoint;

@end
