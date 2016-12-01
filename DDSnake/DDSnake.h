//
//  DDSnake.h
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDConstants.h"
#import "DDPoint.h"

@class DDSnake;
@protocol SnakeDelegate
- (void) DDSnake:(DDSnake*)snake checkSubBodyIsOutofView:(DDCPoint*)body;
@end


@interface DDSnake : NSObject

@property(weak, nonatomic) id<SnakeDelegate> delegate;
@property(strong, nonatomic) NSMutableArray<NSValue*> *bodyQueue;

- (instancetype)initWithPoint:(DDCPoint)point Direction:(DDDirection)direction;
- (DDCPoint) head;
- (void) move;
- (void) changeSnakeDirection:(DDDirection)dir;
- (BOOL) isHitBodyByHead;
- (BOOL) isPointInSnakeBody:(DDCPoint)object;
- (void) growUp;
@end
