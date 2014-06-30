//
//  SMSGreEditWordViewController.m
//  Gre Words
//
//  Created by Sharana Basava on 4/1/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSGreEditWordViewController.h"
#import "SMSGreDataManager.h"
#import "SMSAppDelegate.h"

@interface SMSGreEditWordViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end

@implementation SMSGreEditWordViewController

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
    
    self.navigationBar.backgroundColor = [[UIColor alloc] initWithRed: 34.0/255 green: 142.0/255 blue: 129.0/255 alpha: 1.0];
    
      self.navigationBar.tintColor = [[UIColor alloc] initWithRed: 34.0/255 green: 142.0/255 blue: 129.0/255 alpha: 1.0];


    self.view.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
    self.nountextField.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
    self.descriptiontextField.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;
    


	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewWillAppear:(BOOL)animated {
    // vc.itemToEdit.
//    if(_nEdited) {
//        [self.label setText:@".n"];
//        [self.nountextField setText:self.itemToEdit.noun];
//        [self.descriptiontextField setText:self.itemToEdit.nounDescription];
//    }
//    else if(_vEdited) {
//        [self.label setText:@".v"];
        [self.nountextField setText:self.itemToEdit.verb];
        [self.descriptiontextField setText:self.itemToEdit.verbDescription];
//    }
//    else if(_adjEdited) {
//        [self.label setText:@".adj"];
//        [self.nountextField setText:self.itemToEdit.adj];
//        [self.descriptiontextField setText:self.itemToEdit.adjDescription];
//    }    
}



 #pragma mark - Navigation
 
 // In a story board-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if(sender == self.saveButton) {
//        if(self.nEdited) {
//            self.itemToEdit.noun = self.nountextField.text;
//            self.itemToEdit.nounDescription = self.descriptiontextField.text;
//            
//        }
       // else if(self.vEdited) {
            self.itemToEdit.verb = self.nountextField.text;
            self.itemToEdit.verbDescription = self.descriptiontextField.text;
//        }
//        else if(self.adjEdited) {
//            self.itemToEdit.adj = self.nountextField.text;
//            self.itemToEdit.adjDescription = self.descriptiontextField.text;
//        }
        [[SMSGreDataManager sharedDataManager] saveToCoreData];
        
    }
    
}


#pragma mark - TextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
