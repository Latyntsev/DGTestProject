//
//  AppDelegate.h
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DGApplicationManager;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,strong,readonly) DGApplicationManager *applicationManager;

@end

