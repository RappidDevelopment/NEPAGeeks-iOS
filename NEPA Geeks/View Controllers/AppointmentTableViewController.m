//
//  AppointmentTableViewController.m
//  NEPA Geeks
//
//  Created by Matt Morgis on 1/14/17.
//  Copyright © 2017 Rappid Development LLC. All rights reserved.
//

#import "AppointmentTableViewController.h"
#import "AppointmentTableViewCell.h"
#import "AppointmentType.h"

@interface AppointmentTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *appointmentTableView;

@end

@implementation AppointmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


@end
