//
//  MapViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/15/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "MapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import "LocationManager.h"
#import "DetailsViewController.h"
#import "DealMarker.h"

@interface MapViewController () <GMSMapViewDelegate>

@property (nonatomic, strong) GMSMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CLLocationCoordinate2D locationCoordinate = [LocationManager sharedLocationManager].currentLocationCoordinate;

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:locationCoordinate.latitude longitude:locationCoordinate.longitude zoom:17];
    self.mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    self.mapView.settings.myLocationButton = YES;
    self.mapView.myLocationEnabled = YES;
    [self.view addSubview:self.mapView];
    
    self.mapView.delegate = self;

    [self addDealMarkers];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];

    [self addDealMarkers];
}

- (void)addDealMarkers {
    [self.mapView clear];
    
    // create deal markers from deals
    [DealMarker markersWithDeals:self.deals map:self.mapView];
}

- (void)mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker {
    
    Deal *deal = marker.userData;
    [self performSegueWithIdentifier:@"detailsSegue" sender:deal];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Details view segue
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.deal = sender;
}

@end
