//
//  PARDrawView.h
//  PARDrawing
//
//  Created by Paul Rolfe on 6/16/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PARDrawingObject.h"

@interface PARDrawView : UIView

@property (nonatomic, strong) NSMutableArray *drawingObjects;
@property (nonatomic, strong) PARDrawingObject *currentDrawing;
- (void)clearView;
- (void)saveView;
- (void)setCurrentColor:(UIColor *)color;
- (void)setCurrentLineWidth:(CGFloat)lineWidth;
- (BOOL)toggleEraser; //returns whether erase mode is on.

@end
