//
//  EMCCountryDelegate.h
//  EMCCountryPickerController
//
//  Created by Enrico Maria Crisostomo on 19/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCCountry.h"

@protocol EMCCountryDelegate <NSObject>

- (void)countryController:(id)sender didSelectCountry:(EMCCountry *)chosenCountry;

@end
