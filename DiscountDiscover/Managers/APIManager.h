//
//  APIManager.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import "Deal.h"

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

- (id)init;
- (void)fetchDealsWithRadius:(double)radius numberOfDeals:(int)number completion:(void(^)(NSArray<Deal *> *deals, NSError *error))completion;
- (void)fetchNearbyDeal:(void (^)(Deal *deal, UIBackgroundFetchResult result))completionHandler;
+ (NSString *)getAPIKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
