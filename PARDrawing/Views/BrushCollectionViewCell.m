//
//  BrushCollectionViewCell.m
//  PARDrawing
//
//  Created by Paul Rolfe on 6/17/15.
//  Copyright (c) 2015 Paul Rolfe. All rights reserved.
//

#import "BrushCollectionViewCell.h"

@interface BrushCollectionViewCell ()

@property (nonatomic, weak) IBOutlet UIView *circleView;

@end

@implementation BrushCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.contentView.layer setCornerRadius:5];
    [self.contentView.layer setBorderWidth:4];
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
}

- (void)setupWithLineWidth:(CGFloat)lineWidth{
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, lineWidth, lineWidth)];
    [circleView setTranslatesAutoresizingMaskIntoConstraints:NO];
    circleView.layer.cornerRadius = lineWidth/2;
    circleView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:circleView];

    [circleView addConstraint:[NSLayoutConstraint constraintWithItem:circleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:lineWidth]];
    [circleView addConstraint:[NSLayoutConstraint constraintWithItem:circleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:lineWidth]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:circleView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:circleView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.contentView.layer.borderColor = selected? [UIColor darkGrayColor].CGColor : [UIColor clearColor].CGColor;
}

- (void)prepareForReuse{
    for (UIView *subview in self.contentView.subviews){
        [subview removeFromSuperview];
    }
}

@end
