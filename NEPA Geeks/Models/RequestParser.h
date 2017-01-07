//
//  RequestParser.h
//  NEPA Geeks
//
//  Created by Matt Morgis on 1/7/17.
//  Copyright © 2017 Rappid Development LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 Parses various NSURLRequests
 */
@interface RequestParser : NSObject


/**
 Checks if the given request is to the 
 self-checkin success/thank you page.

 @param request the request to be checked
 @return YES if request is to self-checkin page, NO otherwise.
 */
+ (BOOL)requestIsToSelfCheckinSuccessPage:(NSURLRequest *)request;

@end
