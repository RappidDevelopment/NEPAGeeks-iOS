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
 The URL path to the self-checkin success/thank you page.
 */
NSString * const SUCCESS_PAGE_PATH = @"/self-check-in/thank-you";

/**
 Parses various NSURLRequests
 */
@interface RequestParser()

/**
 Checks if the given request has a
 host of `nepageeks.com`
 
 @param request the request to be checked
 @return YES if `nepageeks.com` is the request's host, NO otherwise
 */
+ (BOOL)requestIsToNEPAGeeks:(NSURLRequest *)request;

@end

@implementation RequestParser

+ (BOOL)requestIsToSelfCheckinSuccessPage:(NSURLRequest *)request {
    BOOL isNEPAGeeksHost = [self requestIsToNEPAGeeks:request];
    BOOL isSuccessPagePath = [request.URL.path isEqualToString:SUCCESS_PAGE_PATH];
    
    return (isNEPAGeeksHost && isSuccessPagePath);
}


+ (BOOL)requestIsToNEPAGeeks:(NSURLRequest *)request {
    
    return [request.URL.host isEqualToString:NEPA_GEEKS_HOST];
}

@end
