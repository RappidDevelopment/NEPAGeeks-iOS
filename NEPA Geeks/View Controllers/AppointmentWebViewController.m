//
//  AppointmentWebViewController.m
//  NEPA Geeks
//
//  Created by Matt Morgis on 5/21/17.
//  Copyright © 2017 Rappid Development LLC. All rights reserved.
//

#import "AppointmentWebViewController.h"
#import "RequestParser.h"

/**
 The URL for the appointment form.
 */
NSString * const APPOINTMENT_URL = @"https://nepageeks.repairshopr.com/wf/drop-off-appointment/start?headless=true";

/**
 The view controller for the appointment web view page.
 */
@interface AppointmentWebViewController () <UIWebViewDelegate>

/**
 A reference to the view's web view.
 */
@property (weak, nonatomic) IBOutlet UIWebView *appointmentWebView;

/**
 A reference to the view's activity indicator.
 */
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


/**
 The URL Request to the appointment page.
 */
@property (strong, nonatomic) NSURLRequest *appointmentURLRequest;

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

@implementation AppointmentWebViewController

#pragma mark - Setters/Getters

- (NSURLRequest *)appointmentURLRequest {
    if (!_appointmentURLRequest) {
        NSURL *webViewURL = [NSURL URLWithString:APPOINTMENT_URL];
        _appointmentURLRequest = [NSURLRequest requestWithURL:webViewURL];
    }
    
    return _appointmentURLRequest;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"NEPA Geeks";
    [self resetWebView];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
}

#pragma mark - UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    
    // If the user reaches the self-checkin success page...
    if ([RequestParser requestIsToAppointmentSuccessPage:request]) {
        
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
    if ([[webView stringByEvaluatingJavaScriptFromString:@"document.URL"] containsString:@"10709"]) {
        NSString *cssString = @"body { margin-top: -50px; }";
        NSString *javascriptString = @"var style = document.createElement('style'); style.innerHTML = '%@'; document.head.appendChild(style)";
        NSString *javascriptWithCSSString = [NSString stringWithFormat:javascriptString, cssString];
        [webView stringByEvaluatingJavaScriptFromString:javascriptWithCSSString];
        // NSLog(@"URL: %@", [webView stringByEvaluatingJavaScriptFromString:@"document.URL"]);
    }
    // Always hide the activity indicator when a page is finished loading.
    [self stopActivityIndicator];
    [self displayBackButtonIfNeeded];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // Hide the activity indicator if an error is encountered.
    [self stopActivityIndicator];
    // Alert the user of the error and give them an option to reset the webview.
    [self showErrorAlert];
    [self displayBackButtonIfNeeded];
}

#pragma mark - UIAlertController

- (void)showSuccessAlert {
    UIAlertController *successAlertController = [UIAlertController alertControllerWithTitle:@"Thank You"
                                                                                    message:@"Thank you for choosing NEPA Geeks for your computer repair. Someone will be in touch with you soon."
                                                                             preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {[self.navigationController popViewControllerAnimated:YES];}];
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
    [self.appointmentWebView loadRequest:self.appointmentURLRequest];
}

- (void)startActivityIndicator {
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)stopActivityIndicator {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

- (void)displayBackButtonIfNeeded {
    // If the user navigates somewhere in webview, show a back button
    // so they can return from where they came.
    if (self.appointmentWebView.canGoBack) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStylePlain target:self action:@selector(webViewButtonPressed)];
    } else if (!self.appointmentWebView.canGoBack) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Back"] style:UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed)];
    }
}

- (void)webViewButtonPressed {
    [self.appointmentWebView goBack];
}

- (void)backButtonPressed {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
