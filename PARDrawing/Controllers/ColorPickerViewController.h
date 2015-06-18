//
//  ColorPickerViewController.h
//  PARDrawing
//
//  Created by Paul Rolfe on 6/17/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorPickerViewController;

@protocol ColorPickerDelegate <NSObject>

- (void)colorPicker:(ColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color;

@end

@interface ColorPickerViewController : UIViewController

@property (nonatomic, weak) id<ColorPickerDelegate> delegate;
@property (nonatomic, strong) UIColor *currentColor;

@end



