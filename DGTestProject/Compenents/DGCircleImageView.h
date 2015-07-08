//
//  DGCircleImageView.h
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGCircleImageView : UIImageView

@property (nonatomic,strong) CAShapeLayer *borderLayer;
@property  CGColorRef borderLayerColor;
@property  CGFloat borderLayerWidth;

@end
