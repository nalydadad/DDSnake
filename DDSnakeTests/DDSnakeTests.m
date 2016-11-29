//
//  DDSnakeTests.m
//  DDSnakeTests
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DDPoint.h"

@interface DDSnakeTests : XCTestCase

@end

@implementation DDSnakeTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testDDCPoint
{
    DDCPoint p = {
        .x = 1,
        .y = 2
    };
    NSValue *value = [NSValue valueWithDDCPoint:p];
    DDCPoint v = value.DDCPointValue;
    XCTAssertTrue(v.x == 1);
    XCTAssertTrue(v.y == 2);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
