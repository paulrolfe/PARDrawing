//
//  PARDrawingObject.m
//  PARDrawing
//
//  Created by Paul Rolfe on 6/16/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import "PARDrawingObject.h"

@interface PARDrawingObject ()

@property (nonatomic, strong) UIColor *oldColor;

@end

@implementation PARDrawingObject

- (instancetype) init{
    if (self = [super init]){
        self.color = [UIColor blackColor];
        self.lineWidth = 6.0;
        self.path = [[UIBezierPath alloc] init];
        self.path.lineJoinStyle = kCGLineJoinRound;
        self.path.lineCapStyle = kCGLineCapRound;
    }
    return self;
}

- (void) setIsErasing:(BOOL)isErasing{
    if (isErasing && !_isErasing){
        self.oldColor = self.color;
        self.color = [UIColor whiteColor];
    }
    else{
        self.color = self.oldColor;
    }
    _isErasing = isErasing;
}

+ (instancetype) drawingObjectFromObject:(PARDrawingObject *)oldObject{
    PARDrawingObject *newObject = [[PARDrawingObject alloc] init];
    newObject.color = [oldObject.color copy];
    newObject.lineWidth = oldObject.lineWidth;
    newObject.path = [oldObject.path copy];
    return newObject;
}

@end
