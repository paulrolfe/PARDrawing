//
//  PARDrawingObject.h
//  PARDrawing
//
//  Created by Paul Rolfe on 6/16/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PARDrawingObject : NSObject

@property (nonatomic, strong) UIColor *color;
@property (nonatomic) CGFloat lineWidth;
@property (nonatomic, strong) UIBezierPath *path;
@property (nonatomic) BOOL isErasing;

+ (instancetype) drawingObjectFromObject:(PARDrawingObject *)oldObject; //hack around NSCopying

@end
