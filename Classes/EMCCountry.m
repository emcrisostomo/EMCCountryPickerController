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
{
    NSDictionary *_names;
}

+ (instancetype)countryWithCountryCode:(NSString *)code localizedNames:(NSDictionary *)names
{
    return [[EMCCountry alloc] initWithCountryCode:code localizedNames:names];
}

- (instancetype)init
{
    NSException* exception = [NSException
                              exceptionWithName:@"UnsupportedOperationException"
                              reason:@"This class cannot be instantiated."
                              userInfo:nil];
    @throw exception;
}

- (instancetype)initWithCountryCode:(NSString *)code localizedNames:(NSDictionary *)names
{
    self = [super init];
    
    if (self)
    {
        _countryCode = code;
        _names = [NSDictionary dictionaryWithDictionary:names];
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
    NSString *localisedName = _names[locale.localeIdentifier];
    
    if (localisedName)
    {
        return localisedName;
    }
    
    return _names[kDefaultLocale];
}

- (NSString *)countryNameWithLocaleIdentifier:(NSString *)localeIdentifier
{
    NSString *localisedName = _names[localeIdentifier];
    
    if (localisedName)
    {
        return localisedName;
    }
    
    return _names[kDefaultLocale];
}

@end
