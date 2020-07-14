//
//  DealCell.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "DealCell.h"

@implementation DealCell

- (void)setDeal:(Deal *)deal {
    // Set underlying private storage _movie since replacing default setter
    _deal = deal;

    self.nameLabel.text = self.deal.name;
}

@end
