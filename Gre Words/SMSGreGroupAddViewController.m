//
//  SMSGreGroupAddViewController.m
//  Gre Words
//
//  Created by Sharana Basava on 3/27/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSGreGroupAddViewController.h"
#import "SMSGreItem.h"
#import "SMSGreDataManager.h"
#import "Groups.h"
#import "Word.h"
#import "SMSAppDelegate.h"

#define SELECTEDKEY @"SELECTED"
static NSMutableArray *words;
static NSMutableArray *bSelectedCell;



@interface SMSGreGroupAddViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UITextField *listTextField;
@property (weak, nonatomic) IBOutlet UITableView *wordsTable;

@end

@implementation SMSGreGroupAddViewController


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
    [[SMSGreDataManager sharedDataManager] getWordsForGroup:ALL_WORDS_GROUP];
     words = [[SMSGreDataManager sharedDataManager] greWordsarray];
     bSelectedCell = [[NSMutableArray alloc] init];
    [[SMSAppDelegate appDelegate] setNavigationBarBackGroundColor:self.navigationController];

    
    [self resizeToOrientation:self.interfaceOrientation];
        
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [words count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GroupDisplayCell";
    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GroupDisplayCell"];
        [bSelectedCell addObject:[NSNumber numberWithInt:0]];
    }
    
    if([bSelectedCell count] > 0 && [indexPath row] < [bSelectedCell count]) {
        NSNumber *selected = (NSNumber*)[bSelectedCell objectAtIndex:indexPath.row];
        if (selected.integerValue == 1) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    else {
        [bSelectedCell addObject:[NSNumber numberWithInt:0]];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    [cell.textLabel setText:[[words objectAtIndex:indexPath.row] word]];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.listTextField resignFirstResponder];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSNumber *selected = (NSNumber*)[bSelectedCell objectAtIndex:indexPath.row];
    
    if(selected.integerValue == 1)
        [bSelectedCell setObject:[NSNumber numberWithInt:0] atIndexedSubscript:indexPath.row];
    else
        [bSelectedCell setObject:[NSNumber numberWithInt:1] atIndexedSubscript:indexPath.row];
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    SMSGreDataManager *dataManager = [SMSGreDataManager sharedDataManager];
    
    if (self.listTextField.text.length > 0) {
        for(int i=0; i < [bSelectedCell count]; i++ ) {
            NSNumber *selected = (NSNumber*)[bSelectedCell objectAtIndex:i];
            if(selected.integerValue == 1) {
                [dataManager addWordToGroup:[words objectAtIndex:i] inGroup:self.listTextField.text];
                
            }
        }
        [dataManager saveToCoreData];
    }
}

#pragma mark - TextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

#pragma - rotation

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self resizeToOrientation:toInterfaceOrientation];
    
}

-(void) resizeToOrientation:(UIInterfaceOrientation) toInterfaceOrientation  {
    CGRect          rect = self.listTextField.frame;
    
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
        self.listTextField.frame = CGRectMake(rect.origin.x
                                              , rect.origin.y, screenWidth - rect.origin.x - 10, rect.size.height);
    else
        self.listTextField.frame = CGRectMake(rect.origin.x
                                              , rect.origin.y, screenHeight - rect.origin.x - 10, rect.size.height);

}
@end
