//
//  EMCCountry.h
//  EMCCountryPickerController
//
//  Created by Enrico Maria Crisostomo on 18/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMCCountry : NSObject

@property (readonly) NSString *countryCode;

+ (instancetype)countryWithCountryCode:(NSString *)code localizedNames:(NSDictionary *)names;
- (instancetype)initWithCountryCode:(NSString *)code localizedNames:(NSDictionary *)names;
- (NSString *)countryName;
- (NSString *)countryNameWithLocale:(NSLocale *)locale;
- (NSString *)countryNameWithLocaleIdentifier:(NSString *)localeIdentifier;

@end
