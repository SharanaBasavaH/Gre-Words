//
//  SMSGreGroupListViewController.m
//  Gre Words
//
//  Created by Sharana Basava on 3/27/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSGreGroupListViewController.h"
#import "SMSGreGroupAddViewController.h"
#import "SMSGreGroupDisplayViewController.h"
#import "SMSGreStudyViewController.h"
#import "SMSGreDataManager.h"
#import "SMSAppDelegate.h"


enum buttonTag {
    viewButton  = 4,
    studyButton = 5,
    testButton  = 6
    };

//static NSMutableArray *words;
static NSMutableArray *groups;


@interface SMSGreGroupListViewController ()
@property (strong, nonatomic) IBOutlet UITableView *listTableView;
@end

@implementation SMSGreGroupListViewController

-(IBAction)unWindToList:(UIStoryboardSegue*)segue {
    [[SMSGreDataManager sharedDataManager] getGreGroups];
    groups = [[SMSGreDataManager sharedDataManager] greGroupsarray];
    [self.listTableView reloadData];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    groups = [[SMSGreDataManager sharedDataManager] greGroupsarray];
    
    [[SMSAppDelegate appDelegate] setNavigationBarBackGroundColor:self.navigationController];
  
    self.view.backgroundColor          = [SMSAppDelegate appDelegate].backGroundColor;
    self.listTableView.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
    
}

-(void) viewWillAppear:(BOOL)animated {
    SMSGreDataManager *dataManager = [SMSGreDataManager sharedDataManager];
    groups = [[SMSGreDataManager sharedDataManager] greGroupsarray];
    
    dataManager.selectedWordIndex = 0;
    
    if(dataManager.bDisplayGroupWord)
        [self.listTableView reloadData];
    
    dataManager.bDisplayGroupWord = FALSE;
    
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
    return [[[SMSGreDataManager sharedDataManager] greGroupsarray] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:@"CellIdentifier@"];
        

    }
    SMSGreGroup *item = [groups objectAtIndex:indexPath.row];
    
    UILabel *lblName = (UILabel *)[cell viewWithTag:1];
    [lblName setText:item.groupName];
    
    UILabel *lblNoOfWords = (UILabel *)[cell viewWithTag:2];
    [lblNoOfWords setText:item.numberOfWordsinGroup];
    
    UILabel *lblResults = (UILabel *)[cell viewWithTag:3];
    [lblResults setText:[@"Test result: " stringByAppendingString:item.testResult]];

    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
        cell.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
}

-(NSIndexPath *) getButtonCellRow:(UIButton *) b {
    UITableView *tv       = nil;
    UIView *superViewTemp = [b superview];
    UITableViewCell *cell = nil;
    BOOL isFoundTable     = FALSE;
    BOOL isFoundCell      = FALSE;
    while(superViewTemp  != nil && ![superViewTemp isKindOfClass:[UIWindow class]]) {
        
        if ([superViewTemp isKindOfClass:[UITableViewCell class]]) {
            cell=(UITableViewCell*)superViewTemp;
            isFoundCell = TRUE;
        }else if ([superViewTemp isKindOfClass:[UITableView class]]){
            tv = (UITableView*)superViewTemp;
            isFoundTable = TRUE;
        }
        superViewTemp = [superViewTemp superview];
        if(isFoundCell && isFoundTable){
            break;
        }
    }
    if(tv != nil && cell != nil){
        return [tv indexPathForCell:(UITableViewCell*)cell];
    }
    return nil;
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UIButton *button =(UIButton*)sender;
    
    if(!(button.tag == viewButton || button.tag == studyButton || button.tag == testButton))
        return;
    
    NSIndexPath *ip        = [self getButtonCellRow:(UIButton*) sender];
    SMSGreDataManager *obj = [SMSGreDataManager sharedDataManager];
    obj.bDisplayGroupWord  = TRUE;
    obj.selectedGroupIndex = ip.row;
    
    if (button.tag == viewButton || button.tag == studyButton || button.tag == testButton) {
        SMSGreGroup *itemSelectedToView = [groups objectAtIndex:ip.row];
        
        if(obj.selectedGroupName == nil)
            obj.selectedGroupName = [[NSMutableString alloc] init];
        obj.selectedGroupName = [itemSelectedToView.groupName mutableCopy];
        
        [[SMSGreDataManager sharedDataManager] getWordsForGroup:itemSelectedToView.groupName];
    }
    
}

 

@end
