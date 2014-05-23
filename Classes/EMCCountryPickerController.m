//
//  PMMChooseCountryViewControllerManual.m
//  
//
//  Created by Enrico Maria Crisostomo on 12/05/14.
//
//

#import "EMCCountryPickerController.h"
#import "UIImage+UIImage_PMMImageResize.h"
#import "PMMCountryManager.h"

@interface EMCCountryPickerController ()

@end

@implementation EMCCountryPickerController
{
    UISearchDisplayController *displayController;
    UISearchBar *searchBar;
    UIView *rootView;
    UITableView *countryTable;
    PMMCountry * _selectedCountry;
    NSArray *_countries;
    NSArray *_countrySearchResults;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self)
    {
        // Custom initialization
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self loadCountries];
    
    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:searchBar
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.topLayoutGuide
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:0]];
    
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

    [rootView addConstraint:[NSLayoutConstraint constraintWithItem:self.bottomLayoutGuide
                                                         attribute:NSLayoutAttributeTop
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:countryTable
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:0]];
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

- (void)chooseCountry:(PMMCountry *)chosenCountry;
{
    _selectedCountry = chosenCountry;
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
    
    [self.countryDelegate cityController:self city:_selectedCountry];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView cellForRowAtIndexPath:indexPath].accessoryType = UITableViewCellAccessoryNone;
}

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

- (void)loadCountries
{
    NSArray * allCountries = [[PMMCountryManager countryManager] allCountries];
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"countryName" ascending:YES];
    NSArray *descriptors = [NSArray arrayWithObjects:nameDescriptor, nil];
    _countries = [allCountries sortedArrayUsingDescriptors:descriptors];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifier" forIndexPath:indexPath];

    PMMCountry *currentCountry;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        currentCountry = [_countrySearchResults objectAtIndex:indexPath.row];
    }
    else
    {
        currentCountry = [_countries objectAtIndex:indexPath.row];
    }
    
    NSString *countryCode = [currentCountry countryCode];
    cell.textLabel.text = [currentCountry countryName];
  
    // Resize flag
    cell.imageView.image = [[UIImage imageNamed:countryCode] fitInSize:CGSizeMake(40, 40)];
    
    if (_selectedCountry && [_selectedCountry isEqual:currentCountry])
    {
        NSLog(@"Selection is %ld:%ld.", (long)tableView.indexPathForSelectedRow.section, (long)tableView.indexPathForSelectedRow.row);
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    // Configure the cell...
    return cell;
}

@end
