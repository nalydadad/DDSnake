//
//  NSMutableArray+NSMutableArray_QueueAdditions.h
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (NSMutableArray_QueueAdditions)
- (id) dequeue;
- (void) enqueue:(id) obj;
@end
