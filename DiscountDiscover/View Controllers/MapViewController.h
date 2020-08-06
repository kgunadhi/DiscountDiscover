//
//  MapViewController.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/15/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deal.h"

NS_ASSUME_NONNULL_BEGIN

@interface MapViewController : UIViewController

@property (nonatomic, strong) NSArray<Deal *> *deals;

@end

NS_ASSUME_NONNULL_END
