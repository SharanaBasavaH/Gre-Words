//
//  SMSGreSerachWordDisplayViewController.m
//  Gre Words
//
//  Created by Sharana Basava on 4/10/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSGreSerachWordDisplayViewController.h"
#import "SMSAppDelegate.h"

@interface SMSGreSerachWordDisplayViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *wordLabel;
@property (weak, nonatomic) IBOutlet UILabel *vLabel;
@property (weak, nonatomic) IBOutlet UILabel *vDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *nLabel;
@property (weak, nonatomic) IBOutlet UILabel *nDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *adjLabel;
@property (weak, nonatomic) IBOutlet UILabel *adjDesLabel;
@property (weak, nonatomic) IBOutlet UITextView *vTextView;
@property (weak, nonatomic) IBOutlet UITextView *vDesTextView;
@property (weak, nonatomic) IBOutlet UITextView *nTextView;
@property (weak, nonatomic) IBOutlet UITextView *nDesTextView;
@property (weak, nonatomic) IBOutlet UITextView *adjTextView;
@property (weak, nonatomic) IBOutlet UITextView *adjDesTextView;

@end

@implementation SMSGreSerachWordDisplayViewController

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

    
    
	// Do any additional setup after loading the view.
    [self.wordLabel setText:self.wordToDisplay.word];
    [self.vTextView setText:self.wordToDisplay.verb];
    [self.vDesTextView setText:self.wordToDisplay.verbDescription];
    [self.nTextView setText:self.wordToDisplay.noun];
    [self.nDesTextView setText:self.wordToDisplay.nounDescription];
    
    [self.adjTextView setText:self.wordToDisplay.adj];
    [self.adjDesTextView setText:self.wordToDisplay.adjDescription];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height);
    self.scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
