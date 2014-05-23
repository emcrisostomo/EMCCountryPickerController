//
//  PMMCountry.h
//  Push Money Mobile
//
//  Created by Enrico Maria Crisostomo on 18/05/14.
//  Copyright (c) 2014 Grey Systems. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EMCCountry : NSObject

@property (readonly) NSString *countryCode;

+ (instancetype)countryWithCountryCode:(NSString *)code localizedNames:(NSDictionary *)names;
- (instancetype)initWithCountryCode:(NSString *)code localizedNames:(NSDictionary *)names;
- (NSString *)countryName;

@end
