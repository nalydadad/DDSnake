//
//  PlayViewController.m
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import "PlayViewController.h"

@interface PlayViewController ()

@property(strong, nonatomic) DDSnake *snake;
@property(assign, nonatomic) DDCPoint fruit;
@property(weak, nonatomic) NSTimer *timer;
@property(strong, nonatomic) IBOutlet DDGameView *gameView;
@property(assign, nonatomic) DDDirection gestureDirection;

@property(assign, nonatomic) NSInteger widthBound;
@property(assign, nonatomic) NSInteger heightBound;
@property(assign, nonatomic) CGFloat offsetX;
@property(assign, nonatomic) CGFloat offsetY;
@property(assign, nonatomic) NSUInteger scale;
@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startNewGameAtLocation:DDCPointMake(20, 20) initialDirection:DDDirectionLeft];
}

- (void)startNewGameAtLocation:(DDCPoint)startPoint initialDirection:(DDDirection)direction {
    self.scale = 20;
    CGSize screeSize = [[UIScreen mainScreen] bounds].size;
    self.widthBound = screeSize.width / self.scale;
    self.heightBound = screeSize.height / self.scale;
    self.offsetX = (screeSize.width - self.scale * self.widthBound) / 2.0;
    self.offsetY = (screeSize.height - self.scale * self.heightBound) / 2.0;
    
    self.snake = [[DDSnake alloc] initWithPoint:startPoint Direction:direction];
    self.gestureDirection = direction;
    self.fruit = [self generateRandomFruit];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1f
                                                  target:self
                                                selector:@selector(taskInEachStep)
                                                userInfo:nil
                                                 repeats:YES];
    self.gameView.delegate = self;
    self.snake.delegate = self;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.timer invalidate];
    self.timer = nil;
}

- (void)taskInEachStep {
    [self.snake changeSnakeDirection:self.gestureDirection];
    [self.snake move];

    if ([self.snake isHitBodyByHead]) {
        [self.timer invalidate];
        self.timer = nil;
        [self performSegueWithIdentifier:@"backToMain" sender:self];
    }

    if (DDCPointEqualToPoint(self.snake.head, self.fruit)) {
        self.fruit = [self generateRandomFruit];
        [self.snake growUp];
    }

    [self.gameView setNeedsDisplay];
}


- (DDCPoint)generateRandomFruit {
    DDCPoint fruit = DDCPointMake((NSInteger) arc4random() % (self.widthBound),
            (NSInteger) arc4random() % (self.heightBound));
    while ([self.snake isPointInSnakeBody:fruit]) {
        fruit = DDCPointMake((NSInteger) arc4random() % (self.widthBound),
                (NSInteger) arc4random() % (self.heightBound));
    }
    return fruit;
}

- (IBAction)stopPlaying:(id)sender {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma - View DataSource and Delegate

- (CGRect)gameviewRequestFruit:(DDGameView *)view {
    return [self requestRectCoordinate:self.fruit];
}

- (id)gameViewRequestSnakeBody:(DDGameView *)view {
    NSMutableArray* rectArray = [[NSMutableArray alloc]init];
    for(NSValue *body in self.snake.bodyQueue) {
        [rectArray addObject:[NSValue valueWithCGRect:[self requestRectCoordinate:[body DDCPointValue]]]];
    }
    return rectArray;
}

- (void)gameview:(DDGameView *)view didChangeDirection:(DDDirection)direction {
    self.gestureDirection = direction;
}

- (void) DDSnake:(DDSnake*)snake checkSubBodyIsOutofView:(DDCPoint*)body {
    if (body->x < 0) {
        body->x += self.widthBound;
    }
    if (body->y < 0) {
        body->y += self.heightBound;
    }
    body->x %= self.widthBound;
    body->y %= self.heightBound;
}

- (CGRect) requestRectCoordinate:(DDCPoint)point {
    return CGRectMake(point.x * self.scale + self.offsetX,
                      point.y * self.scale + self.offsetY,
                      self.scale,
                      self.scale);
}

@end
