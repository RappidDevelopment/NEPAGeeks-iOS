//
//  NEPAGeeksUINavigationController.m
//  NEPA Geeks
//
//  Created by Matt Morgis on 1/7/17.
//  Copyright © 2017 Rappid Development LLC. All rights reserved.
//

#import "NEPAGeeksUINavigationController.h"

/**
 A subclass of UINavigationController. This is used for all instances
 of UINavigationController within the app and ensures a consistent
 style throughout.
 */
@interface NEPAGeeksUINavigationController ()

@end

@implementation NEPAGeeksUINavigationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.topViewController.navigationItem.title = @"NEPA Geeks";
    self.navigationBar.translucent = NO;
    self.navigationBar.barTintColor = [UIColor colorWithRed: 0.0/255.0 green: 97.0/255.0 blue: 157.0/255.0 alpha: 1.0];
    self.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont fontWithName:@"SF Quartzite Extended" size:21]}];
    
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed: 0.0/255.0 green: 97.0/255.0 blue: 157.0/255.0 alpha: 1.0]];

}

@end
