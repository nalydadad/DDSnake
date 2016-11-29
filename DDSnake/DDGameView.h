//
//  DDGameView.h
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDConstants.h"
#import "DDPoint.h"

@class DDGameView;

@protocol GameDataSource
//- (DDCPoint)gameviewRequestSnakeHead:(DDGameView *)view;
//- (DDCPoint)gameviewRequestSnakeTail:(DDGameView *)view;
- (DDCPoint)gameviewRequestFruit:(DDGameView*)view;
- (id)gameViewRequestSnakeBody:(DDGameView*)view;

@end

@protocol GameDelegate
- (void)gameview:(DDGameView *)view didChangeDirection:(DDDirection) dir;
@end

@interface DDGameView : UIView
@property(weak, nonatomic) id<GameDataSource, GameDelegate> delegate;
@property(assign, nonatomic) NSUInteger scale;
@property(assign, nonatomic) NSUInteger coorWidth;
@property(assign, nonatomic) NSUInteger coorHeight;
- (DDCPoint) preventOutOfBount:(DDCPoint)originPoint;
@end
