//
//  DGCircleImageView.m
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import "DGCircleImageView.h"

@implementation DGCircleImageView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        CAShapeLayer *mask = [CAShapeLayer layer];
        mask.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
        self.layer.mask = mask;
    }
    
    return self;
}

@dynamic borderLayerColor;
@dynamic borderLayerWidth;

- (CAShapeLayer *)borderLayer {
    if (!_borderLayer) {
        _borderLayer = [CAShapeLayer layer];
        _borderLayer.fillColor = NULL;
        _borderLayer.rasterizationScale = 2.0 * [UIScreen mainScreen].scale;
        _borderLayer.shouldRasterize = YES;
    }
    
    return _borderLayer;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
    self.borderLayer.frame = self.frame;
    self.borderLayer.path = [UIBezierPath bezierPathWithOvalInRect:self.bounds].CGPath;
    [self.layer addSublayer:self.borderLayer];
}

- (CGColorRef)borderLayerColor {
    return self.borderLayer.strokeColor;
}

- (void)setBorderLayerColor:(CGColorRef)borderLayerColor {
    self.borderLayer.strokeColor = borderLayerColor;
}

- (CGFloat)borderLayerWidth {
    return self.borderLayer.lineWidth;
}

- (void)setBorderLayerWidth:(CGFloat)borderLayerWidth {
    self.borderLayer.frame = (CGRect){0,0,CGRectInset(self.bounds, borderLayerWidth, borderLayerWidth).size};
    self.borderLayer.lineWidth = borderLayerWidth;
}

@end
