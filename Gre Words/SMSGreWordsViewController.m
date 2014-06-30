//
//  SMSGreWordsViewController.m
//  Gre Words
//
//  Created by Sharana Basava on 4/4/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSGreWordsViewController.h"
#import "SMSGreDataManager.h"
#import "SMSGreStudyViewController.h"
#import "SMSAppDelegate.h"

@interface SMSGreWordsViewController ()
@property (weak, nonatomic) IBOutlet UITableView *wordsTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *addWordsButton;

@end

static NSMutableArray *words;

@implementation SMSGreWordsViewController

-(IBAction)unwindToWordsViewController:(UIStoryboardSegue*) segue {
    [[SMSGreDataManager sharedDataManager] getWordsForGroup:ALL_WORDS_GROUP];
    words = [[SMSGreDataManager sharedDataManager] greWordsarray];
    [self.wordsTableView reloadData];
}



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

    
    self.wordsTableView.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
    self.view.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
    
    

}
-(void) viewWillAppear:(BOOL)animated {
    SMSGreDataManager *manager = [SMSGreDataManager sharedDataManager];
    manager.bDisplayWord = FALSE;
    [[SMSGreDataManager sharedDataManager] getWordsForGroup:ALL_WORDS_GROUP];
    words = [[SMSGreDataManager sharedDataManager] greWordsarray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [words count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:@"Cell"];
    }
    
    [cell.textLabel setText:[[words objectAtIndex:indexPath.row] word]];
    return cell;

}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender != self.addWordsButton) {

    SMSGreDataManager *manager = [SMSGreDataManager sharedDataManager];
    manager.bDisplayWord = TRUE;
    
    NSIndexPath *ip = [self.wordsTableView indexPathForSelectedRow];
    
    SMSGreStudyViewController *dVc = [segue destinationViewController];
    
    dVc.selectedWordToDisplay = [words objectAtIndex:ip.row];
    
    }
    
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
