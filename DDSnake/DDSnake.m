//
//  DDSnake.m
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import "DDSnake.h"
#import "NSMutableArray+QueueAdditions.h"

@implementation DDSnake

- (instancetype)init {
    self = [super init];
    self.bodyQueue = [[NSMutableArray alloc] init];
    DDCPoint queryPoint = {.x=10, .y=10};
    for(int i = 0; i < 2; i++) {
        [self.bodyQueue enqueue:[NSValue valueWithDDCPoint:queryPoint]];
        queryPoint.x = queryPoint.x + 1;
    }
    self.direction = DDDirectionLeft;
    return self;
}

- (DDCPoint) head {
    return [[self.bodyQueue lastObject] DDCPointValue];
}

-(void)move {
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
        default:
            assert(true);
            break;
    }
    [self.bodyQueue enqueue:[NSValue valueWithDDCPoint:newHead]];
    [self.bodyQueue.dequeue DDCPointValue];
}

- (BOOL)isDead {
    NSArray *bodyWithoutHead = [self.bodyQueue subarrayWithRange:NSMakeRange(0, [self.bodyQueue count] - 2)];
    return [bodyWithoutHead containsObject:[NSValue valueWithDDCPoint:self.head]];
}

- (void)growUp {
    DDCPoint firstLast = [self.bodyQueue[0] DDCPointValue];
    DDCPoint secondLast = [self.bodyQueue[1] DDCPointValue];
    NSInteger offset = firstLast.x - secondLast.x;
    DDCPoint newBodyPoint1 = firstLast;
    DDCPoint newBodyPoint2 = firstLast;
    if(offset != 0) {
        newBodyPoint1.x += offset;
        newBodyPoint2.x += offset * 2;
    } else {
        offset = firstLast.y - secondLast.y;
        newBodyPoint1.y += offset;
        newBodyPoint2.y += offset * 2;
    }
    [self.bodyQueue insertObject:[NSValue valueWithDDCPoint:newBodyPoint1] atIndex:0];
    [self.bodyQueue insertObject:[NSValue valueWithDDCPoint:newBodyPoint2] atIndex:0];
}

@end
