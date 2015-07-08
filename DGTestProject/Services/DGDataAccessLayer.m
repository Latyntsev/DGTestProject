//
//  DGDataAccessLayer.m
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import "DGDataAccessLayer.h"
#import "DGWebService.h"
#import "DGUtilits.h"
#import "DGModelItem.h"

@import UIKit;

@interface DGSimpleCacheItem : NSObject

@property (nonatomic,strong) NSString *key;
@property (nonatomic,strong) id value;
@property (nonatomic,strong) NSMutableArray *operations;

@end


@implementation DGSimpleCacheItem

- (NSMutableArray *)operations {
    
    if (!_operations) {
        _operations = [[NSMutableArray alloc] init];
    }
    return _operations;
}

@end



@interface DGDataAccessLayer ()

@property (nonatomic,strong) DGWebService *webService;
@property (nonatomic,strong) NSOperationQueue *queue;
@property (nonatomic,strong) NSMutableDictionary *simpleFileCache;

@end

@implementation DGDataAccessLayer

- (instancetype)initWithWebService:(DGWebService *)webService {
    NSAssert(webService, @"Web Service is required");
    
    self = [super init];
    if (self) {
        self.webService = webService;
        self.queue = [[NSOperationQueue alloc] init];
        self.queue.maxConcurrentOperationCount = 2;
    }
    
    return self;
}

- (NSArray *)parseJSONArray:(NSData *)data error:(NSError **)error {
    if (!data) {
        return nil;
    }
    id rawData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
    if (*error) {
        return nil;
    }
    
    if (![rawData isKindOfClass:[NSArray class]]) {
        *error = [NSError errorWithDomain:@"DataAccessLayer.parseJSONArray" code:0 userInfo:@{NSLocalizedDescriptionKey:@"incorrect type"}];
        return nil;
    }
    
    return rawData;
}

- (void)getItemsListWithComplitionBlock:(DGGListOfItemsComplitionBlock)complitionBlock {
    
    WEAK(self);
    typeof(complitionBlock) theComplitionBlock = [complitionBlock copy];
    [self.webService getItemsListWithComplitionBlock:^(NSData *data, NSError *error, NSURLRequest *request, NSURLResponse *response) {
        [wself.queue addOperationWithBlock:^{
            NSArray *list = nil;
            NSArray *rawData = nil;
            NSError *theError = error;
            if (!theError) {
                theError = nil;
                rawData = [wself parseJSONArray:data error:&theError];
            }
            
            if (!theError && rawData) {
                
                NSMutableSet *set = [NSMutableSet set];
                for (NSDictionary *rawItem in rawData) {
                    DGModelItem *item = [[DGModelItem alloc] init];
                    [item fillObjectWithDictionary:rawItem];
                    if (item) {
                        [set addObject:item];
                    }
                }
                NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"fullName" ascending:YES];
                list = [set.allObjects sortedArrayUsingDescriptors:@[descriptor]];
            }
            theComplitionBlock(list, theError);
        }];
    }];
    
}

- (void)downloadFileWithLink:(NSString *)link withComplitionBlock:(DGDownloadFileComplitionBlock)complitionBlock {
    
    WEAK(self);
    typeof(complitionBlock) theComplitionBlock = [complitionBlock copy];
    
    if (!self.simpleFileCache) {
        self.simpleFileCache = [NSMutableDictionary dictionary];
    }
    DGSimpleCacheItem *cacheItem = self.simpleFileCache[link];
    if (!cacheItem) {
        cacheItem = [[DGSimpleCacheItem alloc] init];
        cacheItem.key = link;
        [self.simpleFileCache setValue:cacheItem forKey:link];
    }
    
    if (cacheItem.value) {
        theComplitionBlock(cacheItem.value, YES, nil);
        return;
    }
    
    [cacheItem.operations addObject:theComplitionBlock];
    if (cacheItem.operations.count == 1) {
        [self.queue addOperationWithBlock:^{
            
            [wself.webService downloadFileWithLink:link withComplitionBlock:^(NSData *data, NSError *error, NSURLRequest *request, NSURLResponse *response) {
                
                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                    
                    if (!error) {
                        cacheItem.value = data;
                    }
                    
                    while (cacheItem.operations.count > 0) {
                        typeof(complitionBlock) operation = cacheItem.operations[0];
                        operation(data, NO, error);
                        [cacheItem.operations removeObjectAtIndex:0];
                    }
                }];
                
            }];
        }];
    }
}


- (void)downloadImageWithLink:(NSString *)link withComplitionBlock:(DGDownloadImageComplitionBlock)complitionBlock {
    [self downloadFileWithLink:link withComplitionBlock:^(NSData *data, BOOL isCache, NSError *error) {
        UIImage *image = [UIImage imageWithData:data scale:[UIScreen mainScreen].scale];
        complitionBlock(image, isCache, error);
    }];
}


@end
