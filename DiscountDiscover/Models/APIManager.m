//
//  APIManager.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "APIManager.h"
#import "Deal.h"
#import <CoreLocation/CoreLocation.h>

@interface APIManager() <CLLocationManagerDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property CLLocationManager *locationManager;

@end

@implementation APIManager

- (id)init {
    self = [super init];

    self.session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;

    if ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager requestWhenInUseAuthorization];
    }

    return self;
}

- (void)fetchDeals:(void(^)(NSArray *deals, NSError *error))completion {
    [self.locationManager startUpdatingLocation];
    CLLocationCoordinate2D locationCoordinate = self.locationManager.location.coordinate;
    [self.locationManager stopUpdatingLocation];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:
                    @"APIKeys" ofType:@"plist"];
    NSDictionary *plist = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSString *apiKey = [plist valueForKey:@"DiscountAPIKey"];
    
    NSString *urlString = [NSString stringWithFormat:@"https://api.discountapi.com/v2/deals?api_key=%@&location=%f,%f&radius=5", apiKey, locationCoordinate.latitude, locationCoordinate.longitude];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) {
            completion(nil, error);
        }
        else {
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

            NSArray *dictionaries = dataDictionary[@"deals"];
            NSArray<Deal *> *deals = [Deal dealsWithDictionaries:dictionaries];
            
            completion(deals, nil);
        }
    }];
    [task resume];
}

@end
