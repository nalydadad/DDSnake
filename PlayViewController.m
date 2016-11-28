//
//  PlayViewController.m
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import "PlayViewController.h"
#import "DDSnake.h"

@interface PlayViewController ()

@property(strong, nonatomic)DDSnake *snake;
@property(assign, nonatomic)CGPoint fruit;
@property(weak, nonatomic)NSTimer *timer;
@property(strong, nonatomic)IBOutlet DDGameView *gameView;
@property(assign, nonatomic)Direction gestureDirection;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.snake = [[DDSnake alloc] init];
    self.fruit = [self generateFruit];
    self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.3f
                                                   target:self
                                                 selector:@selector(taskInEachStep)
                                                 userInfo:nil
                                                  repeats:YES];
    [self.timer fire];
    self.gestureDirection = goLeft;
    self.gameView.delegate = self;
}

-(void)viewDidDisappear:(BOOL)animated {
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)taskInEachStep {
    if((self.gestureDirection +6) % 4 != self.snake.direction) {
        self.snake.direction = self.gestureDirection;
    }

    [self.snake move];
    
    if([self.snake isDead]) {
        [self.timer invalidate];
        return;
    }
    
    self.snake.head = [self.gameView preventOutOfBount:self.snake.head];
    if(CGPointEqualToPoint(self.snake.head, self.fruit)) {
        self.fruit = [self.gameView preventOutOfBount:[self generateFruit]];
        [self.snake growUp];
    }
    
    [self.gameView setNeedsDisplay];
}

- (CGPoint) generateFruit {
    return CGPointMake((NSInteger)arc4random() % (self.gameView.coorWidth),
                       (NSInteger)arc4random() % (self.gameView.coorHeight));
}

- (IBAction)stopPlaying:(id)sender {
    [self.timer invalidate];
}

#pragma - View DataSource and Delegate

-(CGPoint)getFruitPos {
    return self.fruit;
}

-(CGPoint)getSnakeHead {
    return self.snake.head;
}

- (CGPoint)getSnakeTail {
    return self.snake.tail;
}

-(void)reportGestureChage:(Direction)dir {
    self.gestureDirection = dir;
}

-(id)getSnakeBody {
    return self.snake.bodyQueue;
}

@end
