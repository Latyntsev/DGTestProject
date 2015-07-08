//
//  DGWebService.h
// DGTestProject
//
//  Created by Oleksandr Latyntsev on 5/27/15.
//  Copyright (c) 2015 Screen Interface. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SIServiceMetaData;

@interface DGWebService : NSObject

typedef void(^DGWebServiceComplitionBlock)(NSData *data, NSError *error, NSURLRequest *request, NSURLResponse *response);

- (instancetype)initWithServiceURL:(NSURL *)serviceURL;
- (void)getItemsListWithComplitionBlock:(DGWebServiceComplitionBlock)complitionBlock;
- (void)downloadFileWithLink:(NSString *)link withComplitionBlock:(DGWebServiceComplitionBlock)complitionBlock;

@end
