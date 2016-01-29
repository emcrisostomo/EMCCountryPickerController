//
//  EMCCountry.m
//  EMCCountryPickerController
//
//  Created by Enrico Maria Crisostomo on 18/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import "EMCCountry.h"
#import "EMCCountryManager.h"

static NSString * const kDefaultLocale = @"en";

@implementation EMCCountry

+ (instancetype)countryWithCountryCode:(NSString *)code
{
    return [[EMCCountry alloc] initWithCountryCode:code];
}

- (instancetype)init
{
    NSException* exception = [NSException
                              exceptionWithName:@"UnsupportedOperationException"
                              reason:@"This class cannot be instantiated."
                              userInfo:nil];
    @throw exception;
}

- (instancetype)initWithCountryCode:(NSString *)code
{
    self = [super init];
    
    if (self)
    {
        _countryCode = code;
    }
    
    return self;
}

- (BOOL)isEqual:(id)other
{
    if (other == self)
        return YES;
    if (!other || ![other isKindOfClass:[self class]])
        return NO;
    
    return [self isEqualToCountry:other];
}

- (BOOL)isEqualToCountry:(EMCCountry *)aCountry
{
    if (self == aCountry)
        return YES;
    
    return [[self countryCode] isEqualToString:[aCountry countryCode]];
}

- (NSString *)countryName
{
    return [self countryNameWithLocaleIdentifier:[[NSLocale preferredLanguages] objectAtIndex:0]];
}

- (NSString *)countryNameWithLocale:(NSLocale *)locale
{
    
    NSString *localisedCountryName = [locale
                                     displayNameForKey:NSLocaleCountryCode value:self.countryCode];

    return localisedCountryName;
}

- (NSString *)countryNameWithLocaleIdentifier:(NSString *)localeIdentifier
{
    NSLocale* locale = [NSLocale localeWithLocaleIdentifier:localeIdentifier];
    return [self countryNameWithLocale:locale];
}

@end
