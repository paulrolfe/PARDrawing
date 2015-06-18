//
//  ColorPickerViewController.m
//  PARDrawing
//
//  Created by Paul Rolfe on 6/17/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "ColorCollectionViewCell.h"
#import "AppDelegate.h"
#import "AddColorsViewController.h"
#import "UIColor+colorFromDictionary.h"

@interface ColorPickerViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;


@end

@implementation ColorPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.collectionView registerNib:[UINib nibWithNibName:@"ColorCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"colorCell"];
    [self.view.layer setCornerRadius:15];
    [self.view.layer setBorderWidth:2];
    [self.view.layer setBorderColor:[UIColor blackColor].CGColor];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    [self.collectionView reloadData];
}

#pragma mark - CollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self allColors].count + 1; //plus one for the "Add button"
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ColorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colorCell" forIndexPath:indexPath];
    
    if (indexPath.row == [self allColors].count){
        [cell setupAsAddButton];
    }
    else{
        [cell setupWithColor:[self allColors][indexPath.row]];
        [cell setSelected:CGColorEqualToColor(self.currentColor.CGColor, ((UIColor *)[self allColors][indexPath.row]).CGColor)];
    }
    
    
    return cell;
}

#pragma mark - CollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == [self allColors].count){
        [self goToColorAdder];
    }
    else{
        [self.delegate colorPicker:self didSelectColor:[self allColors][indexPath.row]];
    }
}

#pragma mark - Navigation

- (void)goToColorAdder{
    AddColorsViewController *colorVC = [[AddColorsViewController alloc] initWithNibName:nil bundle:nil];
    colorVC.currentColor = self.currentColor;
    [self presentViewController:colorVC animated:YES completion:nil];
}

#pragma mark - Colors

- (NSArray *)basicArrayOfColors{
    NSArray *colorArray = @[[UIColor redColor],
                            [UIColor orangeColor],
                            [UIColor yellowColor],
                            [UIColor greenColor],
                            [UIColor cyanColor],
                            [UIColor blueColor],
                            [UIColor magentaColor],
                            [UIColor purpleColor],
                            [UIColor brownColor],
                            [UIColor grayColor],
                            [UIColor blackColor]
                            ];
    
    return colorArray;
}

- (NSMutableArray *)allColors{
    NSMutableArray *allColors = [[NSMutableArray alloc] initWithArray:[self basicArrayOfColors]];
    NSString *filePath = [NSString stringWithFormat:@"%@/custom_colors",[AppDelegate applicationDocumentsDirectory]];
    NSArray *savedColors = [[NSArray alloc] initWithContentsOfFile:filePath];
    for (NSDictionary *color in savedColors){
        [allColors addObject:[UIColor colorFromDictionary:color]];
    }
    return allColors;
}


@end
