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
#import "DetailsViewController.h"
#import "ActionSheetPicker.h"

@interface DealsViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<Deal *> *deals;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIButton *distanceButton;
@property (nonatomic) double radius;
@property (nonatomic) int selectedIndex;

@end

@implementation DealsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    // distance filter
    self.distanceButton.layer.cornerRadius = 15;
    self.distanceButton.layer.borderWidth = 1.0f;
    self.distanceButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.radius = 5;
    self.selectedIndex = 3;
    
    [self fetchDeals];
    
    // add refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchDeals) forControlEvents:UIControlEventValueChanged];
    [self.collectionView insertSubview:self.refreshControl atIndex:0];
}

- (void)viewDidLayoutSubviews {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    const int sectionInsets = 20;
    const int dealsPerLine = 2;
    
    const CGFloat itemWidth = (self.collectionView.frame.size.width - layout.minimumInteritemSpacing - sectionInsets) / dealsPerLine;
    const CGFloat itemHeight = itemWidth * 1.5;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
}

- (void)fetchDeals {
    APIManager *manager = [[APIManager alloc] initWithParameters:self.radius];
    __weak typeof(self) weakSelf = self;
    [manager fetchDeals:^(NSArray<Deal *> *deals, NSError *error) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            if (error != nil) {
                [strongSelf showNetworkErrorAlert];
            }
            else {
                strongSelf.deals = deals;
                [strongSelf.collectionView reloadData];
            }
            [strongSelf.refreshControl endRefreshing];
        }
    }];
}

- (void)showNetworkErrorAlert {
    UIAlertController *networkAlert = [UIAlertController alertControllerWithTitle:@"Cannot Get Deals" message:@"The Internet connection appears to be offline." preferredStyle:(UIAlertControllerStyleAlert)];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction *reloadAction = [UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf fetchDeals];
    }];
    [networkAlert addAction:reloadAction];
    
    [self presentViewController:networkAlert animated:YES completion:^{}];
}

- (IBAction)filterDistance:(id)sender {
    NSArray<NSNumber *> *const distances = @[@(0.5), @(1), @(2), @(5), @(10), @(20)];

    __weak typeof(self) weakSelf = self;
    ActionStringDoneBlock done = ^(ActionSheetStringPicker *picker, NSInteger selectedIndex, id selectedValue) {
        __strong typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            strongSelf.radius = [selectedValue doubleValue];
            strongSelf.selectedIndex = selectedIndex;
            [strongSelf fetchDeals];
        }
    };
    ActionStringCancelBlock cancel = ^(ActionSheetStringPicker *picker) {};
    
    [ActionSheetStringPicker showPickerWithTitle:@"Distance" rows:distances initialSelection:self.selectedIndex doneBlock:done cancelBlock:cancel origin:sender];
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    DealCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DealCell" forIndexPath:indexPath];
    
    cell.deal = self.deals[indexPath.item];
    
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.deals.count;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    // Details view segue
    UICollectionViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
    Deal *deal = self.deals[indexPath.row];
    
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.deal = deal;
}

@end
