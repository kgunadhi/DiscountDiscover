//
//  DealNotificationsManager.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 8/6/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "DealNotificationsManager.h"
#import <UserNotifications/UserNotifications.h>

@implementation DealNotificationsManager

+ (void)scheduleNotification:(Deal *)deal {
    
    // configure notification content
    UNMutableNotificationContent* content = [[UNMutableNotificationContent alloc] init];
    content.title = [NSString localizedUserNotificationStringForKey:@"Nearby Deal" arguments:nil];
    NSString *body = [NSString stringWithFormat:@"%@: %@", deal.storeName, deal.name];
    content.body = [NSString localizedUserNotificationStringForKey:body
            arguments:nil];
    NSData *dealData = [NSKeyedArchiver archivedDataWithRootObject:deal requiringSecureCoding:YES error:nil];
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

@end
