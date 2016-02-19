//
//  ZKRColumnsViewCell.m
//  Zaker-C
//
//  Created by GuangliChan on 16/2/19.
//  Copyright © 2016年 GLChen. All rights reserved.
//

#import "ZKRColumnsViewCell.h"
#import "ZKRFunCellItem.h"
#import "UIImageView+WebCache.h"

@interface ZKRColumnsViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation ZKRColumnsViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.layoutMargins = UIEdgeInsetsMake(5, 0, 0, 0);
//    self.backgroundColor = [UIColor whiteColor];
}

- (void)setFrame:(CGRect)frame
{
//    frame.origin.y += 3;
    frame.size.height -= 3;
    
    [super setFrame:frame];
}

#pragma mark - ---| item |---
- (void)setCellItem:(ZKRFunCellItem *)cellItem
{
    _cellItem = cellItem;
    
    self.titleLabel.text = cellItem.title;
    self.contentLabel.text = cellItem.content;
    
    [self.bgImageView sd_setImageWithURL:[NSURL URLWithString:cellItem.pic[@"url"]]];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
@end
