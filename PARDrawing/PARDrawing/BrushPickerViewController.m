//
//  BrushPickerViewController.m
//  PARDrawing
//
//  Created by Paul Rolfe on 6/17/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import "BrushPickerViewController.h"
#import "BrushCollectionViewCell.h"

@interface BrushPickerViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation BrushPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.collectionView registerNib:[UINib nibWithNibName:@"BrushCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"brushCell"];
    [self.view.layer setCornerRadius:15];
    [self.view.layer setBorderWidth:2];
    [self.view.layer setBorderColor:[UIColor blackColor].CGColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BrushCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"brushCell" forIndexPath:indexPath];
    
    [cell setupWithLineWidth:[self lineWidthForRow:indexPath.row]];
    BOOL floatsAreEqual = [self lineWidthForRow:indexPath.row] == self.currentWidth;
    [cell setSelected:floatsAreEqual];
    
    return cell;
}

#pragma mark - CollectionView Delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self.delegate brushPicker:self didSelectWidth:[self lineWidthForRow:indexPath.row]];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([self lineWidthForRow:indexPath.row] > 60){
        return CGSizeMake([self lineWidthForRow:indexPath.row], [self lineWidthForRow:indexPath.row]);
    }
    else{
        return CGSizeMake(60, 60);
    }
}

- (CGFloat)lineWidthForRow:(NSInteger)row{
    return (CGFloat)(row * 4 + 2);
}

@end
