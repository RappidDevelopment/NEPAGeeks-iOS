//
//  AppointmentType.m
//  NEPA Geeks
//
//  Created by Matt Morgis on 1/14/17.
//  Copyright © 2017 Rappid Development LLC. All rights reserved.
//

#import "AppointmentType.h"

NSString * const BACK_UP = @"Back up your computer";

NSString * const TUNE_UP = @"Get your computer tuned up";

NSString * const VIRUS_REMOVAL = @"Malware and virus removal";

NSString * const DATA_RECOVERY = @"Data recovery services";

NSString * const OTHER = @"Something else? Schedule a consultation";

@implementation AppointmentType

+ (NSArray *)appointmentNameStrings {
    return @[BACK_UP,
             TUNE_UP,
             VIRUS_REMOVAL,
             DATA_RECOVERY,
             OTHER];
}

@end
