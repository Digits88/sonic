//
//  ViewController.h
//  DrawingTest
//
//  Created by Michael Newell on 7/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property BOOL *activeMotion; // do we have motion
@property CGPoint startPoint; // last detected touchpoint

@property (weak, nonatomic) IBOutlet UIImageView *canvas;
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;

@end


