//
//  DGUtilits.m
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DGUtilits.h"

@import Foundation;

id nvl(id obj1, id obj2) {
    if (obj1 == nil || [obj1 isKindOfClass:[NSNull class]]) {
        return obj2;
    }
    return obj1;
}