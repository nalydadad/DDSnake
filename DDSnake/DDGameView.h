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
- (CGRect) gameviewRequestFruit:(DDGameView*)view;
- (NSArray<NSValue *> *) gameViewRequestSnakeBody:(DDGameView*)view;
@end

@protocol GameDelegate
- (void)gameview:(DDGameView *)view didChangeDirection:(DDDirection) dir;
@end

@interface DDGameView : UIView
@property(weak, nonatomic) id<GameDataSource, GameDelegate> delegate;
@end
