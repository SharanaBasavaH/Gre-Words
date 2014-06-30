//
//  SMSGreStudyViewController.h
//  Gre Words
//
//  Created by Sharana Basava on 3/27/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMSGreNewWord.h"
#import "Word.h"

@interface SMSGreStudyViewController : UIViewController <UITabBarControllerDelegate>
@property (retain,nonatomic) Word *selectedSearchWord;
@property (retain,nonatomic) Word *selectedWordToDisplay;

@end
