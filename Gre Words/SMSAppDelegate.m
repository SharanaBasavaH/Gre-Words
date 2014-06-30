//
//  SMSAppDelegate.m
//  Gre Words
//
//  Created by Sharana Basava on 3/27/14.
//  Copyright (c) 2014 OWN. All rights reserved.
//

#import "SMSAppDelegate.h"
#import "SMSGreDataManager.h"
#import "SMSGreSearchViewController.h"

@implementation SMSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    SMSAppDelegate *appDelegate = (SMSAppDelegate *)[[UIApplication sharedApplication] delegate];
    tabBar = (UITabBarController *)appDelegate.window.rootViewController;
    tabBar.delegate = self;
    
    self.backGroundColor  = [[UIColor alloc] initWithRed: 255/255 green: 255/255 blue: 255/255 alpha: 1.0];
    
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (void)tabBarController:(UITabBarController *)theTabBarController didSelectViewController:(UIViewController *)viewController {
    
    SMSGreDataManager *dm = [SMSGreDataManager sharedDataManager];
    dm.selectedTabBarIndex = theTabBarController.selectedIndex;
}


+ (SMSAppDelegate *)appDelegate
{
    return (SMSAppDelegate *)[[UIApplication sharedApplication] delegate];
}

-(void) setNavigationBarBackGroundColor:(UINavigationController*) navBar
{
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        navBar.navigationBar.barTintColor = [[UIColor alloc] initWithRed: 34.0/255 green: 142.0/255 blue: 129.0/255 alpha: 1.0];
        navBar.navigationBar.translucent = NO;
    }else {
        navBar.navigationBar.tintColor = [[UIColor alloc] initWithRed: 34.0/255 green: 142.0/255 blue: 129.0/255 alpha: 1.0];
    }
    
    //[[UITabBar appearance] setTintColor:[UIColor redColor]];
  // [tabBar.tabBar setBarTintColor:[[UIColor alloc] initWithRed: 34.0/255 green: 142.0/255 blue: 129.0/255 alpha: 1.0]];

    //[[UITabBar appearance] setTintColor:[UIColor redColor]];
    //[[UITabBar appearance] setBarTintColor:[UIColor yellowColor]];
}

@end
