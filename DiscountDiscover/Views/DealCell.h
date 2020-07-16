//
//  DealCell.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deal.h"

NS_ASSUME_NONNULL_BEGIN

@interface DealCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *dealImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (nonatomic, strong) Deal *deal;

@end

NS_ASSUME_NONNULL_END
