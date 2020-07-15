//
//  MapViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/15/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:37.783333 longitude:-122.416667 zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:self.view.frame camera:camera];
    mapView.myLocationEnabled = YES;
    [self.view addSubview:mapView];
}

@end
