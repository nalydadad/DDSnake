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
@property(assign, nonatomic) CGFloat offsetX;
@property(assign, nonatomic) CGFloat offsetY;
@end


@implementation DDGameView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setBackgroundColor:[UIColor grayColor]];
        self.snakeColor = [UIColor redColor];
        self.fruitColor = [UIColor greenColor];
        self.backColor = [UIColor whiteColor];
        [self prepareForGuestureDetection];
        self.scale = 20;
        CGSize screeSize = [[UIScreen mainScreen] bounds].size;
        self.coorWidth = screeSize.width / self.scale;
        self.coorHeight = screeSize.height / self.scale;
        self.offsetX = (screeSize.width - self.scale * self.coorWidth) / 2.0;
        self.offsetY = (screeSize.height - self.scale * self.coorHeight) / 2.0;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    self.context = UIGraphicsGetCurrentContext();
    [self drawSnakeBody:[self.delegate gameViewRequestSnakeBody:self]];
    CGRect fruit = [self makeRectInCoordinate:[self.delegate gameviewRequestFruit:self]];
    [self drawUnitObject:fruit Color:self.fruitColor];
}

- (CGRect) makeRectInCoordinate:(DDCPoint)point {
    return CGRectMake(point.x * self.scale + self.offsetX,
                      point.y * self.scale + self.offsetY,
                      self.scale, self.scale);
}

- (void)drawSnakeBody:(id)body {
    NSMutableArray<NSValue*> *snakeBody = (NSMutableArray*)body;
    for(int i=0; i< [snakeBody count]; i++ ) {
        DDCPoint point = [self preventOutOfBount:[snakeBody[i] DDCPointValue]];
        snakeBody[i] = [NSValue valueWithBytes:&point objCType:@encode(DDCPoint)];
        [self drawUnitObject:[self makeRectInCoordinate:[snakeBody[i] DDCPointValue]] Color:self.snakeColor];
    }
}

- (void) drawUnitObject:(CGRect)rect Color:(UIColor*)color{
    CGContextBeginPath(self.context);
    CGContextSetStrokeColorWithColor(self.context, color.CGColor);
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
    [self.delegate gameview:self didChangeDirection:DDDirectionUp];
}

- (void)reportSwipeDown:(UIGestureRecognizer *)recognizer {
    [self.delegate gameview:self didChangeDirection:DDDirectionDown];
}

- (void)reportSwipeLeft:(UIGestureRecognizer *)recognizer {
    [self.delegate gameview:self didChangeDirection:DDDirectionLeft];
}

- (void)reportSwipeRight:(UIGestureRecognizer *)recognizer {
    [self.delegate gameview:self didChangeDirection:DDDirectionRight];
}

- (DDCPoint) preventOutOfBount:(DDCPoint)originPoint {
    while(originPoint.x < 0) {
        originPoint.x += self.coorWidth;
    }
    while(originPoint.y < 0) {
        originPoint.y += self.coorHeight;
    }
    originPoint.x = originPoint.x % (self.coorWidth);
    originPoint.y = originPoint.y % (self.coorHeight);
    return originPoint;
}

@end
