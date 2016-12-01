//
//  PlayViewController.h
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDGameView.h"
#import "DDSnake.h"


@interface PlayViewController : UIViewController<GameDataSource, GameDelegate, SnakeDelegate>
@end
