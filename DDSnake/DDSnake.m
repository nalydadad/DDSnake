//
//  DDSnake.m
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import "DDSnake.h"
#import "NSMutableArray+QueueAdditions.h"

@interface DDSnake()
@property(assign, nonatomic) DDDirection direction;

@end


@implementation DDSnake

- (instancetype)init {
    self = [super init];
    self.bodyQueue = [[NSMutableArray alloc] init];
    DDCPoint queryPoint = {.x=11, .y=10};
    for (int i = 0; i < 2; i++) {
        [self.delegate DDSnake:self checkSubBodyIsOutofView:&queryPoint];
        [self.bodyQueue enqueue:[NSValue valueWithDDCPoint:queryPoint]];
        queryPoint.x = queryPoint.x - 1;
    }
    self.direction = DDDirectionLeft;
    return self;
}

- (instancetype)initWithPoint:(DDCPoint)point Direction:(DDDirection)direction {
    self = [super init];
    self.bodyQueue = [[NSMutableArray alloc] init];
    DDCPoint startPoint = point;
    [self.delegate DDSnake:self checkSubBodyIsOutofView:&startPoint];
    [self.bodyQueue enqueue:[NSValue valueWithDDCPoint:point]];
    self.direction = direction;
    switch (self.direction) {
        case DDDirectionUp:
            startPoint.y -= 1;
            break;
        case DDDirectionDown:
            startPoint.y += 1;
            break;
        case DDDirectionLeft:
            startPoint.x -= 1;
            break;
        case DDDirectionRight:
            startPoint.x += 1;
            break;
    }
    [self.delegate DDSnake:self checkSubBodyIsOutofView:&startPoint];
    [self.bodyQueue enqueue:[NSValue valueWithDDCPoint:startPoint]];
    return self;
}

- (DDCPoint)head {
    return [[self.bodyQueue lastObject] DDCPointValue];
}

- (void)changeSnakeDirection:(DDDirection)direction {
    if (![self isOppositeDirection:direction]) {
        self.direction = direction;
    }
}

- (void)move {
    DDCPoint newHead = self.head;
    switch (self.direction) {
        case DDDirectionUp:
            newHead.y -= 1;
            break;
        case DDDirectionDown:
            newHead.y += 1;
            break;
        case DDDirectionLeft:
            newHead.x -= 1;
            break;
        case DDDirectionRight:
            newHead.x += 1;
            break;
    }
    [self.delegate DDSnake:self checkSubBodyIsOutofView:&newHead];
    [self.bodyQueue enqueue:[NSValue valueWithDDCPoint:newHead]];
    [self.bodyQueue.dequeue DDCPointValue];
}

- (BOOL)isHitBodyByHead {
    NSArray *bodyWithoutHead = [self.bodyQueue subarrayWithRange:NSMakeRange(0, [self.bodyQueue count] - 2)];
    return [bodyWithoutHead containsObject:[self.bodyQueue lastObject]];
}

- (BOOL)isPointInSnakeBody:(DDCPoint)object {
    return [self.bodyQueue containsObject:[NSValue valueWithDDCPoint:object]];
}

- (void)growUp {
    DDCPoint firstLastBody = [self.bodyQueue[0] DDCPointValue];
    DDCPoint secondLastBody = [self.bodyQueue[1] DDCPointValue];
    NSInteger growingOffset = firstLastBody.x - secondLastBody.x;
    DDCPoint newBody1 = firstLastBody;
    DDCPoint newBody2 = firstLastBody;
    if (growingOffset != 0) {
        newBody1.x += growingOffset;
        newBody2.x += growingOffset * 2;
    } else {
        growingOffset = firstLastBody.y - secondLastBody.y;
        newBody1.y += growingOffset;
        newBody2.y += growingOffset * 2;
    }
    [self.delegate DDSnake:self checkSubBodyIsOutofView:&newBody1];
    [self.bodyQueue insertObject:[NSValue valueWithDDCPoint:newBody1] atIndex:0];
    [self.delegate DDSnake:self checkSubBodyIsOutofView:&newBody2];
    [self.bodyQueue insertObject:[NSValue valueWithDDCPoint:newBody2] atIndex:0];
}

- (BOOL)isOppositeDirection:(DDDirection)direction {
    return (direction + 6) % 4 == self.direction;
}

@end
