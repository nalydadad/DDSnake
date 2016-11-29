//
//  DDPoint.m
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import "DDPoint.h"

//@implementation DDPoint
//
//- (BOOL)isEqual:(id)object
//{
//    if (![object isKindOfClass:[DDPoint class]]) {
//        return NO;
//    }
//    
//    DDPoint *anotherPoint = (DDPoint *)object;
//    return anotherPoint.x == self.x && anotherPoint.y == self.y;
//}
//
//@end
//

@implementation NSValue (DDCPoint)

+ (instancetype)valueWithDDCPoint:(DDCPoint)point
{
    NSValue *value = [NSValue valueWithBytes:&point objCType:@encode(DDCPoint)];
    return value;
}

- (DDCPoint)DDCPointValue
{
    DDCPoint point;
    [self getValue:&point];
    return point;
}

@end
