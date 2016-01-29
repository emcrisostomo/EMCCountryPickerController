//
//  EMCChooseCountryViewControllerManual.m
//  EMCCountryPickerController
//
//  Created by Enrico Maria Crisostomo on 12/05/14.
//  Copyright (c) 2014 Enrico M. Crisostomo. All rights reserved.
//

#import "EMCCountryPickerController.h"
#import "UIImage+UIImage_EMCImageResize.h"
#import "EMCCountryManager.h"

#if !__has_feature(objc_arc)
#error This class requires ARC support to be enabled.
#endif

static const CGFloat kEMCCountryCellControllerMinCellHeight = 25;

@interface EMCCountryPickerController ()

@end

@implementation EMCCountryPickerController
{
    UISearchDisplayController *displayController;
    UISearchBar *searchBar;
    UIView *rootView;
    UITableView *countryTable;
    EMCCountry * _selectedCountry;
    NSArray *_countries;
    NSArray *_countrySearchResults;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        [self loadDefaults];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        [self loadDefaults];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self validateSettings];
    [self loadCountries];
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        [rootView addConstraint:[NSLayoutConstraint constraintWithItem:searchBar
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.topLayoutGuide
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0]];
    }
    else
    {
        [rootView addConstraint:[NSLayoutConstraint constraintWithItem:searchBar
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0]];
    }
    
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:searchBar
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:rootView
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
    
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:searchBar
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:rootView
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1
                                                          constant:0]];
    
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:countryTable
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:searchBar
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:0]];
    
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:rootView
                                                         attribute:NSLayoutAttributeTrailing
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:countryTable
                                                         attribute:NSLayoutAttributeTrailing
                                                        multiplier:1
                                                          constant:0]];
    
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:rootView
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:countryTable
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1
                                                          constant:0]];
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
    {
        [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomLayoutGuide
                                                             attribute:NSLayoutAttributeTop
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:countryTable
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0]];
    }
    else
    {
        [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.view
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:countryTable
                                                             attribute:NSLayoutAttributeBottom
                                                            multiplier:1
                                                              constant:0]];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [displayController setActive:NO];
}

- (void)viewDidAppear:(BOOL)animated
{
    [self loadCountrySelection];
}

- (void)loadCountrySelection
{
    if (!_selectedCountry)
        return;
    
    [countryTable reloadData];
    
    NSUInteger selectedObjectIndex = [_countries indexOfObject:_selectedCountry];
    
    if (selectedObjectIndex != NSNotFound)
    {
        NSIndexPath * ip = [NSIndexPath indexPathForItem:selectedObjectIndex inSection:0];
        [countryTable selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
}

- (void)loadView
{
    rootView = [[UIView alloc] initWithFrame:CGRectZero];
    [rootView setBackgroundColor:[UIColor whiteColor]];
    rootView.autoresizesSubviews = YES;
    
    countryTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [rootView frame].size.width, [rootView frame].size.height)];
    [countryTable setTranslatesAutoresizingMaskIntoConstraints:NO];
    countryTable.dataSource = self;
    countryTable.delegate = self;
    [countryTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    
    searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [rootView frame].size.width, 0)];
    [searchBar setTranslatesAutoresizingMaskIntoConstraints:NO];
    searchBar.delegate = self;
    [searchBar sizeToFit];
    
    [rootView addSubview:searchBar];
    
    displayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar
                                                          contentsController:self];
    displayController.delegate = self;
    displayController.searchResultsDelegate = self;
    displayController.searchResultsDataSource = self;
    
    [[[self searchDisplayController] searchResultsTableView] registerClass:[UITableViewCell class]
                                                    forCellReuseIdentifier:@"identifier"];
    
    if ([self searchDisplayController] == nil) NSLog(@"Search DC is nil");
    
    [rootView addSubview:countryTable];
    
    self.view = rootView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Settings Management


- (void)loadDefaults
{
    self.showFlags = true;
    self.drawFlagBorder = true;
    self.flagBorderColor = [UIColor grayColor];
    self.flagBorderWidth = 0.5f;
    self.flagSize = 40.0f;
}

- (void)validateSettings
{
    if (self.flagSize <= 0)
    {
        [NSException raise:@"Invalid flag size." format:@"Invalid flag size: %f.", self.flagSize];
    }
}

#pragma mark - Table View Management

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [_countrySearchResults count];
    }
    
    // Return the number of rows in the section.
    return [_countries count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected row: %ld", (long)indexPath.row);
    
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryCheckmark;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        _selectedCountry = [_countrySearchResults objectAtIndex:indexPath.row];
        [self loadCountrySelection];
    }
    else
    {
        _selectedCountry = [_countries objectAtIndex:indexPath.row];
    }
    
    if (!self.countryDelegate)
    {
        NSLog(@"Delegate is not set, the view controller will not be dismissed.");
    }
    
    [self.countryDelegate countryController:self didSelectCountry:_selectedCountry];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];
    
    EMCCountry *currentCountry;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        currentCountry = [_countrySearchResults objectAtIndex:indexPath.row];
    }
    else
    {
        currentCountry = [_countries objectAtIndex:indexPath.row];
    }
    
    NSString *countryCode = [currentCountry countryCode];
    
    if (self.countryNameDisplayLocale)
    {
        cell.textLabel.text = [currentCountry countryNameWithLocale:self.countryNameDisplayLocale];
    }
    else
    {
        cell.textLabel.text = [currentCountry countryName];
    }
    
    // Resize flag
    if (self.showFlags)
    {
        NSString *imagePath = [NSString stringWithFormat:@"EMCCountryPickerController.bundle/%@", countryCode];
        UIImage *image = [UIImage imageNamed:imagePath inBundle:[NSBundle bundleForClass:self.class] compatibleWithTraitCollection:nil];
        cell.imageView.image = [image fitInSize:CGSizeMake(self.flagSize, self.flagSize)];
    }
    
    // Draw a border around the flag view if requested
    if (self.drawFlagBorder)
    {
        cell.imageView.layer.borderColor = self.flagBorderColor.CGColor;
        cell.imageView.layer.borderWidth = self.flagBorderWidth;
    }
    
    if (_selectedCountry && [_selectedCountry isEqual:currentCountry])
    {
        NSLog(@"Selection is %ld:%ld.", (long)tableView.indexPathForSelectedRow.section, (long)tableView.indexPathForSelectedRow.row);
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.flagSize < tableView.rowHeight)
    {
        return MAX(self.flagSize, kEMCCountryCellControllerMinCellHeight);
    }
    
    return MAX(tableView.rowHeight, self.flagSize);
}

#pragma mark - Search Box Management

- (void)filterContentForSearchText:(NSString*)searchText
                             scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF.countryName contains[cd] %@",
                                    searchText];
    
    _countrySearchResults = [_countries filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didHideSearchResultsTableView:(UITableView *)tableView
{
    [self loadCountrySelection];
}

#pragma mark - Country Management

- (void)chooseCountry:(EMCCountry *)chosenCountry;
{
    _selectedCountry = chosenCountry;
}

- (NSArray *)filterAvailableCountries:(NSSet *)countryCodes
{
    EMCCountryManager *countryManager = [EMCCountryManager countryManager];
    NSMutableArray *countries = [[NSMutableArray alloc] initWithCapacity:[countryCodes count]];
    
    for (id code in self.availableCountryCodes)
    {
        if ([countryManager existsCountryWithCode:code])
        {
            [countries addObject:[countryManager countryWithCode:code]];
        }
        else
        {
            [NSException raise:@"Unknown country code" format:@"Unknown country code %@", code];
        }
    }
    
    return countries;
}

- (void)loadCountries
{
    NSArray *availableCountries;
    
    if (self.availableCountryCodes)
    {
        availableCountries = [self filterAvailableCountries:self.availableCountryCodes];
    }
    else
    {
        availableCountries = [[EMCCountryManager countryManager] allCountries];
    }
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"countryName" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObjects:nameDescriptor, nil];
    _countries = [availableCountries sortedArrayUsingDescriptors:descriptors];
}

@end
