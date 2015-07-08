//
//  DGItemViewCell.h
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DGModelItem;

@interface DGItemViewCell : UITableViewCell

@property (nonatomic,strong) DGModelItem *item;

@end
