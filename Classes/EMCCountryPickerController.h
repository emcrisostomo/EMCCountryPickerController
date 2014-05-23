//
//  PMMChooseCountryViewControllerManual.h
//  
//
//  Created by Enrico Maria Crisostomo on 12/05/14.
//
//

#import <UIKit/UIKit.h>
#import "PMMCountryDelegate.h"
#import "PMMCountry.h"

@interface EMCCountryPickerController : UIViewController<UITableViewDataSource, UITableViewDelegate, UISearchDisplayDelegate, UISearchBarDelegate>

- (void)chooseCountry:(PMMCountry *)chosenCountry;

@property (weak) id<PMMCountryDelegate> countryDelegate;

@end
