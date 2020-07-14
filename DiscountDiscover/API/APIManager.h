//
//  APIManager.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APIManager : NSObject

- (void)fetchDeals:(void(^)(NSArray *deals, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
