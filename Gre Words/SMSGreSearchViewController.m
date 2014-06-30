//
//  SMSGreSearchViewController.m
//  Gre Words
//
//  Created by Sharana Basava on 4/4/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSGreSearchViewController.h"
#import "SMSGreDataManager.h"
#import "SMSAppDelegate.h"
#import "SMSGreStudyViewController.h"

static BOOL displaySearchResults;

@interface SMSGreSearchViewController ()
@property (weak, nonatomic) IBOutlet UITableView *SearchTableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar2;

@end

static NSMutableArray *words, *searchedWords;

@implementation SMSGreSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[SMSAppDelegate appDelegate] setNavigationBarBackGroundColor:self.navigationController];

    self.SearchTableView.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
    self.view.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
    
    
    displaySearchResults = FALSE;
    SMSGreDataManager *datamanager =     [SMSGreDataManager sharedDataManager];

    [datamanager getWordsForGroup:ALL_WORDS_GROUP];
    words = [[[SMSGreDataManager sharedDataManager] greWordsarray] mutableCopy];

    searchedWords = [[NSMutableArray alloc] init];
    //self.searchDisplayController.searchResultsTableView.frame.origin.x = self.SearchTableView.frame;

	// Do any additional setup after loading the view.
}
-(void) viewWillAppear:(BOOL)animated {
    SMSGreDataManager *datamanager =     [SMSGreDataManager sharedDataManager];
    [datamanager getWordsForGroup:ALL_WORDS_GROUP];
    words = [[[SMSGreDataManager sharedDataManager] greWordsarray] mutableCopy];
    datamanager.bDisplaySearchWord = FALSE;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText {
    
    [[SMSGreDataManager sharedDataManager] searchWord:searchText];
    [words removeAllObjects];
    words = [[SMSGreDataManager sharedDataManager] greWordsarray];

}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(displaySearchResults)
        return [searchedWords count];
    else{
        return [words count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"searchCell";
    UITableViewCell *cell = [self.SearchTableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    
    NSString *wordText = nil;
    
    if(displaySearchResults) {
        wordText = [[searchedWords objectAtIndex:indexPath.row] word];
    }
    else
        wordText = [[words objectAtIndex:indexPath.row] word];
    
    
    [cell.textLabel setText:wordText];
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
}


#pragma mark - search bar delegate
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{                      // called when text ends editing
//    [[SMSGreDataManager sharedDataManager] searchWord:searchBar.text];
//    [searchedWords removeAllObjects];
//    searchedWords = [[SMSGreDataManager sharedDataManager] greWordsarray];
//    [self.searchDisplayController.searchResultsTableView reloadData];
//
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText  // called when text changes (including clear)
{
    [[SMSGreDataManager sharedDataManager] searchWord:searchBar.text];
    [searchedWords removeAllObjects];
    searchedWords = [[SMSGreDataManager sharedDataManager] greWordsarray];
    
    if(searchText.length == 0) {
        displaySearchResults = FALSE;
    }
    else
        displaySearchResults = TRUE;
    
    
    
    [self.SearchTableView reloadData];
    
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar*)searchBar; {
// called when keyboard search button pressed
    [searchBar resignFirstResponder];

}
//- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar;                   // called when bookmark button pressed
//{
//    ////[searchBar resignFirstResponder];
//
//}
- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar;                    // called when cancel button pressed
{
    [searchBar resignFirstResponder];

}
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.searchBar2 resignFirstResponder];
    
    SMSGreStudyViewController *dVc = [segue destinationViewController];
    
    
    SMSGreDataManager *datamanager =     [SMSGreDataManager sharedDataManager];

    NSIndexPath *ip = [self.SearchTableView indexPathForSelectedRow];
    datamanager.selectedWordIndex = ip.row;
    datamanager.bDisplaySearchWord = TRUE;
    
    
    
        if(displaySearchResults)
            dVc.selectedSearchWord = [searchedWords objectAtIndex:ip.row];
        else
            dVc.selectedSearchWord = [words objectAtIndex:ip.row];
    
    
//    Word *selectedWord = nil;
//    
//    if(displaySearchResults)
//        selectedWord = [searchedWords objectAtIndex:ip.row];
//    else
//        selectedWord = [words objectAtIndex:ip.row];
//    
//    dVc.wordToDisplay.word = [selectedWord.word mutableCopy];
//    dVc.wordToDisplay.verb = [selectedWord.verb mutableCopy];
//    dVc.wordToDisplay.verbDescription = [selectedWord.verbDescription mutableCopy];
//    dVc.wordToDisplay.noun = [selectedWord.noun mutableCopy];
//    dVc.wordToDisplay.nounDescription = [selectedWord.nounDescription mutableCopy];
//    dVc.wordToDisplay.adj = [selectedWord.adj mutableCopy];
//    dVc.wordToDisplay.adjDescription = [selectedWord.adjDescription mutableCopy];


}

@end
