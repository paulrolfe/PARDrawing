//
//  ColorPickerViewController.m
//  PARDrawing
//
//  Created by Paul Rolfe on 6/17/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import "ColorPickerViewController.h"
#import "ColorCollectionViewCell.h"

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
}

#pragma mark - CollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self basicArrayOfColors].count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ColorCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"colorCell" forIndexPath:indexPath];
    
    [cell setupWithColor:[self basicArrayOfColors][indexPath.row]];
    [cell setSelected:CGColorEqualToColor(self.currentColor.CGColor, ((UIColor *)[self basicArrayOfColors][indexPath.row]).CGColor)];
    
    
    return cell;
}

#pragma mark - CollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate colorPicker:self didSelectColor:[self basicArrayOfColors][indexPath.row]];
}

- (NSArray *)basicArrayOfColors{
    NSArray *colorArray = @[[UIColor redColor],
                            [UIColor orangeColor],
                            [UIColor yellowColor],
                            [UIColor greenColor],
                            [UIColor blueColor],
                            [UIColor purpleColor],
                            [UIColor blackColor]
                            ];
    
    return colorArray;
}


@end
