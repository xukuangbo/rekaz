//
//  ZKRHotTableViewCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/21.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRHotTableViewCell.h"
#import "ZKRHotCellItem.h"
#import "UIImageView+WebCache.h"

@interface ZKRHotTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *typeImageLeftConstraint;

@end


@implementation ZKRHotTableViewCell



- (void)awakeFromNib {
    // Initialization code
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.cellImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.cellImageView.clipsToBounds = YES;
    
    self.typeImageView.contentMode = UIViewContentModeScaleAspectFit;
    
//    if ([self.titleLabel.text isEqualToString:@""]) {
//        self.typeImageLeftConstraint.constant = -20;
//        [self updateConstraintsIfNeeded];
//    }
}

- (void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    [super setFrame:frame];
}

#pragma mark - ---| item |---
- (void)setCellItem:(ZKRHotCellItem *)cellItem
{
    _cellItem = cellItem;
    
    self.titleLabel.text = _cellItem.title;
    self.authorLabel.text = _cellItem.auther_name;
//    self.timeLabel.text = _cellItem.date;
    self.timeLabel.text = @"32分钟前";
    
    if (_cellItem.thumbnail_medias.count) {
        [self.cellImageView sd_setImageWithURL:[NSURL URLWithString:_cellItem.thumbnail_medias[0][@"url"]]];
    }
    
    if (_cellItem.special_info[@"icon_url"]) {
        [self.typeImageView sd_setImageWithURL:[NSURL URLWithString:_cellItem.special_info[@"icon_url"]]];
        self.typeImageView.hidden = NO;
        self.timeLabel.text = _cellItem.date;
    } else {
        self.typeImageView.hidden = YES;
        self.timeLabel.text = @"32分钟前";
    }
    
    if (!_cellItem.title) {
        //改变typeImage左约束
//        self.typeImageLeftConstraint.constant = 50;
//        [self updateConstraintsIfNeeded];
    } else {
//        self.typeImageLeftConstraint.constant = 0;
    }
//    [self updateConstraintsIfNeeded];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //    [super setSelected:selected animated:animated];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
@end
