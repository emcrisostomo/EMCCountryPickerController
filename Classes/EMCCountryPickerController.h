//
//  PMMChooseCountryViewControllerManual.h
//  
//
//  Created by Enrico Maria Crisostomo on 12/05/14.
//
//

#import <UIKit/UIKit.h>
#import "EMCCountryDelegate.h"
#import "EMCCountry.h"

@interface EMCCountryPickerController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

- (void)chooseCountry:(EMCCountry *)chosenCountry;

@property (weak) id<EMCCountryDelegate> countryDelegate;

@end
