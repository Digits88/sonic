//
//  MapViewController.h
//  SonicScratch
//
//  Created by Michael Newell on 7/8/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *mapBGImage;

- (IBAction)openMapDetails:(id)sender;
- (IBAction)closeMapDetails:(id)sender;
@end
