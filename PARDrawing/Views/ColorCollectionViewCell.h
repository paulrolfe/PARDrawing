//
//  ColorCollectionViewCell.h
//  PARDrawing
//
//  Created by Paul Rolfe on 6/17/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorCollectionViewCell : UICollectionViewCell

- (void) setupWithColor:(UIColor *)color;
- (void) setupAsAddButton;

@end
