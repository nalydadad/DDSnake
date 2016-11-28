//
//  DDSnake.h
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDConstants.h"
#import <UIKit/UIKit.h>

@interface DDSnake : NSObject

@property(assign, nonatomic)Direction direction;
@property(assign, nonatomic)CGPoint head;
@property(assign, nonatomic)CGPoint tail;
@property(strong, nonatomic) NSMutableArray *bodyQueue;

- (void) move;
- (BOOL) isDead;
- (void)growUp;
@end
