//
//  BrushPickerViewController.h
//  PARDrawing
//
//  Created by Paul Rolfe on 6/17/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BrushPickerViewController;

@protocol BrushPickerDelegate <NSObject>

- (void)brushPicker:(BrushPickerViewController *)brushPicker didSelectWidth:(CGFloat)lineWidth;

@end


@interface BrushPickerViewController : UIViewController

@property (nonatomic, weak) id<BrushPickerDelegate> delegate;
@property (nonatomic) CGFloat currentWidth;

@end
