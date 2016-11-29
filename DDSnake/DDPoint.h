//
//  DDPoint.h
//  DDSnake
//
//  Created by DADA on 2016/11/28.
//  Copyright © 2016年 DADA. All rights reserved.
//

#import <Foundation/Foundation.h>

//@interface DDPoint : NSObject
//@property (assign, nonatomic) NSInteger x;
//@property (assign, nonatomic) NSInteger y;
//@end

typedef struct {
    NSInteger x;
    NSInteger y;
} DDCPoint;

NS_INLINE DDCPoint DDCPointMake(NSInteger x, NSInteger y) {
    DDCPoint p; p.x = x; p.y = y; return p;
}

NS_INLINE bool DDCPointEqualToPoint(DDCPoint point1, DDCPoint point2) {
    return point1.x == point2.x && point1.y == point2.y;
}

@interface NSValue (DDCPoint)
+ (instancetype)valueWithDDCPoint:(DDCPoint)point;
- (DDCPoint)DDCPointValue;
@end




