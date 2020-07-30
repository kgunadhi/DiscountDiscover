//
//  AppDelegate.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "AppDelegate.h"
#import "Parse/Parse.h"
#import "APIManager.h"
#import "LocationManager.h"
@import GoogleMaps;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // start updating location
    [LocationManager sharedLocationManager];
    
    // Parse
    ParseClientConfiguration *config = [ParseClientConfiguration   configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        
        configuration.applicationId = @"discountDiscover";
        configuration.server = @"https://discount-discover.herokuapp.com/parse";
    }];
    
    [Parse initializeWithConfiguration:config];
    
    // Google Maps
    [GMSServices provideAPIKey:[APIManager getAPIKey:@"GoogleAPIKey"]];
    
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

@end
