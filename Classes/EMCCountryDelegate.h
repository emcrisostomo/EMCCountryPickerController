//
//  PMMCountryDelegate.h
//  Push Money Mobile
//
//  Created by Enrico Maria Crisostomo on 19/05/14.
//  Copyright (c) 2014 Grey Systems. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EMCCountry.h"

@protocol EMCCountryDelegate <NSObject>

- (void)cityController:(id)sender city:(EMCCountry *)chosenCity;

@end
