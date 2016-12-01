//
//  DDGameView.m
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import "DDGameView.h"

@interface DDGameView ()
+ (UIColor *)backColor;
+ (UIColor *)snakeColor;
+ (UIColor *)fruitColor;
@end

@implementation DDGameView

+ (UIColor *)backColor {
    return [UIColor grayColor];
}
+ (UIColor *)snakeColor {
    return [UIColor redColor];
}
+ (UIColor *)fruitColor {
    return [UIColor greenColor];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setBackgroundColor:[DDGameView backColor]];
        [self prepareForGuestureDetection];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (self.delegate == nil) {
        return;
    }
    [self drawSnakeBody:[self.delegate gameViewRequestSnakeBody:self] context:context];
    [self drawUnitObject:[self.delegate gameviewRequestFruit:self] color:[DDGameView fruitColor] context:context];
}

- (void)drawSnakeBody:(NSArray<NSValue *> *)body context:(CGContextRef)context {
    for (NSValue *v in body) {
        [self drawUnitObject:[v CGRectValue] color:[DDGameView snakeColor] context:context];
    }
}

- (void)drawUnitObject:(CGRect)rect color:(UIColor *)color context:(CGContextRef)context {
    CGContextSetStrokeColorWithColor(context, color.CGColor);
    CGContextStrokeRect(context, rect);
}

- (void)prepareForGuestureDetection {
    void (^addSwipeGestureRecognizer)(UISwipeGestureRecognizerDirection, SEL) = ^(UISwipeGestureRecognizerDirection direction, SEL selector) {
        UISwipeGestureRecognizer *gr = [[UISwipeGestureRecognizer alloc]
                                        initWithTarget:self action:selector];
        gr.direction = direction;
        [self addGestureRecognizer:gr];
    };
    addSwipeGestureRecognizer(UISwipeGestureRecognizerDirectionUp, @selector(reportSwipeUp:));
    addSwipeGestureRecognizer(UISwipeGestureRecognizerDirectionDown, @selector(reportSwipeDown:));
    addSwipeGestureRecognizer(UISwipeGestureRecognizerDirectionLeft, @selector(reportSwipeLeft:));
    addSwipeGestureRecognizer(UISwipeGestureRecognizerDirectionRight, @selector(reportSwipeRight:));
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

@end

