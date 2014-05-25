//
//  EMCChooseCountryViewControllerManual.h
//  EMCCountryPickerController
//
//  Created by Enrico Maria Crisostomo on 12/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EMCCountryDelegate.h"
#import "EMCCountry.h"

@interface EMCCountryPickerController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

- (void)chooseCountry:(EMCCountry *)chosenCountry;

@property (weak) IBOutlet id<EMCCountryDelegate> countryDelegate;
@property NSLocale *countryNameDisplayLocale;
@property BOOL drawFlagBorder;
@property UIColor *flagBorderColor;
@property CGFloat flagBorderWidth;

@end
