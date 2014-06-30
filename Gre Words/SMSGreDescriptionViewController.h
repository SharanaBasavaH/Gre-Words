//
//  SMSGreDescriptionViewController.h
//  Gre Words
//
//  Created by Sharana Basava on 4/1/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSGreDescriptionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic)  NSString *descriptionText;
@property (weak, nonatomic)  NSString *titleText;


@property (weak, nonatomic) IBOutlet UINavigationItem *navItemTitle;

@end
