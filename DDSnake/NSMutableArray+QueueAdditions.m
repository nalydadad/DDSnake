//
//  NSMutableArray+NSMutableArray_QueueAdditions.m
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import "NSMutableArray+QueueAdditions.h"
#import <UIKit/UIKit.h>

@implementation NSMutableArray (QueueAdditions)

- (id)dequeue {
    id object = [self firstObject];
    if(object != nil) {
        [self removeObjectAtIndex:0];
    }
    return object;
}

-(void)enqueue:(id)obj {
    [self addObject:obj];
}

@end
