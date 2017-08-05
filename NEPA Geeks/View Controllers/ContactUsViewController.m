//
//  ContactUsViewController.m
//  NEPA Geeks
//
//  Created by Matt Morgis on 8/5/17.
//  Copyright © 2017 Rappid Development LLC. All rights reserved.
//

#import "ContactUsViewController.h"
@import MapKit;

@interface ContactUsViewController ()

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIImageView *facebookImageView;
@property (weak, nonatomic) IBOutlet UIImageView *twitterImageView;
@property (weak, nonatomic) IBOutlet UIImageView *emailImageView;

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocation *initalLocation = [[CLLocation alloc] initWithLatitude:41.242527 longitude:-75.909463];
    CLLocationDistance regionRadius = 1000;
    MKCoordinateRegion coordinateRegion = MKCoordinateRegionMakeWithDistance(initalLocation.coordinate, regionRadius * 2.0, regionRadius);
    [self.mapView setRegion:coordinateRegion animated:YES];
    
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    [point setCoordinate:CLLocationCoordinate2DMake(41.242527, -75.909463)];
    [point setTitle:@"NEPA Geeks"];
    [point setSubtitle:@"237 Old River Road"];
    [self.mapView addAnnotation:point];
    
    UITapGestureRecognizer *facebook = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(facebookTapped)];
    self.facebookImageView.userInteractionEnabled = YES;
    [self.facebookImageView addGestureRecognizer:facebook];
    
    UITapGestureRecognizer *twitter = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twitterTapped)];
    self.twitterImageView.userInteractionEnabled = YES;
    [self.twitterImageView addGestureRecognizer:twitter];
    
    UITapGestureRecognizer *mail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emailTapped)];
    self.emailImageView.userInteractionEnabled = YES;
    [self.emailImageView addGestureRecognizer:mail];
}

- (void)facebookTapped {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/nepageeks/"] options:@{} completionHandler:nil];
}

- (void)emailTapped {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"mailto:staff@nepageeks.com"] options:@{} completionHandler:nil];
}

- (void)twitterTapped {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/nepageeks"] options:@{} completionHandler:nil];
}

@end
