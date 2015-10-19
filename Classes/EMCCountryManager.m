//
//  PMMCountryManager.m
//  Push Money Mobile
//
//  Created by Enrico Maria Crisostomo on 18/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import "EMCCountryManager.h"
#import "EMCCountry.h"

@implementation EMCCountryManager
{
    NSArray *countriesArray;
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
    
    countriesArray = [NSArray arrayWithContentsOfFile:countriesPath];
    
    
    if (!countriesArray)
    {
        [NSException raise:@"Countries could not be loaded"
                    format:@"Country array is null: [%@]", countriesArray];
    }
}

- (NSUInteger)numberOfCountries
{
    return [countriesArray count];
}

- (EMCCountry *)countryWithCode:(NSString *)code
{
    return [EMCCountry countryWithCountryCode:code];
}

- (BOOL)existsCountryWithCode:(NSString *)code
{
    return [countriesArray containsObject:code];
}

- (NSArray *)countryCodes
{
    return [NSArray arrayWithArray:countriesArray];
}

- (NSArray *)allCountries
{
    NSMutableArray *countries = [[NSMutableArray alloc] init];
    
    for (id code in countriesArray)
    {
        [countries addObject:[self countryWithCode:code]];
    }
    
    return countries;
}

@end
