//
//  DGUtilits.h
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#ifndef DGTestProject_DGUtilits_h
#define DGTestProject_DGUtilits_h

#define WEAK(object) __weak typeof(object) w##object = object
id nvl(id obj1, id obj2);

#endif
