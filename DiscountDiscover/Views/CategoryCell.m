//
//  CategoryCell.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 8/6/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (void)setCategory:(Category *)category {
    _category = category;
    
    self.nameLabel.text = self.category.name;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        self.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
