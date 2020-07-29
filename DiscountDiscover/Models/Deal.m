//
//  Deal.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "Deal.h"
#import "LocationManager.h"

@implementation Deal

- (id)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];

    NSDictionary *deal = dictionary[@"deal"];
    self.name = deal[@"title"];
    self.dealDescription = deal[@"description"];
    self.finePrint = deal[@"fine_print"];
    self.url = [NSURL URLWithString:deal[@"url"]];
    self.category = deal[@"category_name"];
    self.imageUrl = [NSURL URLWithString:deal[@"image_url"]];
    self.expiresAt = [self formatExpiresAtString:deal];
    
    NSDictionary *store = deal[@"merchant"];
    self.storeName = store[@"name"];
    self.storeAddress = [self formatStoreAddressString:store];
    double latitude = [store[@"latitude"] doubleValue];
    double longitude = [store[@"longitude"] doubleValue];
    CLLocation *storeLocation = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    self.storeCoordinate = storeLocation.coordinate;
    
    CLLocation *currentLocation = [LocationManager sharedLocationManager].currentLocation;
    CLLocationDistance distance = [currentLocation distanceFromLocation:storeLocation];
    // convert from meters to miles
    self.distance = [NSString stringWithFormat:@"%.1f mi", distance / 1609.344];

    return self;
}

- (NSString *)formatExpiresAtString:(NSDictionary *)dictionary {
    
    NSString *expiresAtOriginalString = dictionary[@"expires_at"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // configure the input format to parse the date string
    formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    // convert String to Date
    NSDate *date = [formatter dateFromString:expiresAtOriginalString];
    // configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterShortStyle;
    // convert Date to String
    NSString *expiresAtString = [formatter stringFromDate:date];
    if (expiresAtString == nil) {
        expiresAtString = @"N/A";
    }
    return [@"Expires: " stringByAppendingString:expiresAtString];
}

- (NSString *)formatStoreAddressString:(NSDictionary *)dictionary {
    if (dictionary[@"address"] && dictionary[@"locality"] && dictionary[@"region"] && dictionary[@"postal_code"]) {
        return [NSString stringWithFormat:@"%@\n%@, %@ %@", dictionary[@"address"], dictionary[@"locality"], dictionary[@"region"], dictionary[@"postal_code"]];
    } else if (dictionary[@"address"] && dictionary[@"locality"] && dictionary[@"region"]) {
        return [NSString stringWithFormat:@"%@\n%@, %@", dictionary[@"address"], dictionary[@"locality"], dictionary[@"region"]];
    } else {
        return @"N/A";
    }
}

+ (NSArray<Deal *> *)dealsWithDictionaries:(NSArray<NSDictionary *> *)dictionaries {
    
    NSMutableArray<Deal *> *deals = [NSMutableArray<Deal *> array];
    for (NSDictionary *dictionary in dictionaries) {
        Deal *deal = [[Deal alloc] initWithDictionary:dictionary];
        [deals addObject:deal];
    }
    return deals;
}

@end
