//
//  SMSAppDelegate.h
//  Gre Words
//
//  Created by Sharana Basava on 3/27/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSAppDelegate : UIResponder <UIApplicationDelegate,UITabBarControllerDelegate>{
    UITabBarController *tabBar;

}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIColor *backGroundColor;

+ (SMSAppDelegate *)appDelegate;
- (void) setNavigationBarBackGroundColor:(UINavigationController*) navBar;


@end
