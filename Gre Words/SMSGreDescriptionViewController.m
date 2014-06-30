//
//  SMSGreDescriptionViewController.m
//  Gre Words
//
//  Created by Sharana Basava on 4/1/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSGreDescriptionViewController.h"
#import "SMSAppDelegate.h"

@interface SMSGreDescriptionViewController ()

@end

@implementation SMSGreDescriptionViewController

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

    [self.navigationItem setTitle:self.titleText];

	// Do any additional setup after loading the view.
}
-(void) viewWillAppear:(BOOL)animated {
    [self.textView setText:self.descriptionText];
    [self.navItemTitle setTitle:self.titleText];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
