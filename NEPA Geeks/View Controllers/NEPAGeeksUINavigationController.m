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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topViewController.navigationItem.title = @"NEPA Geeks";
}

@end
