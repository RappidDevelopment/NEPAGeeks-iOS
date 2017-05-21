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

/**
 The view controller for the appointment table view page.
 */
@interface AppointmentTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *appointmentTableView;

@end

@implementation AppointmentTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Hide empty table view rows
    self.appointmentTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    // Setup automatic table view cell heights
    self.appointmentTableView.rowHeight = UITableViewAutomaticDimension;
    self.appointmentTableView.estimatedRowHeight = 44.0;
}

#pragma mark - UITableViewDataSource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger numberOfSections = 1;
    
    return numberOfSections;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *sectionHeader = @"Services:";
    
    return sectionHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numberOfRows = [AppointmentType appointmentNameStrings].count;
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    
    switch (indexPath.section) {
        case 0: {
            AppointmentTableViewCell *appointmentCell = [tableView dequeueReusableCellWithIdentifier:[AppointmentTableViewCell reuseIdentifier]];
            [appointmentCell setAppointmentCellLabelText:[AppointmentType appointmentNameStrings][indexPath.row]];
            cell = appointmentCell;
        }
            
        default:
            break;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate 

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
