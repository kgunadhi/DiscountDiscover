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
    _deal = deal;

    self.nameLabel.text = self.deal.name;
    self.storeLabel.text = self.deal.storeName;
    
    [self.nameLabel sizeToFit];
    [self.storeLabel sizeToFit];
    
    self.dealImageView.image = nil;
    if (self.deal.imageUrl != nil) {
        [self.dealImageView setImageWithURL:self.deal.imageUrl];
    }
    
    [self cardStyling];
}

- (void)cardStyling {
    self.contentView.layer.cornerRadius = 7;
    self.contentView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.contentView.layer.borderWidth = 1.0f;
    self.contentView.layer.borderColor = [UIColor clearColor].CGColor;
    self.contentView.layer.masksToBounds = YES;
    
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 2.0f);
    self.layer.shadowRadius = 2.0f;
    self.layer.shadowOpacity = 0.5f;
    self.layer.masksToBounds = NO;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.contentView.layer.cornerRadius].CGPath;
}

@end
