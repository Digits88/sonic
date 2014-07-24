//
//  ViewController.h
//  SonicMaskTest
//
//  Created by Michael Newell on 7/9/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

// image assets
@property (weak, nonatomic) IBOutlet UIImageView *couponView;
@property (weak, nonatomic) IBOutlet UIImageView *cameraView;
@property (weak, nonatomic) IBOutlet UIImageView *maskView;
@property (weak, nonatomic) IBOutlet UIImageView *canvasView;
@property (weak, nonatomic) IBOutlet UIImageView *touchDetector;

// touch related
@property BOOL *activeMotion; // do we have active motion?
@property CGPoint startPoint; // last detected touch point

@end
