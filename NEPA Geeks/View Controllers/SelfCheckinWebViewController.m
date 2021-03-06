//
//  SelfCheckinWebViewController.m
//  NEPA Geeks
//
//  Created by Matt Morgis on 1/7/17.
//  Copyright © 2017 Rappid Development LLC. All rights reserved.
//

#import "SelfCheckinWebViewController.h"
#import "RequestParser.h"

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

/**
 Alerts the user the self-checkin was successful.
 This resets the webview on dismissal.
 */
- (void)showSuccessAlert;

/**
 Alerts the user an error was encountered.
 This resets the webview on dismissal.
 */
- (void)showErrorAlert;

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
    
    // If the user reaches the self-checkin success page...
    if ([RequestParser requestIsToSelfCheckinSuccessPage:request]) {
        
        // Show our own, native success alert, which will reset the webview on dismissal.
        [self showSuccessAlert];
        
        // And don't load the webview content.
        return NO;
    }
    
    // Otherwise, always load what's in the webview.
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    // Always show the activity indicator when a begins page is loading.
    [self startActivityIndicator];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *cssString = @"body { margin-top: -50px; }";
    NSString *javascriptString = @"var style = document.createElement('style'); style.innerHTML = '%@'; document.head.appendChild(style)";
    NSString *javascriptWithCSSString = [NSString stringWithFormat:javascriptString, cssString];
    [webView stringByEvaluatingJavaScriptFromString:javascriptWithCSSString];
    
    // Always hide the activity indicator when a page is finished loading.
    [self stopActivityIndicator];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // Hide the activity indicator if an error is encountered.
    [self stopActivityIndicator];
    // Alert the user of the error and give them an option to reset the webview.
    [self showErrorAlert];
}

#pragma mark - UIAlertController

- (void)showSuccessAlert {
    UIAlertController *successAlertController = [UIAlertController alertControllerWithTitle:@"Thank You"
                                                                  message:@"Thank you for choosing NEPA Geeks for your computer repair."
                                                           preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {[self resetWebView];}];
    [successAlertController addAction:defaultAction];
    [self presentViewController:successAlertController animated:YES completion:nil];
}

- (void)showErrorAlert {
    UIAlertController *errorAlertController = [UIAlertController alertControllerWithTitle:@"Error"
                                                                                    message:@"There was an error making your request. Please wait a few moments and try again."
                                                                             preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {[self resetWebView];}];
    [errorAlertController addAction:defaultAction];
    [self presentViewController:errorAlertController animated:YES completion:nil];
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
