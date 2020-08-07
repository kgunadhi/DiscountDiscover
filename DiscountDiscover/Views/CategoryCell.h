//
//  CategoryCell.h
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 8/6/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Category.h"

NS_ASSUME_NONNULL_BEGIN

@interface CategoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) Category *category;

@end

NS_ASSUME_NONNULL_END
