//
//  RequestParser.m
//  NEPA Geeks
//
//  Created by Matt Morgis on 1/7/17.
//  Copyright © 2017 Rappid Development LLC. All rights reserved.
//

#import "RequestParser.h"

/**
 The NEPA Geeks URL Host.
 */
NSString * const NEPA_GEEKS_HOST = @"www.nepageeks.com";

/**
 The REPAIRSHOPR URL Host.
 */
NSString * const REPAIRSHOPR_HOST = @"nepageeks.repairshopr.com";

/**
 The URL path to the self-checkin success/thank you page.
 */
NSString * const SUCCESS_PAGE_PATH = @"/self-check-in/thank-you";

/**
 The URL path to the appointment success/thank you page.
 */
NSString * const APPOINTMENT_SUCCESS_PAGE_PATH = @"10711";

/**
 Parses various NSURLRequests
 */
@interface RequestParser()

@end

@implementation RequestParser

+ (BOOL)requestIsToSelfCheckinSuccessPage:(NSURLRequest *)request {
    NSLog(@"%@", request.URL.absoluteString);

    BOOL isNEPAGeeksHost =  [request.URL.host isEqualToString:NEPA_GEEKS_HOST];
    BOOL isSuccessPagePath = [request.URL.path isEqualToString:SUCCESS_PAGE_PATH];
    
    return (isNEPAGeeksHost && isSuccessPagePath);
}

+ (BOOL)requestIsToAppointmentSuccessPage:(NSURLRequest *)request {
    NSLog(@"%@", request.URL.absoluteString);
    NSString *lastPathParameter = [request.URL.absoluteString lastPathComponent];
    BOOL isNEPAGeeksHost = [request.URL.host isEqualToString:REPAIRSHOPR_HOST];
    BOOL isSuccessPagePath = [lastPathParameter isEqualToString:APPOINTMENT_SUCCESS_PAGE_PATH];
    
    return (isNEPAGeeksHost && isSuccessPagePath);
}

@end
