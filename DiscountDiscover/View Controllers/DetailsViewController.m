//
//  DetailsViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/17/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *dealImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.storeLabel.text = self.deal.storeName;
    self.nameLabel.text = self.deal.name;
    
    if (self.deal.imageUrl != nil) {
        [self.dealImageView setImageWithURL:self.deal.imageUrl];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
