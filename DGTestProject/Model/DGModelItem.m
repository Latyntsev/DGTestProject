//
//  DGModelItem.m
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import "DGModelItem.h"
#import "DGUtilits.h"

@implementation DGModelItem

- (void)fillObjectWithDictionary:(NSDictionary *)dictionary {
    
    if (![dictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    NSNumber *priceNumber = nvl(dictionary[@"price"],@0);
    
    NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithDecimal:priceNumber.decimalValue];
    
    
    NSDictionary *name = nvl(dictionary[@"name"],@{});
    
    _identifier = nvl(dictionary[@"_id"],nil);
    _index = [nvl(dictionary[@"index"],@0) integerValue];
    _isActive = [nvl(dictionary[@"isActive"],@NO) boolValue];
    _firstName = nvl(name[@"first"],nil);
    _lastName = nvl(name[@"last"],nil);
    _age = nvl(dictionary[@"age"],@0);
    _image1URL = nvl(dictionary[@"image1_url"],nil);
    _image2URL = nvl(dictionary[@"image2_url"],nil);
    _title = nvl(dictionary[@"title"],nil);
    _phone = nvl(dictionary[@"phone"],nil);
    _email = nvl(dictionary[@"email"],nil);
    _address = nvl(dictionary[@"address"],nil);
    _company = nvl(dictionary[@"company"],nil);
    _color = nvl(dictionary[@"color"],nil);
    _price = price;
}

- (NSString *)fullName {
    
    return [[NSString stringWithFormat:@"%@ %@",nvl(self.firstName,@""),nvl(self.lastName,@"")] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (BOOL)isEqual:(DGModelItem *)object {
    if ([object isKindOfClass:[DGModelItem class]]) {
        
        NSArray *allKeys = @[@"identifier",@"identifier",@"index",
                             @"isActive",@"firstName",@"lastName",@"age",
                             @"image1URL",@"image2URL",@"title",@"phone",
                             @"email",@"address",@"company",@"color",@"price",@"isActive"];
        
        for (NSString *key in allKeys) {
            id object1 = [self valueForKey:key];
            id object2 = [object valueForKey:key];
            
            if (object1 == object2 || [object1 isEqual:object2]) {
                continue;
            }
            return NO;
        }
        
        return YES;
    }
    return NO;
}

@end


