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

@property(strong, nonatomic) DDSnake *snake;
@property(assign, nonatomic) DDCPoint fruit;
@property(weak, nonatomic) NSTimer *timer;
@property(strong, nonatomic)IBOutlet DDGameView *gameView;
@property(assign, nonatomic) DDDirection gestureDirection;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.snake = [[DDSnake alloc] init];
    self.fruit = [self generateRandomFruit];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.2f
                                                   target:self
                                                 selector:@selector(taskInEachStep)
                                                 userInfo:nil
                                                  repeats:YES];
    self.gestureDirection = DDDirectionLeft;
    [self.timer fire];
    self.gameView.delegate = self;
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)taskInEachStep {
    if([self isOppositeDirection:self.gestureDirection]) {
        self.snake.direction = self.gestureDirection;
    }
    
    [self.snake move];
    
    if([self.snake isDead]) {
        [self.timer invalidate];
        self.timer = nil;
        [self performSegueWithIdentifier:@"backToMain" sender:self];
        return;
    }
    
    if(DDCPointEqualToPoint([self.gameView preventOutOfBount:self.snake.head], self.fruit)) {
        self.fruit = [self.gameView preventOutOfBount:[self generateRandomFruit]];
        [self.snake growUp];
    }
    
    [self.gameView setNeedsDisplay];
}

- (BOOL) isOppositeDirection:(DDDirection) direction{
    return (direction +6) % 4 != self.snake.direction;
}

- (DDCPoint) generateRandomFruit {
    DDCPoint fruit = DDCPointMake((NSInteger)arc4random() % (self.gameView.coorWidth),
                                  (NSInteger)arc4random() % (self.gameView.coorHeight));
    while([self.snake.bodyQueue containsObject:[NSValue valueWithDDCPoint:fruit]]) {
        fruit = DDCPointMake((NSInteger)arc4random() % (self.gameView.coorWidth),
                             (NSInteger)arc4random() % (self.gameView.coorHeight));
    }
    return fruit;
}

- (IBAction)stopPlaying:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma - View DataSource and Delegate

- (DDCPoint)gameviewRequestFruit:(DDGameView *)view{
    return self.fruit;
}

- (DDCPoint)gameviewRequestSnakeHead:(DDGameView *)view{
    return self.snake.head;
}

-(id)gameViewRequestSnakeBody:(DDGameView *)view {
    return self.snake.bodyQueue;
}

- (void)gameview:(DDGameView *)view didChangeDirection:(DDDirection)direction{
    self.gestureDirection = direction;
}

@end
