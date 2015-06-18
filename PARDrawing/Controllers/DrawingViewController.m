//
//  ViewController.m
//  PARDrawing
//
//  Created by Paul Rolfe on 6/16/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import "DrawingViewController.h"
#import "ColorPickerViewController.h"
#import "BrushPickerViewController.h"
#import "PARDrawView.h"

@interface DrawingViewController ()<ColorPickerDelegate, BrushPickerDelegate>

@property (nonatomic, weak) IBOutlet PARDrawView *drawView;
@property (nonatomic, weak) IBOutlet UIButton *clearButton;
@property (nonatomic, weak) IBOutlet UIButton *saveButton;
@property (nonatomic, weak) IBOutlet UIButton *colorButton;
@property (nonatomic, weak) IBOutlet UIButton *brushButton;
@property (nonatomic, weak) IBOutlet UIButton *eraseButton;
@property (nonatomic, strong)ColorPickerViewController *colorPicker;
@property (nonatomic, strong)BrushPickerViewController *brushPicker;

@end

@implementation DrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.colorButton.layer setCornerRadius:20];
    [self.brushButton.layer setCornerRadius:20];
    [self.clearButton.layer setCornerRadius:20];
    [self.saveButton.layer setCornerRadius:20];
    [self.eraseButton.layer setCornerRadius:20];
    [self.colorButton setBackgroundColor:[UIColor blackColor]];
}

#pragma mark - IBActions

- (IBAction)clearTouched:(id)sender{
    [self.drawView clearView];
}
- (IBAction)saveTouched:(id)sender{
    [self.drawView saveView];
}

- (IBAction)colorButtonTouched:(id)sender{
    if (self.brushPicker)
        [self dismissBrushPicker];
    
    if (self.colorPicker){
        [self dismissColorPicker];
    }
    else{
        [self addColorPickerToScreen];
    }
}

- (IBAction)brushButtonTapped:(id)sender{
    if (self.colorPicker)
        [self dismissColorPicker];
    
    if (self.brushPicker){
        [self dismissBrushPicker];
    }
    else{
        [self addBrushPickerToScreen];
    }
}

- (IBAction)eraseButtonTapped:(id)sender{
    if ([self.drawView toggleEraser]){
        [self.eraseButton setBackgroundColor:[UIColor lightGrayColor]];
    }
    else{
        [self.eraseButton setBackgroundColor:[UIColor groupTableViewBackgroundColor]];
    }
}

#pragma mark - Adding/Removing Pickers

- (void)addColorPickerToScreen{
    self.colorPicker = [[ColorPickerViewController alloc] initWithNibName:nil bundle:nil];
    self.colorPicker.delegate = self;
    self.colorPicker.currentColor = self.drawView.currentDrawing.color;
    [self addChildViewController: self.colorPicker];
    [self addViewWithFadeIn:self.colorPicker.view];
}

- (void)dismissColorPicker{
    [UIView animateWithDuration:.5 animations:^{
        [self.colorPicker.view setAlpha:0];
    } completion:^(BOOL finished) {
        [self.colorPicker removeFromParentViewController];
        [self.colorPicker.view removeFromSuperview];
        self.colorPicker = nil;
    }];
}

- (void)addBrushPickerToScreen{
    self.brushPicker = [[BrushPickerViewController alloc] initWithNibName:nil bundle:nil];
    self.brushPicker.delegate = self;
    self.brushPicker.currentWidth = self.drawView.currentDrawing.lineWidth;
    [self addChildViewController: self.brushPicker];
    [self addViewWithFadeIn:self.brushPicker.view];
}

- (void)dismissBrushPicker{
    [UIView animateWithDuration:.5 animations:^{
        [self.brushPicker.view setAlpha:0];
    } completion:^(BOOL finished) {
        [self.brushPicker removeFromParentViewController];
        [self.brushPicker.view removeFromSuperview];
        self.brushPicker = nil;
    }];
}

- (void)addViewWithFadeIn:(UIView *)view{
    [view setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.colorButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:-60];
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:60];
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0 constant:16];
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-16];
    
    view.alpha = 0;
    [self.view addSubview:view];
    [self.view addConstraints:@[bottom, top, leading, trailing]];
    
    [UIView animateWithDuration:.5 animations:^{
        view.alpha = 1.0;
    }];
}

#pragma mark - ColorPicker Delegate

- (void) colorPicker:(ColorPickerViewController *)colorPicker didSelectColor:(UIColor *)color{
    [self.drawView setCurrentColor:color];
    [self.colorButton setBackgroundColor:color];
    [self dismissColorPicker];
}

#pragma mark - BrushPicker Delegate

- (void) brushPicker:(BrushPickerViewController *)brushPicker didSelectWidth:(CGFloat)lineWidth{
    [self.drawView setCurrentLineWidth:lineWidth];
    [self dismissBrushPicker];
}

@end
