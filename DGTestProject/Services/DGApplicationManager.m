//
//  DGApplicationManager.m
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import "DGApplicationManager.h"

@implementation DGApplicationManager

- (instancetype)initWithDataAccessLayer:(DGDataAccessLayer *)dataAccesLayer {
    NSAssert(dataAccesLayer, @"data access layer is required");
    
    self = [super init];
    if (self) {
        _dataAccesLayer = dataAccesLayer;
    }
    
    return self;
}

@end
