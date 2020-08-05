//
//  AppDelegate.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "AppDelegate.h"
#import "SceneDelegate.h"
#import "Parse/Parse.h"
#import "APIManager.h"
#import "LocationManager.h"
#import "DetailsViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <BackgroundTasks/BackgroundTasks.h>
@import GoogleMaps;

@interface AppDelegate () <UNUserNotificationCenterDelegate>

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
    
    // notification authorization
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {}];
    
    // background fetch frequency restriction
    const int minimumTime = 10800; // 3 hours
    [application setMinimumBackgroundFetchInterval:minimumTime];
    
    [UNUserNotificationCenter currentNotificationCenter].delegate = self;
    
    return YES;
}

-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{
    
    APIManager *manager = [[APIManager alloc] init];
    [manager fetchNearbyDeal:^(Deal *deal, UIBackgroundFetchResult result) {
        if (deal != nil) {
            [self scheduleNotification:deal];
        }
        completionHandler(result);
    }];
}

-(void)scheduleNotification:(Deal *)deal {
    
    // configure notification content
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Nearby Deal" arguments:nil];
    NSString *body = [NSString stringWithFormat:@"%@: %@", deal.storeName, deal.name];
    content.body = [NSString localizedUserNotificationStringForKey:body
            arguments:nil];
    NSData *dealData = [NSKeyedArchiver archivedDataWithRootObject:deal requiringSecureCoding:NO error:nil];
    content.userInfo = @{@"Deal": dealData};
     
    // create trigger
    UNTimeIntervalNotificationTrigger* trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    
    // create request with content and trigger
    UNNotificationRequest* request = [UNNotificationRequest
           requestWithIdentifier:@"NearbyDeal" content:content trigger:trigger];
     
    // add request to notification center
    UNUserNotificationCenter* center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:nil];
}

-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailsViewController *detailsViewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
    
    NSData *dealData = response.notification.request.content.userInfo[@"Deal"];
    Deal *deal = [NSKeyedUnarchiver unarchivedObjectOfClass:Deal.class fromData:dealData error:nil];
    detailsViewController.deal = deal;
    
    SceneDelegate *sd = (SceneDelegate *)[UIApplication sharedApplication].connectedScenes.allObjects[0].delegate;
    UITabBarController *tabController = (UITabBarController *)sd.window.rootViewController;
    UINavigationController *navController = (UINavigationController *)tabController;
    [navController pushViewController:detailsViewController animated:YES];
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}

@end
