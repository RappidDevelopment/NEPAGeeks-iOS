//
//  AppointmentTableViewCell.m
//  NEPA Geeks
//
//  Created by Matt Morgis on 1/14/17.
//  Copyright © 2017 Rappid Development LLC. All rights reserved.
//

#import "AppointmentTableViewCell.h"

NSString * const REUSE_IDENTIFIER = @"AppointmentCell";

@interface AppointmentTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *appointmentTypeLabel;

@end

@implementation AppointmentTableViewCell

- (void)setAppointmentCellLabelText:(NSString *)labelText {
    NSLog(@"%@", labelText);
    self.appointmentTypeLabel.text = labelText;
}

+ (NSString *)reuseIdentifier {
    
    return REUSE_IDENTIFIER;
}

@end
