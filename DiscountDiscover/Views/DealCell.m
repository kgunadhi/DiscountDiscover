//
//  DealCell.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "DealCell.h"
#import "UIImageView+AFNetworking.h"

@implementation DealCell

- (void)setDeal:(Deal *)deal {
    // Set underlying private storage _movie since replacing default setter
    _deal = deal;

    self.nameLabel.text = self.deal.name;
    self.storeLabel.text = self.deal.storeName;
    // self.distanceLabel.text = calculate distance;
    
    self.dealImageView.image = nil;
    if (self.deal.imageUrl != nil) {
        [self.dealImageView setImageWithURL:self.deal.imageUrl];
    }
    
    self.layer.cornerRadius = 7;
    self.layer.masksToBounds = YES;
}

@end
