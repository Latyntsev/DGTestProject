//
//  DGItemViewCell.m
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import "DGItemViewCell.h"
#import "DGModelItem.h"
#import "DGCircleImageView.h"

@implementation DGItemViewCell

- (void)awakeFromNib {
    ((DGCircleImageView *)self.iconImageView).borderLayerWidth = 4;
    ((DGCircleImageView *)self.iconImageView).borderLayerColor = [[UIColor whiteColor] CGColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
