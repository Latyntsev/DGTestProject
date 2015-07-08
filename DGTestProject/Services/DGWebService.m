//
//  DGWebService.m
// DGTestProject
//
//  Created by Oleksandr Latyntsev on 5/27/15.
//  Copyright (c) 2015 Screen Interface. All rights reserved.
//

#import "DGWebService.h"

@interface DGWebService ()

@property (nonatomic,strong) NSURL *serviceURL;

@end

@implementation DGWebService

- (instancetype)initWithServiceURL:(NSURL *)serviceURL {
    NSAssert(serviceURL, @"Service URL is required");
    self = [super init];
    if (self) {
        self.serviceURL = serviceURL;
    }
    return self;
}

- (NSString *)parametresToString:(NSDictionary *)parametres {
    if (!parametres) {
        parametres = @{};
    }
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSString *key in parametres.allKeys) {
        id value = parametres[key];
        value = [value description];
        if ([value description].length == 0) {
            continue;
        }
        NSString *name = [key stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        value = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLHostAllowedCharacterSet]];
        NSString *pair = [NSString stringWithFormat:@"%@=%@",name,value];
        
        [mutableArray addObject:pair];
    }
    NSString *result = [mutableArray componentsJoinedByString:@"&"];
    
    return result;
}

- (NSURL *)serviceURLForResourcePath:(NSString *)resourcePath {
    if (resourcePath.length == 0) {
        return self.serviceURL;
    }
    return [self.serviceURL URLByAppendingPathComponent:resourcePath];
}

- (NSURL *)addQueryParametres:(NSDictionary *)parametres toURL:(NSURL *)url {
    NSAssert(url, @"URL is required");
    NSString *parametresString = [self parametresToString:parametres];
    if (parametresString.length == 0) {
        return url;
    }
    NSString *stringURL = url.absoluteString;
    if ([stringURL rangeOfString:@"?"].length > 0) {
        if ([stringURL hasSuffix:@"?"]) {
            stringURL = [stringURL stringByAppendingFormat:@"%@",parametresString];
        } else {
            stringURL = [stringURL stringByAppendingFormat:@"&%@",parametresString];
        }
    } else {
        stringURL = [stringURL stringByAppendingFormat:@"?%@",parametresString];
    }
    return [NSURL URLWithString:stringURL];
}

- (NSMutableURLRequest *)requestResource:(NSString *)resource {
    return [self requestResource:resource withParametres:nil];
}

- (NSMutableURLRequest *)requestResource:(NSString *)resource withParametres:(NSDictionary *)parametres {
    NSURL *url = [self serviceURLForResourcePath:resource];
    url = [self addQueryParametres:parametres toURL:url];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    
    return request;
}

- (void)executeRequest:(NSURLRequest *)request complitionBlock:(DGWebServiceComplitionBlock)complitionBlock {
    
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (complitionBlock) {
        complitionBlock(data, error, request, response);
    }
}

- (void)getItemsListWithComplitionBlock:(DGWebServiceComplitionBlock)complitionBlock {
    
    NSString *path = [NSString stringWithFormat:@"/api/json/get/A8AsVoh"];
    NSMutableURLRequest *request = [self requestResource:path];
    [self executeRequest:request complitionBlock:complitionBlock];
}

- (void)downloadFileWithLink:(NSString *)link withComplitionBlock:(DGWebServiceComplitionBlock)complitionBlock {
    
    NSAssert(link, @"link is required");
    NSURL *url = [NSURL URLWithString:link];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [self executeRequest:request complitionBlock:complitionBlock];
}

@end
