//
//  DealNotificationsManager.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 8/6/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deal.h"

NS_ASSUME_NONNULL_BEGIN

@interface DealNotificationsManager : NSObject

+ (void)scheduleNotification:(Deal *)deal;

@end

NS_ASSUME_NONNULL_END
