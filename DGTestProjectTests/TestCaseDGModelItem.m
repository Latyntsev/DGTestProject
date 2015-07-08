//
//  TestCaseDGModelItem.m
//  DGTestProject
//
//  Created by Oleksandr Latyntsev on 7/8/15.
//  Copyright (c) 2015 DGTestProject. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DGModelItem.h"

@interface TestCaseDGModelItem : XCTestCase

@property (nonatomic,strong) DGModelItem *instance;

@end

@implementation TestCaseDGModelItem

- (void)setUp {
    [super setUp];
    self.instance = [[DGModelItem alloc] init];
}

- (void)test_fillObjectWithDictionary {
    
    NSDictionary *data = @{
      @"address": @"595 Wythe Place, Disautel, Oklahoma, 9646",
      @"phone": @"+1 (897) 501-2275",
      @"email": @"lolita.farley@printspan.ca",
      @"company": @"PRINTSPAN",
      @"age": @31,
      @"color": @"green",
      @"price": @40,
      @"title": @"Cupidatat tempor veniam quis esse irure dolor proident aliqua adipisicing consectetur nisi in eiusmod aliqua. Sunt ex mollit velit consequat. Labore pariatur enim consequat proident cupidatat ut. Sunt exercitation excepteur mollit consequat. Mollit qui deserunt qui consequat veniam officia est eu sit excepteur. Et aliqua dolor cillum occaecat enim culpa culpa exercitation id tempor enim velit ex nostrud.\r\n",
      @"name": @{
              @"last": @"Farley",
              @"first": @"Lolita"
              },
      @"image2_url": @"http://lorempixel.com/output/transport-q-c-150-100-1.jpg",
      @"image1_url": @"http://lorempixel.com/output/transport-q-c-150-80-3.jpg",
      @"isActive": @false,
      @"index": @2,
      @"_id": @"5594ec225f4b39ac0e53ea42"
      };
    
    [self.instance fillObjectWithDictionary:nil];
    [self.instance fillObjectWithDictionary:(id)@[]];
    [self.instance fillObjectWithDictionary:(id)[NSNull null]];
    [self.instance fillObjectWithDictionary:@{}];
    
    [self.instance fillObjectWithDictionary:data];
    
    XCTAssertEqualObjects(self.instance.identifier, data[@"_id"]);
    XCTAssertEqual(self.instance.index, [data[@"index"] integerValue]);
    XCTAssertEqual(self.instance.isActive, [data[@"isActive"] boolValue]);
    XCTAssertEqualObjects(self.instance.firstName, data[@"name"][@"first"]);
    XCTAssertEqualObjects(self.instance.lastName, data[@"name"][@"last"]);
    XCTAssertEqualObjects(self.instance.age, data[@"age"]);
    XCTAssertEqualObjects(self.instance.image1URL, data[@"image1_url"]);
    XCTAssertEqualObjects(self.instance.image2URL, data[@"image2_url"]);
    XCTAssertEqualObjects(self.instance.title, data[@"title"]);
    XCTAssertEqualObjects(self.instance.phone, data[@"phone"]);
    XCTAssertEqualObjects(self.instance.email, data[@"email"]);
    XCTAssertEqualObjects(self.instance.address, data[@"address"]);
    XCTAssertEqualObjects(self.instance.company, data[@"company"]);
    XCTAssertEqualObjects(self.instance.color, data[@"color"]);
    XCTAssertEqualObjects(self.instance.price, [NSDecimalNumber decimalNumberWithDecimal:[data[@"price"] decimalValue]]);
    
}

- (void)test_fullName {
    
    XCTAssertEqualObjects([self.instance fullName], @"");
    
    [self.instance fillObjectWithDictionary:@{@"name": @{@"first":@"Lolita", @"last":@"Farley"}}];
    XCTAssertEqualObjects([self.instance fullName], @"Lolita Farley");
    
    [self.instance fillObjectWithDictionary:@{@"name": @{@"first":@" Lolita", @"last":@"Farley "}}];
    XCTAssertEqualObjects([self.instance fullName], @"Lolita Farley");
    
    [self.instance fillObjectWithDictionary:@{@"name": @{@"first":@" Lolita"}}];
    XCTAssertEqualObjects([self.instance fullName], @"Lolita");
    
    [self.instance fillObjectWithDictionary:@{@"name": @{@"last":@" Farley "}}];
    XCTAssertEqualObjects([self.instance fullName], @"Farley");
}

- (void)test_isEqual {
    DGModelItem *instance1 = [[DGModelItem alloc] init];
    
    DGModelItem *instance2 = [[DGModelItem alloc] init];
    
    
    XCTAssertEqualObjects(instance1, instance2);
    
    [instance2 fillObjectWithDictionary:@{@"company": @"PRINTSPAN",}];
    XCTAssertNotEqualObjects(instance1, instance2);
    
    [instance1 fillObjectWithDictionary:@{@"company": @"PRINTSPAN",@"isActive": @true}];
    XCTAssertNotEqualObjects(instance1, instance2);
    
    [instance2 fillObjectWithDictionary:@{@"company": @"PRINTSPAN",@"isActive": @true}];
    XCTAssertEqualObjects(instance1, instance2);
}


@end
