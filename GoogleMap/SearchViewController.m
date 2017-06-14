//
//  SearchViewController.m
//  GoogleMap
//
//  Created by Evin on 2017/6/13.
//  Copyright © 2017年 ingpal. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<GMSAutocompleteResultsViewControllerDelegate,UISearchControllerDelegate>
{
    GMSAutocompleteResultsViewController *_resultsViewController;
    UISearchController  *_searchController;
}
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    
    _resultsViewController = [[GMSAutocompleteResultsViewController alloc] init];
    _resultsViewController.delegate = self;
    
    _searchController = [[UISearchController alloc]
                         initWithSearchResultsController:_resultsViewController];
    _searchController.searchResultsUpdater = _resultsViewController;
    
    // Put the search bar in the navigation bar.
    [_searchController.searchBar sizeToFit];
    self.navigationItem.titleView = _searchController.searchBar;
    
    // When UISearchController presents the results view, present it in
    // this view controller, not one further up the chain.
    self.definesPresentationContext = YES;
    
    // Prevent the navigation bar from being hidden when searching.
    _searchController.hidesNavigationBarDuringPresentation = NO;
    [_searchController.searchBar becomeFirstResponder];
    
    _searchController.modalPresentationStyle = UIModalPresentationPopover;
}

// Handle the user's selection.
- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
 didAutocompleteWithPlace:(GMSPlace *)place {
    _searchController.active = NO;
    self.searchResultBlock(place);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)resultsController:(GMSAutocompleteResultsViewController *)resultsController
didFailAutocompleteWithError:(NSError *)error {
    //[self dismissViewControllerAnimated:YES completion:nil];
    [SVProgressHUD showInfoWithStatus:[error description]];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictionsForResultsController:
(GMSAutocompleteResultsViewController *)resultsController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
