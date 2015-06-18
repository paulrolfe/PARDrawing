//
//  AddColorsViewController.m
//  PARDrawing
//
//  Created by Paul Rolfe on 6/18/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import "AddColorsViewController.h"
#import "AppDelegate.h"
#import <HRColorMapView.h>
#import "UIColor+colorFromDictionary.h"
#import <HRHSVColorUtil.h>


@interface AddColorsViewController ()
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *currentColorDisplayView;
@property (weak, nonatomic) IBOutlet UIButton *useColorButton;
@property (weak, nonatomic) IBOutlet HRColorMapView *colorPickerView;
@property (weak, nonatomic) IBOutlet UILabel *opacityLabel;
@property (weak, nonatomic) IBOutlet UISlider *opacitySlider;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;


@end

@implementation AddColorsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.currentColorDisplayView setBackgroundColor:self.currentColor];
    self.colorPickerView.saturationUpperLimit = @.9;
    self.colorPickerView.tileSize = @4;
    self.colorPickerView.color = self.currentColor;
    
    //get starting alpha
    CGFloat alpha;
    [self.currentColor getWhite:nil alpha:&alpha];
    self.opacitySlider.value = alpha;
    
    //get starting brightness
    self.brightnessSlider.value = .8;
    self.colorPickerView.brightness = .8;

}

#pragma mark - IBActions

- (IBAction)colorDidChange:(HRColorMapView *)pickerView{
    UIColor *rawColor = pickerView.color;
    CGColorRef newColor = CGColorCreateCopyWithAlpha(rawColor.CGColor, self.opacitySlider.value);
    self.currentColor = [UIColor colorWithCGColor:newColor];
    [self.currentColorDisplayView setBackgroundColor:self.currentColor];
}

- (IBAction)opacityValueChanged:(UISlider *)sender {
    CGColorRef newColor = CGColorCreateCopyWithAlpha(self.currentColor.CGColor, sender.value);
    self.currentColor = [UIColor colorWithCGColor:newColor];
    [self.currentColorDisplayView setBackgroundColor:self.currentColor];
}

- (IBAction)brightnessValueChanged:(UISlider *)sender {
    self.colorPickerView.brightness = sender.value;
    HRHSVColor currentHsvColor;
    HSVColorFromUIColor(self.currentColor, &currentHsvColor);
    currentHsvColor.v = sender.value;
    self.currentColor = [UIColor colorWithHue:currentHsvColor.h saturation:currentHsvColor.s brightness:currentHsvColor.v alpha:self.opacitySlider.value];
    self.colorPickerView.color = self.currentColor;
    [self.currentColorDisplayView setBackgroundColor:self.currentColor];
}

- (IBAction)useColorTouched:(id)sender {
    //Save the color to our docs.
    [self saveCurrentColorToFile];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelTouched:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Save to file

- (void)saveCurrentColorToFile{
    NSString *filePath = [NSString stringWithFormat:@"%@/custom_colors",[AppDelegate applicationDocumentsDirectory]];
    NSMutableArray *savedColors = [[NSMutableArray alloc] initWithContentsOfFile:filePath];
    if (!savedColors)
        savedColors = [[NSMutableArray alloc] init];
    [savedColors addObject:[self.currentColor dictionaryWithRGBAValues]];
    [savedColors writeToFile:filePath atomically:YES];
}

@end
