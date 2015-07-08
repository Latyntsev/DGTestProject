//
//  DGApplicationManager.h
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGDataAccessLayer.h"

@interface DGApplicationManager : NSObject

@property (nonatomic,strong,readonly) DGDataAccessLayer *dataAccesLayer;

- (instancetype)initWithDataAccessLayer:(DGDataAccessLayer *)dataAccesLayer;

@end
