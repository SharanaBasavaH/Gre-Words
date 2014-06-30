//
//  SMSGreWordAddViewController.m
//  Gre Words
//
//  Created by Sharana Basava on 4/4/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSGreWordAddViewController.h"
#import "SMSGreWordsViewController.h"
#import "SMSGreDataManager.h"
#import "SMSGreNewWord.h"
#import "SMSAppDelegate.h"

@interface SMSGreWordAddViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *nTextField;
@property (weak, nonatomic) IBOutlet UITextField *vTextField;
@property (weak, nonatomic) IBOutlet UITextField *adjTextField;
@property (weak, nonatomic) IBOutlet UITextField *nDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *vDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *adjDescriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *wordTextField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@end

@implementation SMSGreWordAddViewController

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

    
    self.view.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;

    
    // add the largeView to the main scrollView
    //[self.scrollView addSubview:self.enclosingView];
  //  CGRect drawingRect = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height/2);
    
    //[self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width,self.view.frame.size.height - 50)];
    //NSLog(@"%@",self.scrollView.contentSize);
        self.scrollView.contentSize = CGSizeMake(320, 600);
    self.scrollView.frame = CGRectMake(0, 60, self.view.frame.size.width,self.view.frame.size.height/2 + 50 + 50 + 50);

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.saveButton) return;
    SMSGreNewWord *newWord = [[SMSGreNewWord alloc] init];
    newWord.word = self.wordTextField.text;
    newWord.verb = self.vTextField.text;
    newWord.verbDescription = self.vDescriptionTextField.text;
    newWord.noun = self.nTextField.text;
    newWord.nounDescription = self.nDescriptionTextField.text;
    newWord.adj = self.adjTextField.text;
    newWord.adjDescription = self.adjDescriptionTextField.text;
    
    [[SMSGreDataManager sharedDataManager] addWord:newWord];
    
    
}

@end
