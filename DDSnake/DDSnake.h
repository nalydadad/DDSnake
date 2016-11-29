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

@interface DDSnake : NSObject
@property(assign, nonatomic) DDDirection direction;
@property(strong, nonatomic) NSMutableArray<NSValue*> *bodyQueue;
- (DDCPoint) head;
- (void) move;
- (BOOL) isDead;
- (void)growUp;
@end
