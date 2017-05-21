//
//  AppointmentTableViewCell.h
//  NEPA Geeks
//
//  Created by Matt Morgis on 1/14/17.
//  Copyright © 2017 Rappid Development LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppointmentTableViewCell : UITableViewCell

- (void)setAppointmentCellLabelText:(NSString *)labelText;

+ (NSString *)reuseIdentifier;

@end
