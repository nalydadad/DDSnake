//
//  DDGameView.m
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import "DDGameView.h"

@interface DDGameView()

@property(strong, nonatomic) UIColor *backColor;
@property(strong, nonatomic) UIColor *snakeColor;
@property(strong, nonatomic) UIColor *fruitColor;
@property(assign, nonatomic) CGContextRef context;
@property(assign, nonatomic) BOOL firstLaunch;
@end


@implementation DDGameView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        NSLog(@"Frame width: %f height: %f ", self.frame.size.width, self.frame.size.height);
        
        [self setBackgroundColor:[UIColor grayColor]];
        
        self.snakeColor = [UIColor redColor];
        self.fruitColor = [UIColor greenColor];
        self.backColor = [UIColor whiteColor];
        [self prepareForGuestureDetection];
        self.scale = 20;
        self.coorWidth = (NSInteger)self.frame.size.width / self.scale;
        self.coorHeight = (NSInteger)self.frame.size.height / self.scale;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.context = UIGraphicsGetCurrentContext();
    id snakeBody = [self.delegate getSnakeBody];
    [self drawSnakeBody:snakeBody];
    CGRect fruit = [self makeRectInCoordinate:[self.delegate getFruitPos]];
    [self drawObject:fruit Color:self.fruitColor];
}

- (CGRect) makeRectInCoordinate:(CGPoint)point {
    return CGRectMake(point.x * self.scale, point.y * self.scale, self.scale, self.scale);
}

- (void)drawSnakeBody:(id)body {
    NSMutableArray *snakeBody = (NSMutableArray*)body;
    NSLog(@"--------Body-------");
    for(NSValue* value in snakeBody) {
        CGPoint point = [self preventOutOfBount:[value CGPointValue]];
        NSLog(@"[%f, %f]", point.x, point.y);
        [self drawObject:[self makeRectInCoordinate:point] Color:self.snakeColor];
    }
}



- (void) drawObject:(CGRect)rect Color:(UIColor*)color{
    CGContextBeginPath(self.context);
    CGContextSetStrokeColorWithColor(self.context, color.CGColor);
    CGContextSetFillColorWithColor(self.context, color.CGColor);
    CGContextAddRect(self.context, rect);
    CGContextStrokePath(self.context);
}

- (void)prepareForGuestureDetection {
    UISwipeGestureRecognizer *up = [[UISwipeGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(reportSwipeUp:)];
    up.direction = UISwipeGestureRecognizerDirectionUp;
    UISwipeGestureRecognizer *down = [[UISwipeGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(reportSwipeDown:)];
    down.direction = UISwipeGestureRecognizerDirectionDown;
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(reportSwipeLeft:)];
    left.direction = UISwipeGestureRecognizerDirectionLeft;
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]
                                        initWithTarget:self action:@selector(reportSwipeRight:)];
    right.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self addGestureRecognizer:up];
    [self addGestureRecognizer:down];
    [self addGestureRecognizer:left];
    [self addGestureRecognizer:right];
}

- (void)reportSwipeUp:(UIGestureRecognizer *)recognizer {
    [self.delegate reportGestureChage:goUp];
}

- (void)reportSwipeDown:(UIGestureRecognizer *)recognizer {
    [self.delegate reportGestureChage:goDown];
}

- (void)reportSwipeLeft:(UIGestureRecognizer *)recognizer {
    [self.delegate reportGestureChage:goLeft];
}

- (void)reportSwipeRight:(UIGestureRecognizer *)recognizer {
    [self.delegate reportGestureChage:goRight];
}

- (CGPoint) preventOutOfBount:(CGPoint)originPoint {
    while(originPoint.x < 0 || originPoint.y < 0) {
        originPoint = CGPointMake(originPoint.x + self.coorWidth,
                                  originPoint.y + self.coorHeight);
    }
    return CGPointMake((NSInteger)originPoint.x % self.coorWidth ,
                       (NSInteger)originPoint.y % self.coorHeight);
}

@end
