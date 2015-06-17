//
//  ColorCollectionViewCell.m
//  PARDrawing
//
//  Created by Paul Rolfe on 6/17/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import "ColorCollectionViewCell.h"

@implementation ColorCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    self.layer.cornerRadius = .5 * self.bounds.size.height;
    self.layer.borderWidth = 4;
}

- (void) setupWithColor:(UIColor *)color{
    self.backgroundColor = color;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.layer.borderColor = selected? [UIColor darkGrayColor].CGColor : [UIColor clearColor].CGColor;
}


@end
