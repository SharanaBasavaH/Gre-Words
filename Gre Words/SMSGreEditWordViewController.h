//
//  SMSGreEditWordViewController.h
//  Gre Words
//
//  Created by Sharana Basava on 4/1/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMSGreItem.h"

@interface SMSGreEditWordViewController : UIViewController
@property (assign, nonatomic)  SMSGreItem *itemToEdit;
@property (assign, nonatomic)  BOOL nEdited;
@property (assign, nonatomic)  BOOL vEdited;
@property (assign, nonatomic)  BOOL adjEdited;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *nountextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptiontextField;

@end
