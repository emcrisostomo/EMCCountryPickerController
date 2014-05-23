//
//  PMMCountryManager.m
//  Push Money Mobile
//
//  Created by Enrico Maria Crisostomo on 18/05/14.
//  Copyright (c) 2014 Grey Systems. All rights reserved.
//

#import "EMCCountryManager.h"
#import "EMCCountry.h"

@implementation EMCCountryManager
{
    NSDictionary *countryDict;
    NSArray *countryKeysArr;
}

static EMCCountryManager *_countryManager;

+ (void)initialize
{
    static BOOL initialized = NO;
    
    if (!initialized)
    {
        initialized = YES;
        _countryManager = [[EMCCountryManager alloc] init];
    }
}

+ (instancetype)countryManager
{
    return _countryManager;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self loadCountries];
    }
    
    return self;
}

- (void)loadCountries
{
    NSString *countriesPath = [[NSBundle mainBundle] pathForResource:@"countries"
                                                              ofType:@"plist"];
    countryDict = [NSDictionary dictionaryWithContentsOfFile:countriesPath];
    countryKeysArr = [countryDict allKeys];
    
    if (!countryDict || !countryKeysArr)
    {
        [NSException raise:@"Countries could not be loaded"
                    format:@"Either country dictionary [%@] or keys [%@] are null.", countryDict, countryKeysArr];
    }
}

- (NSUInteger)numberOfCountries
{
    return [countryKeysArr count];
}

- (EMCCountry *)countryWithCode:(NSString *)code
{
    return [EMCCountry countryWithCountryCode:code
                               localizedNames:[countryDict objectForKey:code]];
}

- (NSArray *)countryCodes
{
    return [NSArray arrayWithArray:countryKeysArr];
}

- (NSArray *)allCountries
{
    NSMutableArray *countries = [[NSMutableArray alloc] init];
    
    for (id code in countryKeysArr)
    {
        [countries addObject:[self countryWithCode:code]];
    }
    
    return countries;
}

@end
