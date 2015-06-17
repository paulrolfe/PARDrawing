//
//  PARDrawView.m
//  PARDrawing
//
//  Created by Paul Rolfe on 6/16/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import "PARDrawView.h"

@interface PARDrawView ()

@end

@implementation PARDrawView

- (void)awakeFromNib{
    
    self.drawingObjects = [[NSMutableArray alloc] init];
    self.currentDrawing = [[PARDrawingObject alloc] init];
}

#pragma mark - Public Methods

- (void)setCurrentColor:(UIColor *)color{
    self.currentDrawing.color = color;
}

- (void)setCurrentLineWidth:(CGFloat)lineWidth{
    self.currentDrawing.lineWidth = lineWidth;
}

- (void)clearView{
    [self.drawingObjects removeAllObjects];
    [self.currentDrawing.path removeAllPoints];
    [self setNeedsDisplay];
}

- (BOOL)toggleEraser{
    [self.currentDrawing setIsErasing:!self.currentDrawing.isErasing];
    return self.currentDrawing.isErasing;
}

- (void)saveView{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark - Private Methods

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo
{
    if (error){
        [[[UIAlertView alloc] initWithTitle:@"Failed to save" message:error.localizedDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
    else{
        [[[UIAlertView alloc] initWithTitle:@"Saved to camera roll" message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

#pragma mark - Touch Events and Drawing

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"got a touch");
    CGPoint touchPoint = [(UITouch *)touches.anyObject locationInView:self];
    
    [self.currentDrawing.path removeAllPoints];
    [self.currentDrawing.path moveToPoint:touchPoint];
    [self.currentDrawing.path addLineToPoint:touchPoint];
    [self setNeedsDisplay];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [(UITouch *)touches.anyObject locationInView:self];
    //NSLog(@"moved a touch (%f,%f)",touchPoint.x, touchPoint.y);
    
    [self.currentDrawing.path addLineToPoint:touchPoint];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.drawingObjects addObject:[PARDrawingObject drawingObjectFromObject:self.currentDrawing]];
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    for (PARDrawingObject *drawingObject in self.drawingObjects){
        [drawingObject.path setLineWidth:drawingObject.lineWidth];
        [drawingObject.color setStroke];
        [drawingObject.path stroke];
    }
    
    [self.currentDrawing.path setLineWidth:self.currentDrawing.lineWidth];
    [self.currentDrawing.color setStroke];
    [self.currentDrawing.path stroke];
}

@end
