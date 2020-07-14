//
//  DealsViewController.m
//  DiscountDiscover
//
//  Created by Kaitlyn Gunadhi on 7/13/20.
//  Copyright © 2020 Kaitlyn Gunadhi. All rights reserved.
//

#import "DealsViewController.h"
#import "DealCell.h"
#import "APIManager.h"

@interface DealsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *deals;

@end

@implementation DealsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self fetchDeals];
}

- (void)viewDidLayoutSubviews {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    const int sectionInsets = 20;
    
    const CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing - sectionInsets) / 2;
    const CGFloat itemHeight = itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)fetchDeals {
//    [self.activityIndicator startAnimating];
    __weak DealsViewController *weakSelf = self;
    APIManager *manager = [APIManager new];
    [manager fetchDeals:^(NSArray *deals, NSError *error) {
        if (error != nil) {
            UIAlertController *networkAlert = [UIAlertController alertControllerWithTitle:@"Cannot Get Movies" message:@"The Internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *reloadAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf fetchDeals];
            }];
            [networkAlert addAction:reloadAction];
            [self presentViewController:networkAlert animated:YES completion:^{}];
        }
        else {
            self.deals = deals;
            NSLog(@"Success");
            [self.collectionView reloadData];
        }
//        [self.activityIndicator stopAnimating];
//        [self.refreshControl endRefreshing];
    }];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DealCell" forIndexPath:indexPath];
    
    cell.deal = self.deals[indexPath.item];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.deals.count;
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
