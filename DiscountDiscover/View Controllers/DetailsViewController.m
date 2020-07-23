//
//  DetailsViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/17/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "WebViewController.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *dealImageView;
@property (weak, nonatomic) IBOutlet UILabel *storeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *expiresLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *finePrintLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.storeLabel.text = self.deal.storeName;
    self.nameLabel.text = self.deal.name;
    self.categoryLabel.text = self.deal.category;
    self.expiresLabel.text = self.deal.expiresAt;
    self.descriptionLabel.text = self.deal.dealDescription;
    self.finePrintLabel.text = self.deal.finePrint;
    self.addressLabel.text = self.deal.storeAddress;
    
    if (self.deal.imageUrl != nil) {
        [self.dealImageView setImageWithURL:self.deal.imageUrl];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewController *webViewController = [segue destinationViewController];
    webViewController.url = self.deal.url;
}

@end
