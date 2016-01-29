//
//  CPCViewController.h
//  EMCCountryPickerControllerDemo
//
//  Created by Enrico Maria Crisostomo on 23/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMCCountryDelegate.h"

@interface CPCViewController : UIViewController<EMCCountryDelegate>

@property (weak, nonatomic) IBOutlet UILabel *countryLabel;

@end
