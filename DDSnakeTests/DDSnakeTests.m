//
//  DDSnakeTests.m
//  DDSnakeTests
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "DDPoint.h"
#import "NSMutableArray+QueueAdditions.h"
#import "DDSnake.h"
#import "DDConstants.h"


@interface NSMutableArrayCategoryTest : XCTestCase

@end

@implementation NSMutableArrayCategoryTest

- (void)testNSMutableArrayDequeue
{
    NSMutableArray * bodyQueue = [[NSMutableArray alloc]init];
    [bodyQueue addObject:@"1"];
    XCTAssertTrue([[bodyQueue dequeue] isEqualToString:@"1"]);
    XCTAssertTrue([bodyQueue count] == 0);
}

- (void)testNSMutableArrayEnqueue
{
    NSMutableArray * bodyQueue = [[NSMutableArray alloc]init];
    [bodyQueue enqueue:@"1"];
    XCTAssertTrue([bodyQueue[0] isEqualToString:@"1"]);
    XCTAssertTrue([bodyQueue count] == 1);
}

@end

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

#pragma - mark Test Data Structure [DDCPoint, NSMutableArray]

- (void)testDDCPointInit
{
    DDCPoint p = {.x = 1, .y = 2};
    NSValue *value = [NSValue valueWithDDCPoint:p];
    DDCPoint v = value.DDCPointValue;
    XCTAssertTrue(v.x == 1);
    XCTAssertTrue(v.y == 2);
}

#pragma - mark Test Snake class

- (void) testInitialSnakeBody{
    DDSnake *snake = [[DDSnake alloc]init];
    XCTAssertTrue([snake.bodyQueue count] == 2);
    DDCPoint point = {.x=11, .y=10};
    DDCPoint snakeBody = [snake.bodyQueue[0] DDCPointValue];
    XCTAssertTrue(point.x == snakeBody.x && point.y == snakeBody.y);

    point.x -= 1;
    snakeBody = [snake.bodyQueue[1] DDCPointValue];
    XCTAssertTrue(point.x == snakeBody.x && point.y == snakeBody.y);
}

- (void) testInitialSnakeBodyWithPointAndDirection{
    DDCPoint startPoint = DDCPointMake(20, 20);
    DDSnake *snake = [[DDSnake alloc]initWithPoint:startPoint Direction:DDDirectionRight];
    XCTAssertTrue([snake.bodyQueue count] == 2);
    DDCPoint snakeBody = [snake.bodyQueue[0] DDCPointValue];
    XCTAssertTrue(startPoint.x == snakeBody.x && startPoint.y == snakeBody.y);
    startPoint = DDCPointMake(21, 20);
    snakeBody = [snake.bodyQueue[1] DDCPointValue];
    XCTAssertTrue(startPoint.x == snakeBody.x && startPoint.y == snakeBody.y);
}

- (void) testInitialSankeDirection {
    DDSnake *snake = [[DDSnake alloc]init];
    XCTAssertTrue(snake.direction == DDDirectionLeft);
}

- (void) testGetSnakeHead {
    DDSnake *snake = [[DDSnake alloc]init];
    DDCPoint head = {.x=10, .y=10};
    DDCPoint snakeHead = snake.head;
    XCTAssertTrue(head.x == snakeHead.x && head.y == snakeHead.y);
}

- (void) testSnakeMoveLeftToLeft {
    DDSnake *snake = [[DDSnake alloc]init];
    [snake changeSnakeDirection:DDDirectionLeft];
    [snake move];
    DDCPoint tail = [snake.bodyQueue[0] DDCPointValue];
    DDCPoint head = [snake.bodyQueue[1] DDCPointValue];
    XCTAssertTrue(tail.x == 10 && tail.y == 10);
    XCTAssertTrue(head.x == 9 && head.y == 10);
}

- (void) testSnakeMoveLeftToRight {
    DDSnake *snake = [[DDSnake alloc]init];
    [snake changeSnakeDirection:DDDirectionRight];
    [snake move];
    DDCPoint tail = [snake.bodyQueue[0] DDCPointValue];
    DDCPoint head = [snake.bodyQueue[1] DDCPointValue];
    XCTAssertTrue(tail.x == 10 && tail.y == 10);
    XCTAssertTrue(head.x == 9 && head.y == 10);
}

- (void) testSnakeMoveLeftToUp {
    DDSnake *snake = [[DDSnake alloc]init];
    [snake changeSnakeDirection:DDDirectionUp];
    [snake move];
    DDCPoint tail = [snake.bodyQueue[0] DDCPointValue];
    DDCPoint head = [snake.bodyQueue[1] DDCPointValue];
    XCTAssertTrue(tail.x == 10 && tail.y == 10);
    XCTAssertTrue(head.x == 10 && head.y == 9);
}

- (void) testSnakeMoveLeftToDown {
    DDSnake *snake = [[DDSnake alloc]init];
    [snake changeSnakeDirection:DDDirectionDown];
    [snake move];
    DDCPoint tail = [snake.bodyQueue[0] DDCPointValue];
    DDCPoint head = [snake.bodyQueue[1] DDCPointValue];
    XCTAssertTrue(tail.x == 10 && tail.y == 10);
    XCTAssertTrue(head.x == 10 && head.y == 11);
}

- (void) testSnakeMoveLeftToDownToRight {
    DDSnake *snake = [[DDSnake alloc]init];
    [snake changeSnakeDirection:DDDirectionDown];
    [snake move];
    [snake changeSnakeDirection:DDDirectionRight];
    [snake move];
    DDCPoint tail = [snake.bodyQueue[0] DDCPointValue];
    DDCPoint head = [snake.bodyQueue[1] DDCPointValue];
    XCTAssertTrue(tail.x == 10 && tail.y == 11);
    XCTAssertTrue(head.x == 11 && head.y == 11);
}

- (void) testSnakeGrowUpByHorizontalTail {
    DDSnake *snake = [DDSnake new];
    [snake growUp];
    DDCPoint firstLastTail = [snake.bodyQueue[0] DDCPointValue];
    DDCPoint secondLastTail = [snake.bodyQueue[1] DDCPointValue];
    XCTAssertTrue(firstLastTail.x == 13 && firstLastTail.y == 10);
    XCTAssertTrue(secondLastTail.x == 12 && secondLastTail.y == 10);
}

- (void) testSnakeGrowUpByVerticalTail {
    DDSnake *snake = [[DDSnake alloc] initWithPoint:DDCPointMake(10, 10) Direction:DDDirectionDown];
    [snake growUp];
    DDCPoint firstLastTail = [snake.bodyQueue[0] DDCPointValue];
    DDCPoint secondLastTail = [snake.bodyQueue[1] DDCPointValue];
    XCTAssertTrue(firstLastTail.x == 10 && firstLastTail.y == 8);
    XCTAssertTrue(secondLastTail.x == 10 && secondLastTail.y == 9);
}

- (void) testSnakeIsHitByHead {
    DDSnake *snake = [DDSnake new];
    [snake growUp];
    [snake growUp];
    [snake changeSnakeDirection:DDDirectionDown];
    [snake move];
    [snake changeSnakeDirection:DDDirectionRight];
    [snake move];
    [snake changeSnakeDirection:DDDirectionUp];
    [snake move];
    XCTAssertTrue([snake isHitBodyByHead]);
}

- (void) testSnakeIsNotHitByHead {
    DDSnake *snake = [DDSnake new];
    [snake growUp];
    [snake growUp];
    [snake changeSnakeDirection:DDDirectionDown];
    [snake move];
    [snake changeSnakeDirection:DDDirectionRight];
    [snake move];
    [snake changeSnakeDirection:DDDirectionRight];
    [snake move];
    XCTAssertFalse([snake isHitBodyByHead]);
}


- (void)testObjectIsInSnakeBody {
    DDSnake *snake = [[DDSnake alloc] initWithPoint:DDCPointMake(20, 20) Direction:DDDirectionUp];
    [snake growUp];
    [snake growUp];
    [snake growUp];
    
    XCTAssertFalse([snake isPointInSnakeBody:DDCPointMake(20, 18)]);
    XCTAssertTrue([snake isPointInSnakeBody:DDCPointMake(20, 19)]);
    XCTAssertTrue([snake isPointInSnakeBody:DDCPointMake(20, 20)]);
    XCTAssertTrue([snake isPointInSnakeBody:DDCPointMake(20, 25)]);
    XCTAssertTrue([snake isPointInSnakeBody:DDCPointMake(20, 26)]);
    XCTAssertFalse([snake isPointInSnakeBody:DDCPointMake(20, 27)]);
}

- (void)testObjectIsNotInSnakeBody {
    DDSnake *snake = [[DDSnake alloc] initWithPoint:DDCPointMake(20, 20) Direction:DDDirectionLeft];
    [snake growUp];
    [snake growUp];
    [snake growUp];
    
    XCTAssertFalse([snake isPointInSnakeBody:DDCPointMake(17, 22)]);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
