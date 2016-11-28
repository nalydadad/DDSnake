//
//  DDGameView.h
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDConstants.h"

@class DDGameView;

@protocol GameDataSource
- (CGPoint) getSnakeHead;
- (CGPoint) getSnakeTail;
- (CGPoint) getFruitPos;
- (id)getSnakeBody;

@end

@protocol GameDelegate
- (void) reportGestureChage:(Direction) dir;
@end

@interface DDGameView : UIView
@property(weak, nonatomic) id<GameDataSource, GameDelegate> delegate;
@property(assign, nonatomic) NSUInteger scale;
@property(assign, nonatomic) NSUInteger coorWidth;
@property(assign, nonatomic) NSUInteger coorHeight;
- (CGPoint) preventOutOfBount:(CGPoint)originPoint;
@end
