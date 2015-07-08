//
//  DGModelItem.h
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import "DGModelObject.h"

@interface DGModelItem : DGModelObject

@property (nonatomic,strong,readonly) NSString *identifier;
@property (nonatomic,readonly) NSInteger index;
@property (nonatomic,readonly) BOOL isActive;

@property (nonatomic,strong,readonly) NSString *firstName;
@property (nonatomic,strong,readonly) NSString *lastName;
@property (nonatomic,strong,readonly) NSNumber *age;


@property (nonatomic,strong,readonly) NSString *image1URL;
@property (nonatomic,strong,readonly) NSString *image2URL;

@property (nonatomic,strong,readonly) NSString *title;
@property (nonatomic,strong,readonly) NSString *phone;
@property (nonatomic,strong,readonly) NSString *email;
@property (nonatomic,strong,readonly) NSString *address;
@property (nonatomic,strong,readonly) NSString *company;
@property (nonatomic,strong,readonly) NSString *color;
@property (nonatomic,strong,readonly) NSDecimalNumber *price;

- (void)fillObjectWithDictionary:(NSDictionary *)dictionary;

- (NSString *)fullName;

@end
