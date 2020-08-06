//
//  Deal.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Deal : NSObject <NSCoding, NSSecureCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *dealDescription;
@property (nonatomic, strong) NSString *finePrint;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *distance;
@property (nonatomic, strong) NSURL *imageUrl;
@property (nonatomic, strong) NSString *expiresAt;
@property (nonatomic, strong) NSString *storeName;
@property (nonatomic, strong) NSString *storeAddress;
@property (nonatomic) CLLocationCoordinate2D storeCoordinate;


- (id)initWithDictionary:(NSDictionary *)dictionary;
+ (NSArray<Deal *> *)dealsWithDictionaries:(NSArray<NSDictionary *> *)dictionaries;

@end

NS_ASSUME_NONNULL_END
