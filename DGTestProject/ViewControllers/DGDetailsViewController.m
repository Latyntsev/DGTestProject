//
//  DGDetailsViewController.m
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import "DGDetailsViewController.h"
#import "DGModelItem.h"
#import "DGUtilits.h"
#import "DGCircleImageView.h"
#import "FXBlurView.h"
#import "DFKeyValueTableViewCell.h"
#import "DFLongTextTableViewCell.h"
#import "DGConfig.h"

@interface DGDetailsPresentationItem : NSObject

typedef NS_ENUM(NSInteger, DGDetailsPresentationItemTypes) {
    DGDetailsPresentationItemTypes_keyValue,
    DGDetailsPresentationItemTypes_longText
};

@property (nonatomic) DGDetailsPresentationItemTypes presentationType;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *data;

@end

@implementation DGDetailsPresentationItem

+ (instancetype)itemKay:(NSString *)key value:(NSString *)value {
    
    DGDetailsPresentationItem *instance = [[self alloc] init];
    instance.presentationType = DGDetailsPresentationItemTypes_keyValue;
    instance.name = key;
    instance.data = value;
    return instance;
}

+ (instancetype)itemLongTextName:(NSString *)key value:(NSString *)value {
    
    DGDetailsPresentationItem *instance = [[self alloc] init];
    instance.presentationType = DGDetailsPresentationItemTypes_longText;
    instance.name = key;
    instance.data = value;
    return instance;
}

@end







@interface DGDetailsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) NSArray *data;

@end

@implementation DGDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.iconImageView.borderLayerColor = [[UIColor whiteColor] CGColor];
    self.iconImageView.borderLayerWidth = 4;
    self.tableView.contentInset = UIEdgeInsetsMake(kDeteilsScreenTopBannerHeight - 64, 0, 0, 0);
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    self.iconImageView.image = [UIImage imageNamed:@"default-placeholder"];
    self.backgroundImageView.image = [[UIImage imageNamed:@"default-placeholder2"] blurredImageWithRadius:10 iterations:3 tintColor:nil];
    
    [self.applicationManager.dataAccesLayer downloadImageWithLink:self.masterObject.image1URL withComplitionBlock:^(UIImage *image, BOOL isCache, NSError *error) {
        if (image) {
            self.iconImageView.image = image;
            self.backgroundImageView.image = [image blurredImageWithRadius:5 iterations:3 tintColor:nil];
        }
    }];
    
    
}

- (void)setMasterObject:(DGModelItem *)masterObject {
    _masterObject = masterObject;
    
    NSMutableArray *data = [NSMutableArray array];
    if (self.masterObject.fullName.length > 0) {
        [data addObject:[DGDetailsPresentationItem itemKay:@"Name:" value:self.masterObject.fullName]];
    }
    
    if (self.masterObject.phone.length > 0) {
        [data addObject:[DGDetailsPresentationItem itemKay:@"Phone:" value:self.masterObject.phone]];
    }
    
    if (self.masterObject.email.length > 0) {
        [data addObject:[DGDetailsPresentationItem itemKay:@"E-Mail:" value:self.masterObject.email]];
    }
    
    if (self.masterObject.address.length > 0) {
        [data addObject:[DGDetailsPresentationItem itemKay:@"Address:" value:self.masterObject.address]];
    }
    
    if (self.masterObject.company.length > 0) {
        [data addObject:[DGDetailsPresentationItem itemKay:@"Phone:" value:self.masterObject.company]];
    }
    
    if (self.masterObject.age.integerValue > 0) {
        [data addObject:[DGDetailsPresentationItem itemKay:@"Age:" value:self.masterObject.age.description]];
    }
    
    if (self.masterObject.title.length > 0) {
        [data addObject:[DGDetailsPresentationItem itemLongTextName:@"Title:" value:self.masterObject.title]];
    }
    
    
    self.data = data;
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (DGDetailsPresentationItem *)itemWithIndexPath:(NSIndexPath *)indexPath
{
    return self.data[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DGDetailsPresentationItem *item = [self itemWithIndexPath:indexPath];
    UITableViewCell *theCell = nil;
    switch (item.presentationType) {
        case DGDetailsPresentationItemTypes_keyValue: {
            DFKeyValueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFKeyValueTableViewCell" forIndexPath:indexPath];
            
            cell.keyLabel.text = item.name;
            cell.keyLabel.textColor = self.view.tintColor;
            cell.valueLabel.text = item.data;
            
            theCell = cell;
            break;
        }
        case DGDetailsPresentationItemTypes_longText: {
            DFLongTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFLongTextTableViewCell" forIndexPath:indexPath];
            
            cell.keyLabel.text = item.name;
            cell.keyLabel.textColor = self.view.tintColor;
            cell.valueLabel.text = item.data;
            
            theCell = cell;
            break;
        }
    }
    
 
    return theCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DGDetailsPresentationItem *item = [self itemWithIndexPath:indexPath];
    
    CGFloat height = [tableView rowHeight];
    switch (item.presentationType) {
            
        case DGDetailsPresentationItemTypes_longText: {
            DFLongTextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DFLongTextTableViewCell"];
            
            cell.keyLabel.text = item.name;
            cell.keyLabel.textColor = self.view.tintColor;
            cell.valueLabel.text = item.data;
            
            CGSize size = [cell.contentView systemLayoutSizeFittingSize:(CGSize){tableView.frame.size.width,10}];
            
            height = size.height;
            break;
        }
            
        default: {
            break;
        }
    }
    
    return height + 1;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = 64;
    CGFloat value = y - scrollView.contentOffset.y;
    value = MAX(value,y);
    self.topBannerHeightConstraint.constant = value;
    
    CGFloat scale = value - y;
    scale/= (kDeteilsScreenTopBannerHeight - y);
    
    scale = MIN(1,scale);
    self.iconImageView.transform = CGAffineTransformMakeScale(scale, scale);
    
    self.iconImageView.alpha = scale;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
