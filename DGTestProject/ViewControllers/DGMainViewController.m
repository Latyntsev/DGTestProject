//
//  DGMainViewController.m
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import "DGMainViewController.h"
#import "DGItemViewCell.h"
#import "DGModelItem.h"
#import "DGUtilits.h"
#import "DGDetailsViewController.h"

NSString *kShowDetailsSegueIdentifier = @"ShowDetails";

@interface DGMainViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic,strong) NSArray *data;

@end

@implementation DGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WEAK(self);
    [self.applicationManager.dataAccesLayer getItemsListWithComplitionBlock:^(NSArray *data, NSError *error) {
        if (!error) {
            wself.data = data;
            [wself.tableView reloadData];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (DGModelItem *)itemWithIndexPath:(NSIndexPath *)indexPath
{
    return self.data[indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DGModelItem *item = [self itemWithIndexPath:indexPath];
    DGItemViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.item = item;
    cell.fullNameLabel.text = item.fullName;
    cell.phoneNumberLabel.text = item.phone;
    cell.companyNameLabel.text = item.company;
    cell.iconImageView.image = nil;
    [cell.activityIndicator startAnimating];
    
    [self.applicationManager.dataAccesLayer downloadImageWithLink:item.image1URL withComplitionBlock:^(UIImage *image, BOOL isCache, NSError *error) {
        if (cell.item == item) {
            [cell.activityIndicator stopAnimating];
            image = nvl(image, [UIImage imageNamed:@"default-placeholder"]);

            cell.iconImageView.image = image;
            if (!isCache) {
                cell.iconImageView.transform = CGAffineTransformMakeScale(0.1, 0.1);
                [UIView animateWithDuration:0.2 animations:^{
                    cell.iconImageView.transform = CGAffineTransformMakeScale(1, 1);
                }];
            }
            
        }
    }];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DGModelItem *item = [self itemWithIndexPath:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:kShowDetailsSegueIdentifier sender:item];
}

#pragma mark - Navigation 
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:kShowDetailsSegueIdentifier]) {
        DGDetailsViewController *vc = segue.destinationViewController;
        vc.masterObject = sender;
    }
}

@end
