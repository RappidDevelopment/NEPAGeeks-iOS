//
//  SelfCheckinWebViewController.m
//  NEPA Geeks
//
//  Created by Matt Morgis on 1/7/17.
//  Copyright © 2017 Rappid Development LLC. All rights reserved.
//

#import "SelfCheckinWebViewController.h"

/**
 The URL for the self-checkin form.
 */
NSString * const SELF_CHECKIN_URL = @"https://nepageeks.repairshopr.com/wf/tabletcheckin/start?headless=true";

/**
 The view controller for the self-checkin page.
 */
@interface SelfCheckinWebViewController () <UIWebViewDelegate>

/**
 A reference to the view's activity indicator.
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

/**
 A reference to the view's web view.
 */
@property (weak, nonatomic) IBOutlet UIWebView *selfCheckinWebView;

/**
 The URL Request to the self-checkin page.
 */
@property (strong, nonatomic) NSURLRequest *selfCheckinURLRequest;

/**
 Loads the inital self-checkin page.
 */
- (void)resetWebView;

/**
 Shows the activity indicator on the view.
 */
- (void)startActivityIndicator;

/**
 Hides the activity indicator on the view.
 */
- (void)stopActivityIndicator;

@end

@implementation SelfCheckinWebViewController

#pragma mark - Setters/Getters 

- (NSURLRequest *)selfCheckinURLRequest {
    if (!_selfCheckinURLRequest) {
        NSURL *webViewURL = [NSURL URLWithString:SELF_CHECKIN_URL];
        _selfCheckinURLRequest = [NSURLRequest requestWithURL:webViewURL];
    }
    
    return _selfCheckinURLRequest;
}

#pragma mark - View Lifecycle 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self resetWebView];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    // Always show the activity indicator when a begins page is loading.
    [self startActivityIndicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // Always hide the activity indicator when a page is finished loading.
    [self stopActivityIndicator];
}
#pragma mark - Private Methods 

- (void)resetWebView {
    [self.selfCheckinWebView loadRequest:self.selfCheckinURLRequest];
}

- (void)startActivityIndicator {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)stopActivityIndicator {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

@end
