//
//  DDSnake.m
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import "DDSnake.h"
#import "NSMutableArray+NSMutableArray_QueueAdditions.h"


@implementation DDSnake

- (instancetype)init {
    self = [super init];
    self.bodyQueue = [[NSMutableArray alloc] init];
    CGPoint queryPoint = CGPointMake(10, 10);
    for(int i = 0; i < 2; i++) {
        queryPoint = CGPointMake(queryPoint.x + 1, queryPoint.y);
        [self.bodyQueue enqueue:[NSValue valueWithCGPoint:queryPoint]];
    }
    self.direction = goLeft;
    self.head = [[self.bodyQueue lastObject] CGPointValue];
    self.tail = [[self.bodyQueue objectAtIndex:0] CGPointValue];
//    [self printBodyCoordinate];
    return self;
}


-(void)move {
    switch (self.direction) {
        case goUp:
            self.head = CGPointMake(self.head.x, self.head.y - 1);
            break;
        case goDown:
            self.head = CGPointMake(self.head.x, self.head.y + 1);
            break;
        case goLeft:
            self.head = CGPointMake(self.head.x - 1, self.head.y);
            break;
        case goRight:
            self.head = CGPointMake(self.head.x + 1, self.head.y);
            break;
        default:
            assert(true);
            break;
    }
    [self.bodyQueue enqueue:[NSValue valueWithCGPoint:self.head]];
    self.tail = [(NSValue*)self.bodyQueue.dequeue CGPointValue];
//    [self printBodyCoordinate];
}

- (BOOL)isDead {
    NSArray *subarray = [self.bodyQueue subarrayWithRange:NSMakeRange(1, [self.bodyQueue count] - 2)];
    if([subarray containsObject:[NSValue valueWithCGPoint:self.head]]) {
        return YES;
    }
    else {
        return NO;
    }
}

- (void)growUp {
    CGPoint lastFirst = [[self.bodyQueue objectAtIndex:0] CGPointValue];
    CGPoint lastSecond = [[self.bodyQueue objectAtIndex:1] CGPointValue];
    NSInteger offset = lastFirst.x - lastSecond.x;
    if(offset != 0) {
        [self.bodyQueue insertObject:[NSValue valueWithCGPoint:CGPointMake(lastFirst.x + offset, lastFirst.y)] atIndex:0];
        [self.bodyQueue insertObject:[NSValue valueWithCGPoint:CGPointMake(lastFirst.x + 2 * offset, lastFirst.y)] atIndex:0];
    } else {
        offset = lastFirst.y - lastSecond.y;
        [self.bodyQueue insertObject:[NSValue valueWithCGPoint:CGPointMake(lastFirst.x, lastFirst.y + offset)] atIndex:0];
        [self.bodyQueue insertObject:[NSValue valueWithCGPoint:CGPointMake(lastFirst.x, lastFirst.y + offset * 2)] atIndex:0];
    }
}

//- (void) printBodyCoordinate {
//    NSLog(@"--------Body-------");
//    for(NSValue *point in self.bodyQueue) {
//        NSLog(@"[%f, %f]", [point CGPointValue].x, [point CGPointValue].y);
//    }
//}


@end
