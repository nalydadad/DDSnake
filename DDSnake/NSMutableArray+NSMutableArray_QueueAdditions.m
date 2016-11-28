//
//  NSMutableArray+NSMutableArray_QueueAdditions.m
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import "NSMutableArray+NSMutableArray_QueueAdditions.h"
#import <UIKit/UIKit.h>
@implementation NSMutableArray (NSMutableArray_QueueAdditions)

- (id)dequeue {
    id object = [self objectAtIndex:0];
    if(object != nil) {
        [self removeObjectAtIndex:0];
    }
    return object;
}

-(void)enqueue:(id)obj {
    [self addObject:obj];
}

@end
