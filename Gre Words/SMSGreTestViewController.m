//
//  SMSGreTestViewController.m
//  Gre Words
//
//  Created by Sharana Basava on 3/28/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSGreTestViewController.h"
#import "SMSGreDataManager.h"
#import "SMSGreItem.h"
#import "SMSAppDelegate.h"

@interface SMSGreTestViewController () {
    SMSGreDataManager *datamanager;

}
@property (weak, nonatomic) IBOutlet UILabel *testWordLabel;
@property (weak, nonatomic) IBOutlet UITextField *answerTextField;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *resultsButton;

@end

static SMSGreItem *item;
static NSMutableArray *wordsForTest;
static NSUInteger rightAnswer;
static NSUInteger wrongAnswer;
static NSMutableString *wrongWords;





@implementation SMSGreTestViewController

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

    [self.previousButton setHidden:YES];
    
    self.view.backgroundColor = [SMSAppDelegate appDelegate].backGroundColor;

    
    SMSGreDataManager  *dataManager = [SMSGreDataManager sharedDataManager];
    [dataManager getWordsForGroup:dataManager.selectedGroupName];
    wordsForTest = dataManager.greWordsarray;
    
    wrongWords = [[NSMutableString alloc] init];
    rightAnswer = wrongAnswer = 0;
    datamanager = [SMSGreDataManager sharedDataManager];
    datamanager.selectedWordIndex = 0;
    item = [wordsForTest objectAtIndex:datamanager.selectedWordIndex];
    [_testWordLabel setText:item.word];
    
    if(datamanager.selectedWordIndex + 1 == wordsForTest.count)
        [self.nextButton setEnabled:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)previousTestButtonPressed:(id)sender
{
  
}

-(IBAction)nextTestButtonPressed:(id)sender
{
    
   
    [self checkWord];
    datamanager.selectedWordIndex++;
    self.answerTextField.text =@"";
    item = [wordsForTest objectAtIndex:datamanager.selectedWordIndex];
    [_testWordLabel setText:item.word];
    if(datamanager.selectedWordIndex + 1 == wordsForTest.count)
       [self.nextButton setEnabled:NO];
    
}

-(void)checkWord {
    if([item.verb rangeOfString:self.answerTextField.text].location == NSNotFound)
    {
        wrongAnswer++;
        if(wrongWords.length == 0)
            [wrongWords setString:item.word];
        else {
            [wrongWords appendString:@","];
            [wrongWords appendString:item.word];
        }
        
    }
    else
        rightAnswer++;
}
-(IBAction)resultTestButtonPressed:(id)sender
{
    
    [self checkWord];
    NSMutableString *messageToShow = [NSMutableString stringWithString:@"Got right"];
    [messageToShow appendFormat:@" %lu words out of %lu words.",(unsigned long)rightAnswer, (unsigned long)wordsForTest.count];
    
    if(wrongWords.length > 0)
    {
        if(wrongAnswer == 1)
            [messageToShow appendString:@"\nWord answered wrong:\n"];
        else

        [messageToShow appendString:@"\nWords answered wrong are:\n"];
        [messageToShow appendString:wrongWords];
    }
    
    
    
    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Test Result!"
                                                      message:messageToShow
                                                     delegate:nil
                                            cancelButtonTitle:@"OK"
                                            otherButtonTitles:nil];
    
    [message show];
}

@end
