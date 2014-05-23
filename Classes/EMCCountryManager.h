//
//  EMCCountryManager.h
//  EMCCountryPickerController
//
//  Created by Enrico Maria Crisostomo on 18/05/14.
//  Copyright (c) 2014 Enrico Maria Crisostomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCCountryManager.h"
#import "EMCCountry.h"

@interface EMCCountryManager : NSObject

+ (instancetype)countryManager;
- (EMCCountry *)countryWithCode:(NSString *)code;
- (NSUInteger)numberOfCountries;
- (NSArray *)countryCodes;
- (NSArray *)allCountries;

@end
