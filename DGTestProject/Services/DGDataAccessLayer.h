//
//  DGDataAccessLayer.h
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DGWebService;
@class UIImage;

@interface DGDataAccessLayer : NSObject

typedef void(^DGGListOfItemsComplitionBlock)(NSArray *data, NSError *error);
typedef void(^DGDownloadFileComplitionBlock)(NSData *data, BOOL isCache,  NSError *error);
typedef void(^DGDownloadImageComplitionBlock)(UIImage *image, BOOL isCache,  NSError *error);

- (instancetype)initWithWebService:(DGWebService *)webService;

- (void)getItemsListWithComplitionBlock:(DGGListOfItemsComplitionBlock)complitionBlock;
- (void)downloadImageWithLink:(NSString *)link withComplitionBlock:(DGDownloadImageComplitionBlock)complitionBlock;


@end
