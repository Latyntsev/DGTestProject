//
//  DGDetailsViewController.h
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import "DGViewController.h"
@class DGModelItem;
@class DGCircleImageView;

@interface DGDetailsViewController : DGViewController

@property (nonatomic,strong) DGModelItem *masterObject;

@property (nonatomic,strong) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic,strong) IBOutlet DGCircleImageView *iconImageView;

@property (nonatomic,strong) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBannerHeightConstraint;

@end
